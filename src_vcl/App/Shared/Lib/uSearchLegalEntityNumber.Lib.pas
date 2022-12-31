unit uSearchLegalEntityNumber.Lib;

interface

uses
  System.Classes,
  FireDAC.Comp.Client;

type
  TResponseData = Record
    Name: String;
    AliasName: String;
    ZipCode: String;
    Address: String;
    AddressNumber: String;
    District: String;
    Complement: String;
    City: String;
    State: String;
    Phone: String;
    Email: String;
    Opening: String;
    MainActivityDescription: String;
    Situation: String;
    SituationDate: String;
    Size: String;
  end;

  ISearchLegalEntityNumberLib = interface
    ['{DF03F7A9-A381-4E34-BA7F-4AD97F7F27CE}']

    function Execute: ISearchLegalEntityNumberLib;
    function ResponseData: TResponseData;
    function ResponseError: String;
  end;

  TSearchLegalEntityNumberLib = class(TInterfacedObject, ISearchLegalEntityNumberLib)
  protected
    FLegalEntityNumber: String;
    FUrl: String;
    FMemTable: TFDMemTable;
    FResponseData: TResponseData;
    FResponseError: String;
  private
    function ValidateLegalEntityNumber: ISearchLegalEntityNumberLib;
    function DoRequest: ISearchLegalEntityNumberLib;
    function DoFillResponseData: ISearchLegalEntityNumberLib;
    function FormatName(sNome: String): string;
    function RemoveDots(Str: String): String;
    function FormatPhone(pFone: String): String;
    function IsLegalEntityNumberValid(Dado: string): Boolean;
  public
    constructor Create(ALegalEntityNumber: String);
    destructor Destroy; override;
    class function Make(ALegalEntityNumber: String): ISearchLegalEntityNumberLib;

    function Execute: ISearchLegalEntityNumberLib;
    function ResponseData: TResponseData;
    function ResponseError: String;
  end;

implementation

uses
  RESTRequest4D,
  System.SysUtils,
  System.MaskUtils;

const
  TOO_MANY_REQUESTS = 'too many requests';

{ TSearchLegalEntityNumberLib }

constructor TSearchLegalEntityNumberLib.Create(ALegalEntityNumber: String);
begin
  FMemTable := TFDMemTable.Create(nil);
  FLegalEntityNumber      := RemoveDots(ALegalEntityNumber.Trim);
  FUrl      := 'https://receitaws.com.br/v1/cnpj/' + FLegalEntityNumber;
end;

destructor TSearchLegalEntityNumberLib.Destroy;
begin
  if Assigned(FMemTable) then FreeAndNil(FMemTable);
  inherited;
end;

function TSearchLegalEntityNumberLib.DoFillResponseData: ISearchLegalEntityNumberLib;
begin
  Result := Self;

  if Assigned(FMemTable.FindField('nome')) then
    FResponseData.Name := FormatName(FMemTable.FieldByName('nome').AsString.Trim);

  if Assigned(FMemTable.FindField('fantasia')) then
    FResponseData.AliasName := FormatName(FMemTable.FieldByName('fantasia').AsString.Trim);

  if Assigned(FMemTable.FindField('cep')) then
    FResponseData.ZipCode := RemoveDots(FMemTable.FieldByName('cep').AsString.Trim);

  if Assigned(FMemTable.FindField('logradouro')) then
    FResponseData.Address := FormatName(FMemTable.FieldByName('logradouro').AsString.Trim);

  if Assigned(FMemTable.FindField('numero')) then
    FResponseData.AddressNumber := FMemTable.FieldByName('numero').AsString.Trim;

  if Assigned(FMemTable.FindField('bairro')) then
    FResponseData.District := FormatName(FMemTable.FieldByName('bairro').AsString.Trim);

  if Assigned(FMemTable.FindField('complemento')) then
    FResponseData.Complement := FormatName(FMemTable.FieldByName('complemento').AsString.Trim);

  if Assigned(FMemTable.FindField('municipio')) then
    FResponseData.City := FormatName(FMemTable.FieldByName('municipio').AsString.Trim);

  if Assigned(FMemTable.FindField('uf')) then
    FResponseData.State := AnsiUpperCase(FMemTable.FieldByName('uf').AsString.Trim);

  if Assigned(FMemTable.FindField('telefone')) then
    FResponseData.Phone := FormatPhone(FMemTable.FieldByName('telefone').AsString.Trim);

  if Assigned(FMemTable.FindField('email')) then
    FResponseData.Email := AnsiLowerCase(FMemTable.FieldByName('email').AsString.Trim);

  if Assigned(FMemTable.FindField('abertura')) then
    FResponseData.Opening := FMemTable.FieldByName('abertura').AsString.Trim;

  if Assigned(FMemTable.FindField('atividade_principal')) then
    FResponseData.MainActivityDescription := FormatName(FMemTable.FieldByName('atividade_principal').AsString.Trim);

  if Assigned(FMemTable.FindField('situacao')) then
    FResponseData.Situation := FMemTable.FieldByName('situacao').AsString.Trim;

  if Assigned(FMemTable.FindField('data_situacao')) then
    FResponseData.SituationDate := FMemTable.FieldByName('data_situacao').AsString.Trim;

  if Assigned(FMemTable.FindField('porte')) then
    FResponseData.Size := FMemTable.FieldByName('porte').AsString.Trim;
end;

function TSearchLegalEntityNumberLib.DoRequest: ISearchLegalEntityNumberLib;
var
  lResponse: IResponse;
begin
  Result := Self;

  // Efetuar Requisição
  try
    lResponse := TRequest.New.BaseURL(FUrl)
      .Accept('application/json')
      .DataSetAdapter(FMemTable)
      .Get;
  except on E: Exception do
    begin
      FResponseError := 'Falha na consulta do CNPJ: '+FLegalEntityNumber+'. '+E.Message+'['+E.ClassName+']';
      Exit;
    end;
  end;

  // Resposta da requisição
  if (lResponse.StatusCode <> 200) then
  begin
    case Assigned(FMemTable.FindField('message')) of
      True:  FResponseError := FMemTable.FindField('message').AsString;
      False: FResponseError := 'CNPJ ' + FLegalEntityNumber + ' não encontrado.';
    end;

    if (Pos(TOO_MANY_REQUESTS, FResponseError.ToLower) > 0) then
      FResponseError := 'Muitas requisições. Por favor tente mais tarde.';

    Exit;
  end;

  // Preencher retorno
  DoFillResponseData;
end;

function TSearchLegalEntityNumberLib.Execute: ISearchLegalEntityNumberLib;
begin
  Result := Self;
  FResponseError := EmptyStr;

  // Validar LegalEntityNumber
  ValidateLegalEntityNumber;
  if not FResponseError.IsEmpty then
    Exit;

  // Efetuar Requisição
  DoRequest;
end;

function TSearchLegalEntityNumberLib.FormatName(sNome: String): string;
const
  excecao: array[0..5] of string = (' da ', ' de ', ' do ', ' das ', ' dos ', ' e ');
var
  tamanho, j: integer;
  i: byte;
begin
  Result := AnsiLowerCase(sNome);
  tamanho := Length(Result);

  for j := 1 to tamanho do
    // Se é a primeira letra ou se o caracter anterior é um espaço
    if (j = 1) or ((j>1) and (Result[j-1]=Chr(32))) then
      Result[j] := AnsiUpperCase(Result[j])[1];
  for i := 0 to Length(excecao)-1 do
    result:= StringReplace(result,excecao[i],excecao[i],[rfReplaceAll, rfIgnoreCase]);
end;

function TSearchLegalEntityNumberLib.FormatPhone(pFone: String): String;
begin
  pFone  := removeDots(pFone);
  Result := pFone;

  case Length(pFone) of
     8: Result := FormatMaskText('\(00\) 0000\-0000;0;', '00' + pFone);
     9: Result := FormatMaskText('\(00\) 0 0000\-0000;0;', '00' + pFone);
    10: Result := FormatMaskText('\(00\) 0000\-0000;0;', pFone);
    11: Result := FormatMaskText('\(00\) 0 0000\-0000;0;', pFone);
  end;
end;

class function TSearchLegalEntityNumberLib.Make(ALegalEntityNumber: String): ISearchLegalEntityNumberLib;
begin
  Result := Self.Create(ALegalEntityNumber);
end;

function TSearchLegalEntityNumberLib.RemoveDots(Str: String): String;
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

function TSearchLegalEntityNumberLib.ResponseData: TResponseData;
begin
  Result := FResponseData;
end;

function TSearchLegalEntityNumberLib.ResponseError: String;
begin
  Result := FResponseError;
end;

function TSearchLegalEntityNumberLib.IsLegalEntityNumberValid(Dado: string): Boolean;
var
  D1: array[1..12] of byte;
  I, iAux, DF1, DF2, DF3, DF4, DF5, DF6, Resto1, Resto2, PrimeiroDigito,
  SegundoDigito: integer;
begin
  Result := true;

  // Evitar erro de validação entre Android e Windows
  {$IFDEF ANDROID}
    iAux := 1;
  {$ELSE}
    iAux := 0;
  {$ENDIF}

  if Length(Dado) = 14 then
  begin
    for I := 1 to 12 do
      D1[I] := StrToInt(Dado[I-iAux]);

    if Result then
    begin
      DF1 := 0;
      DF2 := 0;
      DF3 := 0;
      DF4 := 0;
      DF5 := 0;
      DF6 := 0;
      Resto1 := 0;
      Resto2 := 0;
      PrimeiroDigito := 0;
      SegundoDigito := 0;
      DF1 := 5*D1[1] + 4*D1[2] + 3*D1[3] + 2*D1[4] + 9*D1[5] + 8*D1[6] +
             7*D1[7] + 6*D1[8] + 5*D1[9] + 4*D1[10] + 3*D1[11] + 2*D1[12];
      DF2 := DF1 div 11;
      DF3 := DF2 * 11;
      Resto1 := DF1 - DF3;
      if (Resto1 = 0) or (Resto1 = 1) then
        PrimeiroDigito := 0
      else
        PrimeiroDigito := 11 - Resto1;

      DF4 := 6*D1[1] + 5*D1[2] + 4*D1[3] + 3*D1[4] + 2*D1[5] + 9*D1[6] +
             8*D1[7] + 7*D1[8] + 6*D1[9] + 5*D1[10] + 4*D1[11] + 3*D1[12] + 2*PrimeiroDigito;
      DF5 := DF4 div 11;
      DF6 := DF5 * 11;
      Resto2 := DF4 - DF6;
      if (Resto2 = 0) or (Resto2 = 1) then
        SegundoDigito := 0
      else
        SegundoDigito := 11 - Resto2;

      if (PrimeiroDigito <> StrToInt(Dado[13-iAux])) or
         (SegundoDigito <> StrToInt(Dado[14-iAux])) then
        Result := false;
    end;
  end else
    if Length(Dado) <> 0 then
      Result := false;
end;

function TSearchLegalEntityNumberLib.ValidateLegalEntityNumber: ISearchLegalEntityNumberLib;
begin
  // Validar LegalEntityNumber
  If not (Length(FLegalEntityNumber) = 14) then
  begin
    FResponseError := 'CNPJ ' + FLegalEntityNumber + ' é Inválido. CNPJ deve conter 14 dígitos.';
    Exit;
  end;

  // Validar LegalEntityNumber
  if not IsLegalEntityNumberValid(FLegalEntityNumber) then
  begin
    FResponseError := 'CNPJ ' + FLegalEntityNumber + ' é Inválido.';
    Exit;
  end;
end;

end.
