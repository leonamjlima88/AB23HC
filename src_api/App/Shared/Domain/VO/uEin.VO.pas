unit uEin.VO;

interface

type
  IEinVO = Interface
    ['{04A84EA8-C93A-4B87-94B3-E649EC73151D}']
    function Value: String;
  end;

  TEinVO = class(TInterfacedObject, IEinVO)
  private
    FEin: String;
    class function CPFOrCNPJIsValid(ADocument: string): boolean;
    class function CPFIsValid(ACPF: string): boolean;
    class function CNPJIsValid(ACNPJ: string): boolean;
    class function OnlyNumbers(const S: string): string;
    constructor Create(AValue: String);
  public
    class function Make(AValue: String): IEinVO;
    function Value: String;
  end;

implementation

uses
  System.SysUtils;

{ TEin }

constructor TEinVO.Create(AValue: String);
begin
  FEin := AValue;
end;

class function TEinVO.Make(AValue: String): IEinVO;
begin
  // Validar Campo
  if not AValue.Trim.IsEmpty then
  begin
    if not CPFOrCNPJIsValid(AValue) then
      raise Exception.Create('CPF/CNPJ é inválido.');
  end;

  Result := Self.Create(AValue);
end;

class function TEinVO.CPFIsValid(ACPF: string): boolean;
var
  D1: array[1..9] of byte;
  I, DF1, DF2, DF3, DF4, DF5, DF6, Resto1, Resto2, PrimeiroDigito,
  SegundoDigito: integer;
begin
  Result := true;

  ACPF := OnlyNumbers(ACPF);
  if Length(ACPF) = 11 then
  begin
    for I := 1 to 9 do
      D1[I] := StrToInt(ACPF[I]);

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

      if (PrimeiroDigito <> StrToInt(ACPF[10])) or
         (SegundoDigito <> StrToInt(ACPF[11])) then
        Result := false;
    end;
  end else
    if Length(ACPF) <> 0 then
      Result := false;
End;

class function TEinVO.CPFOrCNPJIsValid(ADocument: string): boolean;
var
  lIsCPF: Boolean;
begin
  ADocument := OnlyNumbers(ADocument);
  lIsCPF := ADocument.Length <= 11;
  case lIsCPF of
    True:  Result := CPFIsValid(ADocument);
    False: Result := CNPJIsValid(ADocument);
  end;
end;

class function TEinVO.CNPJIsValid(ACNPJ: string): boolean;
var
  D1: array[1..12] of byte;
  I, DF1, DF2, DF3, DF4, DF5, DF6, Resto1, Resto2, PrimeiroDigito,
  SegundoDigito: integer;
begin
  Result := true;

  ACNPJ := OnlyNumbers(ACNPJ);
  if Length(ACNPJ) = 14 then
  begin
    for I := 1 to 12 do
      D1[I] := StrToInt(ACNPJ[I]);

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

      if (PrimeiroDigito <> StrToInt(ACNPJ[13])) or
         (SegundoDigito <> StrToInt(ACNPJ[14])) then
        Result := false;
    end;
  end else
    if Length(ACNPJ) <> 0 then
      Result := false;
end;

class function TEinVO.OnlyNumbers(const S: string): string;
var
  vText : PChar;
begin
  vText := PChar(S);
  Result := '';

  while (vText^ <> #0) do
  begin
    {$IFDEF UNICODE}
    if CharInSet(vText^, ['0'..'9']) then
    {$ELSE}
    if vText^ in ['0'..'9'] then
    {$ENDIF}
      Result := Result + vText^;

    Inc(vText);
  end;

  Result := Result.Trim;
end;

function TEinVO.Value: String;
begin
  Result := OnlyNumbers(FEin.Trim);
end;

end.
