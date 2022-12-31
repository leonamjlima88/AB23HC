unit uHlp;

interface

uses
  Data.DB,
  System.Classes;

type
  TSide = (sdLeft, sdRight, sdCenter);

  THlp = class
  public
    class function  If0RetNull(AValue: Int64): String;
    class function  StateList: TArray<String>; // Lista de Estados
    class function  CpfOrCnpjIsValid(AValue: string): boolean;
    class function  CpfIsValid(AValue: string): boolean;
    class function  CnpjIsValid(AValue: string): boolean;
    class function  BodyIsEmpty(ABody: String): Boolean;
    class function  Space(N: integer): string; // Prencher espaÁos
    class function  SpaceStr(AContent: String; ALength: integer; ASide: TSide): string; // Prencher espaÁos
    class function  Repl(AValue: String; ALength: Integer): String; // Reproduz um string varias vezes
    class function  EmailIsValid(AEmail: String): Boolean;
    class function  AlignTextMargin(AValue: String; ALength: Integer; ASide: TSide): String; // 1-Esquerda 2-Direita 3-Centro
    class function  IsJuridicaDoc(AValue: String): Boolean;
    class function  FormatZipCode(AValue: String): string; // Formatar Cep
    class function  dayOfWeekStr(Data:TDateTime): string;
    class procedure parseDelimited(const sl: TStrings; const value, delimiter: string); // explode em string com caracter
    class function  createGuid: String; // Gerador de GUID
    class function  FormatPhone(pFone: String): String; // Formatar n˙mero de telefone
    class function  RemoveDots(Str: String): String; // Remover Pontos da String
    class function  OnlyNumbers(fField: String): String; // Retornar apenas n˙meros de uma string
    class function  ValidateCpfCnpj(Dado: string): String; // Validar CNPJ/CNPJ
    class function  ValidateCnpj(Dado: string): Boolean; // Validar CNPJ
    class function  ValidateCpf(Dado: string): Boolean; // Validar CPF
    class function  Encrypt(const AKey, AText: String): String;
    class function  Decrypt(const AKey, AText: String): String;
    class function  BoolInt(AValue: Boolean): Integer;
    class function  IntBool(AValue: Integer): Boolean;
    class function  FormatDateDefault(AValue: TDate): String;
    class function  FormatDateTimeWithLastHour(AValue: TDateTime): String;
    class function  FormatDateTimeWithFirstHour(AValue: TDateTime): String;
    class function  SetDateTimeWithLastHour(AValue: TDateTime): TDateTime;
    class function  SetDateTimeWithFirstHour(AValue: TDateTime): TDateTime;
    class function  StrZero(Conteudo: String; Tamanho: Integer): String;
    class function  StrInt(AValue: String; ADefaultValue: Integer = 0): Integer;
    class function  StrFloat(AValue: String; ADefaultValue: Double = 0): Double;
    class procedure FormatDataSet(ADataSet: TDataSet; ADecimalPlaces: Integer = 2); // Formata Campos do DataSet
    class procedure FillDataSetWithZero(ADataSet: TDataSet; AValueInteger: Boolean = true; AValueDouble: Boolean = true);
    class function  Iif(aCondition: Boolean; aResultTrue, aResultFalse: variant): variant; // Simula operador tern·rio
    class function  RemoveAccentedChars(AValue: String): String; // Remover caracteres acentuados
  end;

implementation

uses
  System.SysUtils,
  System.Dateutils,
  System.MaskUtils, System.Variants;

{ THlp }

class function THlp.AlignTextMargin(AValue: String; ALength: Integer; ASide: TSide): String;
begin
  AValue := AValue.Trim;
  if Length(AValue) > ALength then
    AValue := Copy(AValue,1,ALength);
  case ASide of
    sdLeft: while Length(AValue) < ALength do AValue := AValue + ' ';
    sdRight: while Length(AValue) < ALength do AValue := ' ' + AValue;
    sdCenter: while Length(AValue) < ALength do
                if (Length(AValue) mod 2)= 0 then
                   AValue := AValue + ' ' else AValue := ' ' + AValue;
  end;
  Result := AValue;
end;

class function THlp.BodyIsEmpty(ABody: String): Boolean;
begin
  Result := (ABody = '{}') or (ABody.Trim.IsEmpty);
end;

class function THlp.BoolInt(AValue: Boolean): Integer;
begin
  case AValue of
    True:  Result := 1;
    False: Result := 0;
  end;
end;

class function THlp.CnpjIsValid(AValue: string): boolean;
var
  n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,n12:integer;
  d1,d2:integer;
  digitado, calculado:string;
begin
  AValue := OnlyNumbers(AValue);

  n1:= strtoint(AValue[1]);
  n2:= strtoint(AValue[2]);
  n3:= strtoint(AValue[3]);
  n4:= strtoint(AValue[4]);
  n5:= strtoint(AValue[5]);
  n6:= strtoint(AValue[6]);
  n7:= strtoint(AValue[7]);
  n8:= strtoint(AValue[8]);
  n9:= strtoint(AValue[9]);
  n10:= strtoint(AValue[10]);
  n11:= strtoint(AValue[11]);
  n12:= strtoint(AValue[12]);
  d1:= n12*2+n11*3+n10*4+n9*5+n8*6+n7*7+n6*8+n5*9+
  n4*2+n3*3+n2*4+n1*5;
  d1:= 11-(d1 mod 11);

  if d1>=10 then
    d1:=0;

  d2:=d2*2+ n12*3+n11*4+n10*5+n9*6+n8*7+n7*8+n6*9+
  n5*2+n4*3+n3*4+n2*5+n1*6;
  d2:= 11-(d2 mod 11);

  if d2>=10 then
    d2:=0;

  calculado := inttostr(d1) + inttostr(d2);
  digitado  := AValue[13]+AValue[14];

  Result := calculado = digitado;
end;

class function THlp.CpfIsValid(AValue: string): boolean;
var
  n1,n2,n3,n4,n5,n6,n7,n8,n9:integer;
  d1,d2:integer;
  digitado, calculado:string;
begin
  AValue := OnlyNumbers(AValue);

  n1:= StrToInt(AValue[1]);
  n2:= StrToInt(AValue[2]);
  n3:= StrToInt(AValue[3]);
  n4:= StrToInt(AValue[4]);
  n5:= StrToInt(AValue[5]);
  n6:= StrToInt(AValue[6]);
  n7:= StrToInt(AValue[7]);
  n8:= StrToInt(AValue[8]);
  n9:= StrToInt(AValue[9]);
  d1:= n9*2+n8*3+n7*4+n6*5+n5*6+n4*7+n3*8+n2*9+n1*10;
  d1:= 11-(d1 mod 11);

  if d1>=10 then
    d1:=0;

  d2:= d1*2+n9*3+n8*4+n7*5+n6*6+n5*7+n4*8+n3*9+n2*10+n1*11;
  d2:= 11-(d2 mod 11);

  if d2>=10 then
    d2:=0;

  calculado:= inttostr(d1)+inttostr(d2);
  digitado:= AValue[10]+AValue[11];

  Result := calculado = digitado;
end;

class function THlp.CPFOrCnpjIsValid(AValue: string): boolean;
var
  lIsCPF: Boolean;
begin
  AValue := OnlyNumbers(AValue);
  lIsCPF := AValue.Length <= 11;
  case lIsCPF of
    True:  Result := CpfIsValid(AValue);
    False: Result := CnpjIsValid(AValue);
  end;
end;

class function THlp.createGuid: String;
const
  L_CHARS_TO_REMOVE: TArray<String> = ['[',']','{','}'];
var
  lI: Integer;
begin
  Result := TGUID.NewGuid.ToString;
  for lI := 0 to High(L_CHARS_TO_REMOVE) do
    Result := StringReplace(Result, L_CHARS_TO_REMOVE[lI], '', [rfReplaceAll]);
end;

class function THlp.dayOfWeekStr(Data: TDateTime): string;
begin
  case DayOfWeek(Data) of
    1: Result := 'Domingo';
    2: Result := 'Segunda';
    3: Result := 'TerÁa';
    4: Result := 'Quarta';
    5: Result := 'Quinta';
    6: Result := 'Sexta';
    7: Result := 'S·bado';
  end;
end;

class function THlp.Decrypt(const AKey, AText: String): String;
var
  I: Integer;
  C: Char;
begin
  Result := '';
  for I := 0 to Length(AText) div 2 - 1 do
  begin
    C := Chr(StrToIntDef('$' + Copy(AText, (I * 2) + 1, 2), Ord(' ')));
    if Length(AKey) > 0 then
      C := Chr(Byte(AKey[1 + (I mod Length(AKey))]) xor Byte(C));
    Result := Result + C;
  end;
end;

class function THlp.EmailIsValid(AEmail: String): Boolean;
begin
  AEmail := Trim(UpperCase(AEmail));
  if Pos('@', AEmail) > 1 then
  begin
    Delete(AEmail, 1, pos('@', AEmail));
    Result := (Length(AEmail) > 0) and (Pos('.', AEmail) > 2);
 end else
    Result := False;
end;

class function THlp.Encrypt(const AKey, AText: String): String;
var
  I: Integer;
  C: Byte;
begin
  Result := '';
  for I := 1 to Length(AText) do
  begin
    if Length(AKey) > 0 then
      C := Byte(AKey[1 + ((I - 1) mod Length(AKey))]) xor Byte(AText[I])
    else
      C := Byte(AText[I]);
    Result := Result + AnsiLowerCase(IntToHex(C, 2));
  end;
end;

class procedure THlp.FillDataSetWithZero(ADataSet: TDataSet; AValueInteger, AValueDouble: Boolean);
var
  lI: Integer;
begin
  for lI := 0 to Pred(ADataSet.Fields.Count) do
  begin
    if (AValueInteger and (ADataSet.Fields[lI].DataType in [ftSmallint, ftInteger])) then
      ADataSet.Fields[lI].AsInteger := 0;

    if (AValueDouble and (ADataSet.Fields[lI].DataType in [ftFloat, ftCurrency, ftBCD])) then
      ADataSet.Fields[lI].AsFloat := 0;
  end;
end;

class procedure THlp.FormatDataSet(ADataSet: TDataSet; ADecimalPlaces: Integer);
Var
  lI: Integer;
  lDecimalPlacesMask: String;
begin
  lDecimalPlacesMask := '';
  case ADecimalPlaces of
    1: lDecimalPlacesMask := '#,###,##0.0';
    2: lDecimalPlacesMask := '#,###,##0.00';
    3: lDecimalPlacesMask := '#,###,##0.000';
    4: lDecimalPlacesMask := '#,###,##0.0000';
  end;

  // Evitar erro
  if (lDecimalPlacesMask = '') then
    lDecimalPlacesMask := '#,###,##0.00';

  // Formatar campos
  for lI := 0 to ADataSet.Fields.Count-1 do
  Begin
    ADataSet.Fields[lI].Alignment := taLeftJustify;
    if ADataSet.Fields[lI].DataType in [ftFloat, ftCurrency, ftBCD, ftFMTBcd] Then
    Begin
      TBCDField(ADataSet.Fields[lI]).DisplayFormat := '#,###,##0.00';
      ADataSet.Fields[lI].Alignment := taRightJustify;
    End;
  End;
end;

class function THlp.FormatDateDefault(AValue: TDate): String;
begin
  Result := FormatDateTime('YYYY/MM/DD', AValue);
end;

class function THlp.FormatDateTimeWithFirstHour(AValue: TDateTime): String;
begin
  Result := FormatDateTime('YYYY/MM/DD hh:mm:ss', SetDateTimeWithFirstHour(AValue));
end;

class function THlp.FormatDateTimeWithLastHour(AValue: TDateTime): String;
begin
  Result := FormatDateTime('YYYY/MM/DD hh:mm:ss', SetDateTimeWithLastHour(AValue));
end;

class function THlp.FormatPhone(pFone: String): String;
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

class function THlp.FormatZipCode(AValue: String): string;
begin
  Result := onlyNumbers(AValue).Trim;
  Result := FormatMaskText('00\.000\-000;0;', Result);
end;

class function THlp.If0RetNull(AValue: Int64): String;
begin
  case (AValue <= 0) of
    True:  Result := 'NULL';
    False: Result := AValue.ToString;
  end;
end;

class function THlp.Iif(aCondition: Boolean; aResultTrue, aResultFalse: variant): variant;
begin
  if (aCondition) then
    result := aResultTrue
  else
    result := aResultFalse
end;

class function THlp.IntBool(AValue: Integer): Boolean;
begin
  case AValue of
    0: Result := False;
    1: Result := True;
  end;
end;

class function THlp.IsJuridicaDoc(AValue: String): Boolean;
begin
  Result := not (Length(THlp.removeDots(AValue)) <= 11);
end;

class function THlp.OnlyNumbers(fField: String): String;
var
  I : Byte;
begin
  Result := '';

  if (fField = '') then EXIT;
  for I := 0 To Length(fField) do
    if fField [I] In ['0'..'9'] Then
      Result := Result + fField [I];
end;

class procedure THlp.parseDelimited(const sl: TStrings; const value, delimiter: string);
var
  dx : integer;
  ns : string;
  txt : string;
  delta : integer;
begin
  delta := Length(delimiter) ;
  txt := value + delimiter;
  sl.BeginUpdate;
  sl.Clear;

  try
    while Length(txt) > 0 do
    begin
      dx := Pos(delimiter, txt) ;
      ns := Copy(txt,0,dx-1) ;
      sl.Add(ns) ;
      txt := Copy(txt,dx+delta,MaxInt) ;
    end;
  finally
    sl.EndUpdate;
  end;
end;

class function THlp.RemoveAccentedChars(AValue: String): String;
const
  lWithAccentedChars = '·‡‚‰„ÈËÍÎÌÏÓÔÛÚÙˆı˙˘˚¸Á¡¿¬ƒ√…» ÀÕÃŒœ”“‘÷’⁄Ÿ€‹«∫™áîâöÉì';
  lWithoutAccentedChars = 'aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC        ';
var
   x: Integer;
begin;
  for x := 1 to Length(AValue) do
  if Pos(AValue[x],lWithAccentedChars) <> 0 then
    AValue[x] := lWithoutAccentedChars[Pos(AValue[x], lWithAccentedChars)];
  Result := AValue;
end;

class function THlp.RemoveDots(Str: String): String;
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

class function THlp.Repl(AValue: String; ALength: Integer): String;
var
  lContent: string;
  lCount: integer;
begin
  lContent := EmptyStr;

  for lCount := 1 to ALength do
    lContent := lContent + AValue;

  Repl := lContent;
end;

class function THlp.SetDateTimeWithFirstHour(AValue: TDateTime): TDateTime;
begin
  Result := RecodeTime(AValue, 0, 0, 0, 0);
end;

class function THlp.SetDateTimeWithLastHour(AValue: TDateTime): TDateTime;
begin
  Result := RecodeTime(AValue, 23, 59, 59, 0);
end;

class function THlp.Space(N: integer): string;
var
  I: integer;
  Dados: string;
begin
  Dados := '';
  for I := 1 to N do
  begin
    Dados := Dados + ' ';
  end;
  Space := Dados;
end;

class function THlp.SpaceStr(AContent: String; ALength: integer; ASide: TSide): string;
begin
  case ASide of
    sdLeft:  Result := Space(ALength - Length(AContent)) + AContent;
    sdRight: Result := AContent + Space(ALength - Length(AContent));
  end;
end;

class function THlp.StateList: TArray<String>;
begin
  Result := TArray<String>.Create(
    'AC',
    'AL',
    'AP',
    'AM',
    'BA',
    'CE',
    'DF',
    'ES',
    'GO',
    'MA',
    'MT',
    'MS',
    'MG',
    'PA',
    'PB',
    'PR',
    'PE',
    'PI',
    'RJ',
    'RN',
    'RS',
    'RO',
    'RR',
    'SC',
    'SP',
    'SE',
    'TO',
    'EX'
  )
end;

class function THlp.StrFloat(AValue: String; ADefaultValue: Double): Double;
begin
  // Tratar campo Price
  AValue := StringReplace(AValue, '.', '', [rfReplaceAll]);
  Result := StrToFloatDef(AValue, ADefaultValue);
end;

class function THlp.StrInt(AValue: String; ADefaultValue: Integer): Integer;
begin
  Result := StrToIntDef(AValue, ADefaultValue);
end;

class function THlp.StrZero(Conteudo: String; Tamanho: Integer): String;
begin
  while Length(Conteudo) < Tamanho do
    Insert('0', COnteudo,1);
  Result := Conteudo;
end;

class function THlp.ValidateCnpj(Dado: string): Boolean;
var
  D1: array[1..12] of byte;
  I, iAux, DF1, DF2, DF3, DF4, DF5, DF6, Resto1, Resto2, PrimeiroDigito,
  SegundoDigito: integer;
begin
  Result := true;

  // Evitar erro de validaÁ„o entre Android e Windows
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

class function THlp.ValidateCpf(Dado: string): Boolean;
var
  D1: array[1..9] of byte;
  I, iAux, DF1, DF2, DF3, DF4, DF5, DF6, Resto1, Resto2, PrimeiroDigito,
  SegundoDigito: integer;
begin
  Result := true;

  // Evitar erro de validaÁ„o entre Android e Windows
  {$IFDEF ANDROID}
    iAux := 1;
  {$ELSE}
    iAux := 0;
  {$ENDIF}

  Dado := onlyNumbers(Dado);
  if Length(Dado) = 11 then
  begin
    for I := 1 to 9 do
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
      DF1 := 10*D1[1] + 9*D1[2] + 8*D1[3] + 7*D1[4] + 6*D1[5] + 5*D1[6] +
             4*D1[7] + 3*D1[8] + 2*D1[9];
      DF2 := DF1 div 11;
      DF3 := DF2 * 11;
      Resto1 := DF1 - DF3;
      if (Resto1 = 0) or (Resto1 = 1) then
        PrimeiroDigito := 0
      else
        PrimeiroDigito := 11 - Resto1;

      DF4 := 11*D1[1] + 10*D1[2] + 9*D1[3] + 8*D1[4] + 7*D1[5] + 6*D1[6] +
             5*D1[7] + 4*D1[8] + 3*D1[9] + 2*PrimeiroDigito;
      DF5 := DF4 div 11;
      DF6 := DF5 * 11;
      Resto2 := DF4 - DF6;

      if (Resto2 = 0) or (Resto2 = 1) then
        SegundoDigito := 0
      else
        SegundoDigito := 11 - Resto2;

      if (PrimeiroDigito <> StrToInt(Dado[10-iAux])) or
         (SegundoDigito <> StrToInt(Dado[11-iAux])) then
        Result := false;
    end;
  end else
    if Length(Dado) <> 0 then
      Result := false;
End;

class function THlp.ValidateCpfCnpj(Dado: string): String;
begin
  Result := '';

  // Validar quantidade de caracteres e CPF/CNPJ
  Dado := onlyNumbers(Dado);
  if ((length(Dado) <> 11) and (length(Dado) <> 14))then EXIT;

  // Validar CNPJ
  if (length(Dado) = 14) then
  begin
    if validateCnpj(Dado) then
    begin
      insert('-',Dado,13);
      insert('/',Dado,9);
      insert('.',Dado,6);
      insert('.',Dado,3);
    end else EXIT;
  end;

  // Validar CPF
  if (length(Dado) = 11) then
  begin
    if validateCpf(Dado) then
    begin
      insert('-',Dado,10);
      insert('.',Dado,7);
      insert('.',Dado,4);
    end else EXIT;
  End;

  Result := Dado;
end;

end.

