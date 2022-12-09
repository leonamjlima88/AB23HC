unit uMemTable.Factory;

interface

uses
  uMemTable.Interfaces,
  uConnection.Types,
  System.Classes;

type
  TMemTableFactory = class
  public
    class function Make(AConnType: TConnLibType = ctDefault): IMemTable;
  end;

implementation

{ TMemTableFactory }

uses
  uMemTable.FireDAC,
  uEnv;

class function TMemTableFactory.Make(AConnType: TConnLibType): IMemTable;
var
  lConnType: TConnLibType;
begin
  lConnType := AConnType;
  if (lConnType = ctDefault) then
    lConnType := Env.DefaultConnLibType;

  case lConnType of
    ctFireDAC: Result := TMemTableFireDAC.Make;
    // ctClientDataSet: ; // Exemplo: ...;
  end;
end;

end.


