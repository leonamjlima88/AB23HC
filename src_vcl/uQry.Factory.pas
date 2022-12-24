unit uQry.Factory;

interface

uses
  uZLQry.Interfaces,
  System.Classes,
  uZLConnection.Types;

type
  TQryFactory = class
  public
    class function Make(AConnection: TComponent; AConnType: TZLConnLibType = ctDefault): IZLQry;
  end;

implementation

{ TQryFactory }

uses
  uZLQry.FireDAC,
  FireDAC.Comp.Client,
  uEnv;

class function TQryFactory.Make(AConnection: TComponent; AConnType: TZLConnLibType): IZLQry;
var
  lConnType: TZLConnLibType;
begin
  lConnType := AConnType;
  if (lConnType = ctDefault) then
    lConnType := Env.DefaultConnLibType;

  case lConnType of
    ctFireDAC: Result := TZLQryFireDAC.Make(TFDConnection(AConnection));
    ctOthers: ; // Exemplo: ...;
  end;
end;

end.
