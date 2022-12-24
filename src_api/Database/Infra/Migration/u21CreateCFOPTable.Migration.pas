unit u21CreateCFOPTable.Migration;

interface

uses
  uMigration.Base,
  uMigration.Interfaces,
  uZLConnection.Interfaces;

type
  T21CreateCFOPTable = class(TMigrationBase, IMigration)
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
  uCFOP.SQLBuilder.Interfaces,
  uSQLBuilder.Factory;

{ T21CreateCFOPTable }

function T21CreateCFOPTable.RunMigrate: IMigration;
var
  lStartTime: Cardinal;
  lDuration: Double;
  lSQLBuilder: ICFOPSQLBuilder;
begin
  Result      := Self;
  lStartTime  := GetTickCount;
  lSQLBuilder := TSQLBuilderFactory.Make(FConn.DriverDB).CFOP;

  // Criar Tabela
  try
    FConn.StartTransaction;

    FScript
      .SQLScriptsClear
      .SQLScriptsAdd(lSQLBuilder.ScriptCreateTable)
      .ValidateAll;
    if not FScript.ExecuteAll then
      raise Exception.Create('Error validation in migration. ' + Self.ClassName);

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

constructor T21CreateCFOPTable.Create(AConn: IZLConnection);
begin
  inherited Create(AConn);

  // Informa��es da Migration
  FInformation.CreatedAtByDev(StrToDateTime('18/12/2022 11:41:00'));
end;

function T21CreateCFOPTable.Execute: IMigration;
begin
  Result := Self;

  // N�o executar migration se tabela j� existir
  FQry.Open(TMigrationHelper.SQLLocateMigrationTable(
    FConn.DriverDB,
    FConn.DataBaseName,
    'cfop'
  ));
  if not FQry.DataSet.IsEmpty then
  begin
    FInformation.Executed(True).Duration(-1);
    Exit;
  end;

  RunMigrate;
end;

class function T21CreateCFOPTable.Make(AConn: IZLConnection): IMigration;
begin
  Result := Self.Create(AConn);
end;

end.


