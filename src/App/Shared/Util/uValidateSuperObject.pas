unit uValidateSuperObject;

interface

uses
  Horse,
  System.Generics.Collections,
  XSuperObject;

type
  IValidateSuperObject = Interface
    ['{3E2C01C7-90BB-4D30-9265-E2D1E74D6681}']
    function AddRule(AFieldName: String; ARule: String): IValidateSuperObject;
    function Execute: String;
  end;

  TValidateSuperObject = class(TInterfacedObject, IValidateSuperObject)
  private
    FSObj: ISuperObject;
    FPrefix: String;
    FRules: TDictionary<String, String>;
    FErrors: String;
    constructor Create(const ASObj: ISuperObject; APrefix: String);
  public
    destructor Destroy; override;
    class function Make(const ASObj: ISuperObject; APrefix: String = ''): IValidateSuperObject;

    function AddRule(AFieldName: String; ARule: String): IValidateSuperObject;
    function Execute: String;
  end;

implementation

uses
  System.SysUtils,
  uApplication.Types,
  XSuperJSON;

{ TValidateSuperObject }

function TValidateSuperObject.AddRule(AFieldName, ARule: String): IValidateSuperObject;
begin
  Result := Self;
  FRules.Add(AFieldName, ARule);
end;

constructor TValidateSuperObject.Create(const ASObj: ISuperObject; APrefix: String);
begin
  inherited Create;
  FSObj   := ASObj;
  FPrefix := APrefix;
  FRules  := TDictionary<String, String>.Create;
end;

destructor TValidateSuperObject.Destroy;
begin
  FRules.Free;
  inherited;
end;

function TValidateSuperObject.Execute: String;
var
  lKey: String;
  lIsRequired: Boolean;
  lCheckMin, lCheckMax: Boolean;
  lMin, lMax: Double;
  lAux: String;
  lPos: Integer;
  lPrefix: String;
begin
  if not FPrefix.Trim.IsEmpty then
    lPrefix := FPrefix + '.';

  for lKey in FRules.Keys do
  begin
    // Verificar se campo é obrigatório
    lIsRequired := (Pos('required', FRules[lKey]) > 0);
    if lIsRequired and (not FSObj.Check(lKey)) then
      FErrors := FErrors + Format('O Campo [%s] é obrigatório.' + DELIMITED_CHAR, [lPrefix+lKey]);
    if lIsRequired and (FSObj.Check(lKey) and (FSObj[lKey].DataType in [dtNil, dtNull])) then
      FErrors := FErrors + Format('O Campo [%s] é obrigatório.' + DELIMITED_CHAR, [lPrefix+lKey]);

    // Se não existir campo, vai para a próxima chave
    if not (FSObj.Check(lKey)) then
      Continue;

    // Se existir campo, porém valor é nulo, vai para a próxima chave
    if (FSObj.Check(lKey) and (FSObj[lKey].DataType in [dtNil, dtNull])) then
      Continue;

    // Verificar se campo é do tipo string
    if (Pos('string', FRules[lKey]) > 0) and (FSObj[lKey].DataType <> TDataType.dtString) then
      FErrors   := FErrors + Format('O Campo [%s] deve ser do tipo string. Ex: abc...' + DELIMITED_CHAR, [lPrefix+lKey]);

    // Verificar se campo é do tipo double
    if (Pos('double', FRules[lKey]) > 0) and (not (FSObj[lKey].DataType in [TDataType.dtFloat, TDataType.dtInteger])) then
      FErrors := FErrors + Format('O Campo [%s] deve ser do tipo double. Ex: #.##' + DELIMITED_CHAR, [lPrefix+lKey]);

    // Verificar se campo é do tipo integer
    if (Pos('integer', FRules[lKey]) > 0) and (FSObj[lKey].DataType <> TDataType.dtInteger) then
      FErrors := FErrors + Format('O Campo [%s] deve ser do tipo integer. Ex: 012...' + DELIMITED_CHAR, [lPrefix+lKey]);

    // Verificar se campo é do tipo boolean
    if (Pos('boolean', FRules[lKey]) > 0) and (FSObj[lKey].DataType <> TDataType.dtBoolean) then
      FErrors := FErrors + Format('O Campo [%s] deve ser do tipo boolean. Ex: true, false' + DELIMITED_CHAR, [lPrefix+lKey]);

    // Verificar se campo é do tipo DateTime
    if (Pos('datetime', FRules[lKey]) > 0) and (FSObj[lKey].DataType <> TDataType.dtDateTime) then
      FErrors := FErrors + Format('O Campo [%s] deve ser do tipo datetime. Ex: YYYY-MM-DDTHH:MM:SS' + DELIMITED_CHAR, [lPrefix+lKey]);

    // Verificar se campo é do tipo Date
    if (Pos('xdate', FRules[lKey]) > 0) and (FSObj[lKey].DataType <> TDataType.dtDate) then
      FErrors := FErrors + Format('O Campo [%s] deve ser do tipo date. Ex: YYYY-MM-DD' + DELIMITED_CHAR, [lPrefix+lKey]);

    // Verificar se campo é do tipo Time
    if (Pos('xtime', FRules[lKey]) > 0) and (FSObj[lKey].DataType <> TDataType.dtTime) then
      FErrors := FErrors + Format('O Campo [%s] deve ser do tipo time. Ex: HH:MM:SS' + DELIMITED_CHAR, [lPrefix+lKey]);

    // Verificar se campo é do tipo Array
    if (Pos('array', FRules[lKey]) > 0) and (FSObj[lKey].DataType <> TDataType.dtArray) then
      FErrors := FErrors + Format('O Campo [%s] deve ser do tipo array. Ex: []' + DELIMITED_CHAR, [lPrefix+lKey]);

    // Verificar se campo é do tipo Object
    if (Pos('object', FRules[lKey]) > 0) and (FSObj[lKey].DataType <> TDataType.dtObject) then
      FErrors := FErrors + Format('O Campo [%s] deve ser do tipo object. Ex: {}' + DELIMITED_CHAR, [lPrefix+lKey]);

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
        FErrors := FErrors + Format('O Campo [%s] deve conter no mínimo %d caracter(es).' + DELIMITED_CHAR, [lPrefix+lKey, Trunc(lMin)]);
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
        FErrors := FErrors + Format('O Campo [%s] deve conter no máximo %d caracter(es).' + DELIMITED_CHAR, [lPrefix+lKey, Trunc(lMax)]);
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
        FErrors := FErrors + Format('O Campo [%s] deve ser maior ou igual a %d.' + DELIMITED_CHAR, [lPrefix+lKey, Trunc(lMin)]);
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
        FErrors := FErrors + Format('O Campo [%s] deve ser menor ou igual a %d.' + DELIMITED_CHAR, [lPrefix+lKey, Trunc(lMax)]);
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
        FErrors := FErrors + Format('O Campo [%s] deve ser maior ou igual a %f.' + DELIMITED_CHAR, [lPrefix+lKey, lMin]);
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
        FErrors := FErrors + Format('O Campo [%s] deve ser menor ou igual a %f.' + DELIMITED_CHAR, [lPrefix+lKey, lMax]);
    end;
  end;

  Result := FErrors;
end;

class function TValidateSuperObject.Make(const ASObj: ISuperObject; APrefix: String): IValidateSuperObject;
begin
  Result := Self.Create(ASObj, APrefix);
end;

end.
