unit uFormRequest;

interface

uses
  System.Generics.Collections,
  XSuperObject;

type
  IFormRequest = Interface
    ['{195201E4-7BE8-4D9D-9FF4-7F72F4C318DE}']

    function AddRule(AFieldName: String; ARule: String): IFormRequest;
    function Validate: String;
  end;

  TFormRequest = class(TInterfacedObject, IFormRequest)
  private
    FRules: TDictionary<String, String>;
    FSObj: ISuperObject;
    FPrefix: String;
    constructor Create(AJsonString, APrefix: String);
  public
    destructor Destroy; override;
    class function Make(AJsonString: String; APrefix: String = ''): IFormRequest;

    function AddRule(AFieldName: String; ARule: String): IFormRequest;
    function Validate: String;
  end;

implementation

uses
  System.SysUtils,
  XSuperJSON;

const
  DELIMITED_CHARX = ';';

{ TFormRequest }

function TFormRequest.AddRule(AFieldName, ARule: String): IFormRequest;
begin
  Result := Self;
  FRules.Add(AFieldName, ARule);
end;

constructor TFormRequest.Create(AJsonString, APrefix: String);
begin
  inherited Create;
  FRules  := TDictionary<String, String>.Create;
  FSObj   := SO(AJsonString);
  FPrefix := APrefix;
end;

destructor TFormRequest.Destroy;
begin
  if Assigned(FRules) then FRules.Free;

  inherited;
end;

class function TFormRequest.Make(AJsonString, APrefix: String): IFormRequest;
begin
  Result := Self.Create(AJsonString, APrefix);
end;

function TFormRequest.Validate: String;
var
  lKey: String;
  lIsRequired: Boolean;
  lCheckMin, lCheckMax: Boolean;
  lMin, lMax: Double;
  lAux: String;
  lPos: Integer;
  lPrefix: String;
  lErrors: String;
begin
  lErrors := EmptyStr;
  if not FPrefix.Trim.IsEmpty then
    lPrefix := FPrefix + '.';

  for lKey in FRules.Keys do
  begin
    // Verificar se campo é obrigatório
    lIsRequired := (Pos('required', FRules[lKey]) > 0);
    if lIsRequired and (not FSObj.Check(lKey)) then
      lErrors := lErrors + Format('O Campo [%s] é obrigatório.' + DELIMITED_CHARX, [lPrefix+lKey]);
    if lIsRequired and (FSObj.Check(lKey) and (FSObj[lKey].DataType in [dtNil, dtNull])) then
      lErrors := lErrors + Format('O Campo [%s] é obrigatório.' + DELIMITED_CHARX, [lPrefix+lKey]);

    // Se não existir campo, vai para a próxima chave
    if not (FSObj.Check(lKey)) then
      Continue;

    // Se existir campo, porém valor é nulo, vai para a próxima chave
    if (FSObj.Check(lKey) and (FSObj[lKey].DataType in [dtNil, dtNull])) then
      Continue;

    // Verificar se campo é do tipo string
    if (Pos('string', FRules[lKey]) > 0) and (FSObj[lKey].DataType <> TDataType.dtString) then
      lErrors   := lErrors + Format('O Campo [%s] deve ser do tipo string. Ex: abc...' + DELIMITED_CHARX, [lPrefix+lKey]);

    // Verificar se campo é do tipo double
    if (Pos('double', FRules[lKey]) > 0) and (not (FSObj[lKey].DataType in [TDataType.dtFloat, TDataType.dtInteger])) then
      lErrors := lErrors + Format('O Campo [%s] deve ser do tipo double. Ex: #.##' + DELIMITED_CHARX, [lPrefix+lKey]);

    // Verificar se campo é do tipo integer
    if (Pos('integer', FRules[lKey]) > 0) and (FSObj[lKey].DataType <> TDataType.dtInteger) then
      lErrors := lErrors + Format('O Campo [%s] deve ser do tipo integer. Ex: 012...' + DELIMITED_CHARX, [lPrefix+lKey]);

    // Verificar se campo é do tipo boolean
    if (Pos('boolean', FRules[lKey]) > 0) and (FSObj[lKey].DataType <> TDataType.dtBoolean) then
      lErrors := lErrors + Format('O Campo [%s] deve ser do tipo boolean. Ex: true, false' + DELIMITED_CHARX, [lPrefix+lKey]);

    // Verificar se campo é do tipo DateTime
    if (Pos('datetime', FRules[lKey]) > 0) and (FSObj[lKey].DataType <> TDataType.dtDateTime) then
      lErrors := lErrors + Format('O Campo [%s] deve ser do tipo datetime. Ex: YYYY-MM-DDTHH:MM:SS' + DELIMITED_CHARX, [lPrefix+lKey]);

    // Verificar se campo é do tipo Date
    if (Pos('xdate', FRules[lKey]) > 0) and (FSObj[lKey].DataType <> TDataType.dtDate) then
      lErrors := lErrors + Format('O Campo [%s] deve ser do tipo date. Ex: YYYY-MM-DD' + DELIMITED_CHARX, [lPrefix+lKey]);

    // Verificar se campo é do tipo Time
    if (Pos('xtime', FRules[lKey]) > 0) and (FSObj[lKey].DataType <> TDataType.dtTime) then
      lErrors := lErrors + Format('O Campo [%s] deve ser do tipo time. Ex: HH:MM:SS' + DELIMITED_CHARX, [lPrefix+lKey]);

    // Verificar se campo é do tipo Array
    if (Pos('array', FRules[lKey]) > 0) and (FSObj[lKey].DataType <> TDataType.dtArray) then
      lErrors := lErrors + Format('O Campo [%s] deve ser do tipo array. Ex: []' + DELIMITED_CHARX, [lPrefix+lKey]);

    // Verificar se campo é do tipo Object
    if (Pos('object', FRules[lKey]) > 0) and (FSObj[lKey].DataType <> TDataType.dtObject) then
      lErrors := lErrors + Format('O Campo [%s] deve ser do tipo object. Ex: {}' + DELIMITED_CHARX, [lPrefix+lKey]);

    // Verificar quantidade mínima de caracteres para string
    lCheckMin := (Pos('string', FRules[lKey]) > 0) and (FSObj[lKey].DataType = TDataType.dtString) and (Pos('min', FRules[lKey]) > 0);
    if lCheckMin then
    begin
      lAux := Copy(FRules[lKey], Pos('min', FRules[lKey]));
      lPos := Pos('|', lAux);
      case (lPos = 0) of
        True:  lMin := StrToFloatDef(StringReplace(lAux, 'min:', '', [rfReplaceAll]),0);
        False: lMin := StrToFloatDef(StringReplace(Copy(lAux, 1, lPos-1), 'min:', '', [rfReplaceAll]),0);
      end;
      if (FSObj[lKey].AsString.Length < lMin) then
        lErrors := lErrors + Format('O Campo [%s] deve conter no mínimo %d caracter(es).' + DELIMITED_CHARX, [lPrefix+lKey, Trunc(lMin)]);
    end;

    // Verificar quantidade máxima de caracteres para string
    lCheckMax := (Pos('string', FRules[lKey]) > 0) and (FSObj[lKey].DataType = TDataType.dtString) and (Pos('max', FRules[lKey]) > 0);
    if lCheckMax then
    begin
      lAux := Copy(FRules[lKey], Pos('max', FRules[lKey]));
      lPos := Pos('|', lAux);
      case (lPos = 0) of
        True:  lMax := StrToFloatDef(StringReplace(lAux, 'max:', '', [rfReplaceAll]),0);
        False: lMax := StrToFloatDef(StringReplace(Copy(lAux, 1, lPos-1), 'max:', '', [rfReplaceAll]),0);
      end;
      if (FSObj[lKey].AsString.Length > lMax) then
        lErrors := lErrors + Format('O Campo [%s] deve conter no máximo %d caracter(es).' + DELIMITED_CHARX, [lPrefix+lKey, Trunc(lMax)]);
    end;

    // Verificar quantidade mínima para integer
    lCheckMin := (Pos('integer', FRules[lKey]) > 0) and (FSObj[lKey].DataType = TDataType.dtInteger) and (Pos('min', FRules[lKey]) > 0);
    if lCheckMin then
    begin
      lAux := Copy(FRules[lKey], Pos('min', FRules[lKey]));
      lPos := Pos('|', lAux);
      case (lPos = 0) of
        True:  lMin := StrToFloatDef(StringReplace(lAux, 'min:', '', [rfReplaceAll]),0);
        False: lMin := StrToFloatDef(StringReplace(Copy(lAux, 1, lPos-1), 'min:', '', [rfReplaceAll]),0);
      end;
      if (FSObj[lKey].AsInteger < Trunc(lMin)) then
        lErrors := lErrors + Format('O Campo [%s] deve ser maior ou igual a %d.' + DELIMITED_CHARX, [lPrefix+lKey, Trunc(lMin)]);
    end;

    // Verificar quantidade máxima para integer
    lCheckMax := (Pos('integer', FRules[lKey]) > 0) and (FSObj[lKey].DataType = TDataType.dtInteger) and (Pos('max', FRules[lKey]) > 0);
    if lCheckMax then
    begin
      lAux := Copy(FRules[lKey], Pos('max', FRules[lKey]));
      lPos := Pos('|', lAux);
      case (lPos = 0) of
        True:  lMax := StrToFloatDef(StringReplace(lAux, 'max:', '', [rfReplaceAll]),0);
        False: lMax := StrToFloatDef(StringReplace(Copy(lAux, 1, lPos-1), 'max:', '', [rfReplaceAll]),0);
      end;
      if (FSObj[lKey].AsInteger > Trunc(lMax)) then
        lErrors := lErrors + Format('O Campo [%s] deve ser menor ou igual a %d.' + DELIMITED_CHARX, [lPrefix+lKey, Trunc(lMax)]);
    end;

    // Verificar quantidade mínima para double
    lCheckMin := (Pos('double', FRules[lKey]) > 0)
      and (FSObj[lKey].DataType in [TDataType.dtFloat, TDataType.dtInteger])
      and (Pos('min', FRules[lKey]) > 0);
    if lCheckMin then
    begin
      lAux := Copy(FRules[lKey], Pos('min', FRules[lKey]));
      lPos := Pos('|', lAux);
      case (lPos = 0) of
        True:  Begin
          lAux := StringReplace(lAux, 'min:', '', [rfReplaceAll]);
          lMin := StrToFloatDef(StringReplace(lAux, '.', FormatSettings.DecimalSeparator, [rfReplaceAll]),0);
        end;
        False: Begin
          lAux := StringReplace(Copy(lAux, 1, lPos-1), 'min:', '', [rfReplaceAll]);
          lMin := StrToFloatDef(StringReplace(Copy(lAux, 1, lPos-1), '.', FormatSettings.DecimalSeparator, [rfReplaceAll]),0);
        end;
      end;
      if (FSObj[lKey].AsFloat < lMin) then
        lErrors := lErrors + Format('O Campo [%s] deve ser maior ou igual a %f.' + DELIMITED_CHARX, [lPrefix+lKey, lMin]);
    end;

    // Verificar quantidade mínima para double
    lCheckMax := (Pos('double', FRules[lKey]) > 0)
      and (FSObj[lKey].DataType in [TDataType.dtFloat, TDataType.dtInteger])
      and (Pos('max', FRules[lKey]) > 0);
    if lCheckMax then
    begin
      lAux := Copy(FRules[lKey], Pos('max', FRules[lKey]));
      lPos := Pos('|', lAux);
      case (lPos = 0) of
        True:  Begin
          lAux := StringReplace(lAux, 'max:', '', [rfReplaceAll]);
          lMax := StrToFloatDef(StringReplace(lAux, '.', FormatSettings.DecimalSeparator, [rfReplaceAll]),0);
        end;
        False: Begin
          lAux := StringReplace(Copy(lAux, 1, lPos-1), 'max:', '', [rfReplaceAll]);
          lMax := StrToFloatDef(StringReplace(Copy(lAux, 1, lPos-1), '.', FormatSettings.DecimalSeparator, [rfReplaceAll]),0);
        end;
      end;
      if (FSObj[lKey].AsFloat > lMax) then
        lErrors := lErrors + Format('O Campo [%s] deve ser menor ou igual a %f.' + DELIMITED_CHARX, [lPrefix+lKey, lMax]);
    end;
  end;

  Result := lErrors;
end;

end.
