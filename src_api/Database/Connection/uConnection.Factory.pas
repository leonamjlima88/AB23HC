unit uConnection.Factory;

interface

uses
  uConnection.Interfaces,
  uConnection.Types;

type
  TConnectionFactory = class
  public
    class function Make(AConnType: TConnLibType = ctDefault): IConnection;
  end;

implementation

{ TConnectionFactory }

uses
  uConnection.FireDAC,
  uEnv;

class function TConnectionFactory.Make(AConnType: TConnLibType): IConnection;
var
  lConnType: TConnLibType;
begin
  lConnType := AConnType;
  if (lConnType = ctDefault) then
    lConnType := Env.DefaultConnLibType;

  case lConnType of
    ctFireDAC: Result := TConnectionFireDAC.Make;
    ctZEOS: ;   // Exemplo: Result := TConnectionZEOS.Make;
    ctUnidac: ; // Exemplo: Result := TConnectionUnidac.Make;
    ctOthers: ; // Exemplo: ...;
  end;
end;

end.
