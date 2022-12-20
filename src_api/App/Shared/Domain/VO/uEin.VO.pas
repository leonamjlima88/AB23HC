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
    class function CPFOrCNPJIsValid(AValue: string): boolean;
    class function CPFIsValid(AValue: string): boolean;
    class function CNPJIsValid(AValue: string): boolean;
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

class function TEinVO.CPFIsValid(AValue: string): boolean;
var
  n1,n2,n3,n4,n5,n6,n7,n8,n9:integer;
  d1,d2:integer;
  digitado, calculado:string;
begin
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

class function TEinVO.CPFOrCNPJIsValid(AValue: string): boolean;
var
  lIsCPF: Boolean;
begin
  AValue := OnlyNumbers(AValue);
  lIsCPF := AValue.Length <= 11;
  case lIsCPF of
    True:  Result := CPFIsValid(AValue);
    False: Result := CNPJIsValid(AValue);
  end;
end;

class function TEinVO.CNPJIsValid(AValue: string): boolean;
var
  n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,n12:integer;
  d1,d2:integer;
  digitado, calculado:string;
begin
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
