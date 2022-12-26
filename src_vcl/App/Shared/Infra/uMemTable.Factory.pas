unit uMemTable.Factory;

interface

uses
  uZLMemTable.Interfaces,
  uZLConnection.Types,
  System.Classes;

type
  TMemTableFactory = class
  public
    class function Make(AConnType: TZLConnLibType = ctDefault): IZLMemTable;
  end;

implementation

{ TMemTableFactory }

uses
  uZLMemTable.FireDAC,
  uEnv;

class function TMemTableFactory.Make(AConnType: TZLConnLibType): IZLMemTable;
var
  lConnType: TZLConnLibType;
begin
  lConnType := AConnType;
  if (lConnType = ctDefault) then
    lConnType := Env.APP_LIBTYPE;

  case lConnType of
    ctFireDAC: Result := TZLMemTableFireDAC.Make;
    // ctClientDataSet: ; // Exemplo: ...;
  end;
end;

end.


