unit uQry.Factory;

interface

uses
  uQry.Interfaces,
  System.Classes,
  uConnection.Types;

type
  TQryFactory = class
  public
    class function Make(AConnection: TComponent; AConnType: TConnLibType = ctDefault): IQry;
  end;

implementation

{ TQryFactory }

uses
  uQry.FireDAC,
  FireDAC.Comp.Client,
  uEnv;

class function TQryFactory.Make(AConnection: TComponent; AConnType: TConnLibType): IQry;
var
  lConnType: TConnLibType;
begin
  lConnType := AConnType;
  if (lConnType = ctDefault) then
    lConnType := Env.DefaultConnLibType;

  case lConnType of
    ctFireDAC: Result := TQryFireDAC.Make(TFDConnection(AConnection));
    ctZEOS: ;   // Exemplo: Result := TQryZEOS.Make(TFDConnection(AConnection));
    ctUnidac: ; // Exemplo: Result := TQryUnidac.Make(TFDConnection(AConnection));
    ctOthers: ; // Exemplo: ...;
  end;
end;

end.
