unit uScript.Factory;

interface

uses
  uZLScript.Interfaces,
  System.Classes,
  uZLConnection.Types;

type
  TScriptFactory = class
  public
    class function Make(AConnection: TComponent; AConnType: TZLConnLibType = ctDefault): IZLScript;
  end;

implementation

{ TScriptFactory }

uses
  uZLScript.FireDAC,
  FireDAC.Comp.Client,
  uEnv;

class function TScriptFactory.Make(AConnection: TComponent; AConnType: TZLConnLibType): IZLScript;
var
  lConnType: TZLConnLibType;
begin
  lConnType := AConnType;
  if (lConnType = ctDefault) then
    lConnType := Env.DefaultConnLibType;

  case lConnType of
    ctFireDAC: Result := TZLScriptFireDAC.Make(TFDConnection(AConnection));
    ctOthers: ; // Exemplo: ...;
  end;
end;

end.
