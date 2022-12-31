unit uSearchZipCode.Lib;

interface

uses
  FireDAC.Comp.Client;

type
  TResponseData = record
    Zipcode: string;
    Address: string;
    District: string;
    City: string;
    State: string;
    Country: string;
    CityIbgeCode: string;
    StateIbgeCode: string;
    CountryIbgeCode: string;
  end;

  ISearchZipcodeLib = interface
    ['{272CE2E6-1D2C-4731-B3DF-6D6BA650B5C0}']

    function Execute: ISearchZipcodeLib;
    function ResponseData: TResponseData;
    function ResponseError: String;
  end;

  TSearchZipcodeLib = class(TInterfacedObject, ISearchZipcodeLib)
  protected
    FZipcode: String;
    FUrl: String;
    FMemTable: TFDMemTable;
    FResponseData: TResponseData;
    FResponseError: String;
  private
    function ValidateZipcode: ISearchZipcodeLib;
    function DoRequest: ISearchZipCodeLib;
    function DoFillResponseData: TSearchZipCodeLib;
    function RemoveDots(Str: String): String;
  public
    constructor Create(AZipcode: String);
    destructor Destroy; override;
    class function Make(AZipcode: String): ISearchZipcodeLib;

    function Execute: ISearchZipcodeLib;
    function ResponseData: TResponseData;
    function ResponseError: String;
  end;

implementation

uses
  RESTRequest4D,
  System.SysUtils;

{ TSearchZipcodeLib }

constructor TSearchZipcodeLib.Create(AZipcode: String);
begin
  FMemTable := TFDMemTable.Create(nil);
  FZipcode  := AZipcode;
  FUrl      := 'viacep.com.br/ws/'+FZipcode.Trim+'/json/';
end;

destructor TSearchZipcodeLib.Destroy;
begin
  if Assigned(FMemTable) then FreeAndNil(FMemTable);
  inherited;
end;

function TSearchZipcodeLib.DoFillResponseData: TSearchZipCodeLib;
begin
  Result := Self;

  // Preencher campos com o retorno
  if Assigned(FMemTable.FindField('logradouro')) then
    FResponseData.Address := FMemTable.FieldByName('logradouro').AsString.Trim;

  if Assigned(FMemTable.FindField('bairro')) then
    FResponseData.District := FMemTable.FieldByName('bairro').AsString.Trim;

  if Assigned(FMemTable.FindField('localidade')) then
    FResponseData.City := FMemTable.FieldByName('localidade').AsString.Trim;

  if Assigned(FMemTable.FindField('uf')) then
    FResponseData.State := FMemTable.FieldByName('uf').AsString.Trim;

  if Assigned(FMemTable.FindField('ibge')) then
    FResponseData.CityIbgeCode  := FMemTable.FieldByName('ibge').AsString.Trim;

  FResponseData.ZipCode         := FZipCode.Trim;
  FResponseData.Country         := 'Brasil';
  FResponseData.CountryIbgeCode := '1058';
  FResponseData.StateIbgeCode   := Copy(FResponseData.CityIbgeCode.Trim,1,2);
end;

function TSearchZipcodeLib.DoRequest: ISearchZipCodeLib;
var
  lResponse: IResponse;
begin
  // Efetuar Requisição
  try
    lResponse := TRequest.New.BaseURL(FUrl)
      .Accept('application/json')
      .DataSetAdapter(FMemTable)
      .Get;
  except on E: Exception do
    begin
      FResponseError := 'Falha na consulta do Cep: '+FZipcode+'. '+E.Message+'['+E.ClassName+']';
      Exit;
    end;
  end;

  // Resposta da requisição
  if (lResponse.StatusCode <> 200) or (Assigned(FMemTable.FindField('erro'))) then
  begin
    FResponseError := 'Cep ' + FZipcode + ' não encontrado.';
    Exit;
  end;

  // Preencher retorno
  DoFillResponseData;
end;

function TSearchZipcodeLib.RemoveDots(Str: String): String;
var
  i: Integer;
  xStr: String;
begin
  xStr := '';
  for I := 1 to Length(Trim(Str)) do
    if (Pos(Copy(str,i,1),'/-.)(,|')=0) then xStr := xStr + str[i];

  xStr := StringReplace(xStr, ' ','',[rfReplaceAll]);

  Result := xStr.Trim;
end;


function TSearchZipcodeLib.ResponseData: TResponseData;
begin
  Result := FResponseData;
end;

function TSearchZipcodeLib.ResponseError: String;
begin
  Result := FResponseError;
end;

function TSearchZipcodeLib.ValidateZipcode: ISearchZipcodeLib;
begin
  // Validar Cep
  FZipCode := Copy(RemoveDots(FZipCode),1,8);
  If not (Length(FZipCode) = 8) then
  begin
    FResponseError := 'Cep ' + FZipcode + ' é Inválido.';
    Exit;
  end;
end;

function TSearchZipcodeLib.Execute: ISearchZipcodeLib;
begin
  Result := Self;
  FResponseError := EmptyStr;

  // Validar Cep
  ValidateZipcode;
  if not FResponseError.IsEmpty then
    Exit;

  // Efetuar Requisição
  DoRequest;
end;

class function TSearchZipcodeLib.Make(AZipcode: String): ISearchZipcodeLib;
begin
  Result := Self.Create(AZipcode);
end;

end.
