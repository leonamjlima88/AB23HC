unit uScript.Factory;

interface

uses
  uScript.Interfaces,
  System.Classes,
  uConnection.Types;

type
  TScriptFactory = class
  public
    class function Make(AConnection: TComponent; AConnType: TConnLibType = ctDefault): IScript;
  end;

implementation

{ TScriptFactory }

uses
  uScript.FireDAC,
  FireDAC.Comp.Client,
  uEnv;

class function TScriptFactory.Make(AConnection: TComponent; AConnType: TConnLibType): IScript;
var
  lConnType: TConnLibType;
begin
  lConnType := AConnType;
  if (lConnType = ctDefault) then
    lConnType := Env.DefaultConnLibType;

  case lConnType of
    ctFireDAC: Result := TScriptFireDAC.Make(TFDConnection(AConnection));
    ctZEOS: ;   // Exemplo: Result := TScriptZEOS.Make(TFDConnection(AConnection));
    ctUnidac: ; // Exemplo: Result := TScriptUnidac.Make(TFDConnection(AConnection));
    ctOthers: ; // Exemplo: ...;
  end;
end;

end.
