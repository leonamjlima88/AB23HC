unit uScript.FireDAC;

interface

uses
  FireDAC.UI.Intf, FireDAC.Stan.Async, FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util,
  FireDAC.Stan.Intf, FireDAC.Comp.Script, FireDAC.Comp.Client,

  uScript.Interfaces;

type
  TScriptFireDAC = class(TInterfacedObject, IScript)
  private
    FConnection: TFDConnection;
    FScript: TFDScript;
    constructor Create(AConnection: TFDConnection);
  public
    destructor Destroy; override;
    class function Make(AConnection: TFDConnection): IScript;

    function SQLScriptsClear: IScript;
    function SQLScriptsAdd(AValue: String): IScript;
    function ValidateAll: Boolean;
    function ExecuteAll: Boolean;
  end;

implementation

uses
  System.SysUtils;

{ TScriptFireDAC }

constructor TScriptFireDAC.Create(AConnection: TFDConnection);
begin
  inherited Create;
  FConnection        := AConnection;
  FScript            := TFDScript.Create(nil);
  FScript.Connection := FConnection;
end;

destructor TScriptFireDAC.Destroy;
begin
  if Assigned(FScript) then FreeAndNil(FScript);

  inherited;
end;

function TScriptFireDAC.ExecuteAll: Boolean;
begin
  Result := FScript.ExecuteAll;
end;

class function TScriptFireDAC.Make(AConnection: TFDConnection): IScript;
begin
  Result := Self.Create(AConnection);
end;

function TScriptFireDAC.SQLScriptsAdd(AValue: String): IScript;
begin
  Result := Self;
  FScript.SQLScripts.Add;
  FScript.SQLScripts.Items[Pred(FScript.SQLScripts.Count)].SQL.Text := AValue;
end;

function TScriptFireDAC.SQLScriptsClear: IScript;
begin
  Result := Self;
  FScript.SQLScripts.Clear;
end;

function TScriptFireDAC.ValidateAll: Boolean;
begin
  Result := FScript.ValidateAll;
end;

end.
