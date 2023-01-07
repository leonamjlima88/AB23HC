unit u14NCMSeed.Migration;

interface

uses
  uMigration.Base,
  uMigration.Interfaces,
  uZLConnection.Interfaces;

type
  T14NCMSeed = class(TMigrationBase, IMigration)
  private
    function RunMigrate: IMigration;
    constructor Create(AConn: IZLConnection);
  public
    class function Make(AConn: IZLConnection): IMigration;
    function Execute: IMigration;
  end;

implementation

uses
  Winapi.Windows,
  System.SysUtils,
  System.Classes,
  uMigration.Helper,
  uNCM.SQLBuilder.Interfaces,
  uSQLBuilder.Factory;

{ T14NCMSeed }

function T14NCMSeed.RunMigrate: IMigration;
var
  lStartTime: Cardinal;
  lDuration: Double;
  lSQLBuilder: INCMSQLBuilder;
begin
  Result      := Self;
  lStartTime  := GetTickCount;
  lSQLBuilder := TSQLBuilderFactory.Make(FConn.DriverDB).NCM;

  // Criar Tabela
  try
    FConn.StartTransaction;

    FScript
      .SQLScriptsClear
      .SQLScriptsAdd(lSQLBuilder.ScriptSeedTable)
      .ValidateAll;
    if not FScript.ExecuteAll then
      raise Exception.Create('Error validation in seed. ' + Self.ClassName);

    // Commit
    FConn.CommitTransaction;
  Except
    FConn.RollBackTransaction;
    raise;
  end;

  // Migration Executada
  lDuration := (GetTickCount - lStartTime)/1000;
  FInformation.Executed(True).Duration(lDuration);
end;

constructor T14NCMSeed.Create(AConn: IZLConnection);
begin
  inherited Create(AConn);

  // Informações da Migration
  FInformation.CreatedAtByDev(StrToDateTime('23/12/2022 00:26:00'));
end;

function T14NCMSeed.Execute: IMigration;
begin
  Result := Self;
  RunMigrate;
end;

class function T14NCMSeed.Make(AConn: IZLConnection): IMigration;
begin
  Result := Self.Create(AConn);
end;

end.


