unit uConnection.FireDAC;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Comp.UI,
  System.Classes,

  uConnection.Interfaces,
  uQry.Interfaces,
  uScript.Interfaces,
  uConnection.Types;

type
  TConnectionFireDAC = class(TInterfacedObject, IConnection)
  private
    FConn: TFDConnection;
    FMySQLDriverLink: TFDPhysMySQLDriverLink;
    FConnectionType: TConnLibType;
    FDriverDB: TDriverDB;
    constructor Create;
    function SetUp: IConnection;
  public
    destructor Destroy; override;
    class function Make: IConnection;

    function ConnectionType: TConnLibType;
    function DriverDB: TDriverDB;
    function DataBaseName: String;
    function IsConnected: Boolean;
    function Connect: IConnection;
    function Disconnect: IConnection;
    function MakeQry: IQry;
    function MakeScript: IScript;
    function Instance: TComponent;
    function InTransaction: Boolean;
    function StartTransaction: IConnection;
    function CommitTransaction: IConnection;
    function RollBackTransaction: IConnection;
  end;

implementation

uses
  System.SysUtils,
  uQry.Factory,
  uScript.Factory,
  uEnv;

{ TConnection }

function TConnectionFireDAC.CommitTransaction: IConnection;
begin
  Result := Self;
  if FConn.InTransaction then
    FConn.Commit;
end;

function TConnectionFireDAC.Connect: IConnection;
begin
  Result := Self;
  FConn.Connected := True;
end;

function TConnectionFireDAC.ConnectionType: TConnLibType;
begin
  Result := ctFireDAC;
end;

constructor TConnectionFireDAC.Create;
begin
  inherited Create;

  FConn            := TFDConnection.Create(nil);
  FMySQLDriverLink := TFDPhysMySQLDriverLink.Create(nil);
  SetUp;
end;

function TConnectionFireDAC.DataBaseName: String;
begin
  Result := FConn.Params.Database;
end;

destructor TConnectionFireDAC.Destroy;
begin
  if Assigned(FConn)            then FreeAndNil(FConn);
  if Assigned(FMySQLDriverLink) then FreeAndNil(FMySQLDriverLink);

  inherited;
end;

function TConnectionFireDAC.Disconnect: IConnection;
begin
  Result := Self;
  FConn.Connected := False;
end;

function TConnectionFireDAC.DriverDB: TDriverDB;
begin
  Result := FDriverDB;
end;

function TConnectionFireDAC.Instance: TComponent;
begin
  Result := FConn;
end;

function TConnectionFireDAC.InTransaction: Boolean;
begin
  Result := FConn.InTransaction;
end;

function TConnectionFireDAC.IsConnected: Boolean;
begin
  Result := FConn.Connected;
end;

class function TConnectionFireDAC.Make: IConnection;
begin
  Result := Self.Create;
end;

function TConnectionFireDAC.MakeQry: IQry;
begin
  Result := TQryFactory.Make(FConn, ctFireDAC);
end;

function TConnectionFireDAC.MakeScript: IScript;
begin
  Result := TScriptFactory.Make(FConn, ctFireDAC);
end;

function TConnectionFireDAC.RollBackTransaction: IConnection;
begin
  Result := Self;
  FConn.Rollback;
end;

function TConnectionFireDAC.SetUp: IConnection;
begin
  Result := Self;
  With FConn.Params do
  begin
    Clear;
    Add('Database='  + ENV.Database);
    Add('Server='    + ENV.Server);
    Add('User_Name=' + ENV.UserName);
    Add('Password='  + ENV.Password);
    Add('DriverID='  + ENV.Driver);
  end;
  FConn.LoginPrompt          := False;
  FMySQLDriverLink.VendorLib := ENV.VendorLib;

  if (ENV.Driver.ToLower = 'mysql') then FDriverDB := ddMySql;
  if (ENV.Driver.ToLower = 'fb')    then FDriverDB := ddFirebird;
  if (ENV.Driver.ToLower = 'pg')    then FDriverDB := ddPG;
end;

function TConnectionFireDAC.StartTransaction: IConnection;
begin
  Result := Self;
  if not FConn.InTransaction then
    FConn.StartTransaction;
end;

end.
