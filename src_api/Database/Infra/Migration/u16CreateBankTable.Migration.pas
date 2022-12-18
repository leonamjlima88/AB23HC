unit u16CreateBankTable.Migration;

interface

uses
  uMigration.Base,
  uMigration.Interfaces,
  uConnection.Interfaces;

type
  T16CreateBankTable = class(TMigrationBase, IMigration)
  private
    function RunMigrate: IMigration;
    constructor Create(AConn: IConnection);
  public
    class function Make(AConn: IConnection): IMigration;

    function Execute: IMigration;
  end;

implementation

uses
  Winapi.Windows,
  System.SysUtils,
  System.Classes,
  uMigration.Helper,
  uBank.SQLBuilder.Interfaces,
  uSQLBuilder.Factory;

{ T16CreateBankTable }

function T16CreateBankTable.RunMigrate: IMigration;
var
  lStartTime: Cardinal;
  lDuration: Double;
  lSQLBuilder: IBankSQLBuilder;
begin
  Result      := Self;
  lStartTime  := GetTickCount;
  lSQLBuilder := TSQLBuilderFactory.Make(FConn.DriverDB).Bank;

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
  lDuration := (GetTickCount - lStartTime)/1600;
  FInformation.Executed(True).Duration(lDuration);
end;

constructor T16CreateBankTable.Create(AConn: IConnection);
begin
  inherited Create(AConn);

  // Informações da Migration
  FInformation.CreatedAtByDev(StrToDateTime('18/12/2022 09:44:00'));
end;

function T16CreateBankTable.Execute: IMigration;
begin
  Result := Self;

  // Não executar migration se tabela já existir
  FQry.Open(TMigrationHelper.SQLLocateMigrationTable(
    FConn.DriverDB,
    FConn.DataBaseName,
    'bank'
  ));
  if not FQry.DataSet.IsEmpty then
  begin
    FInformation.Executed(True).Duration(-1);
    Exit;
  end;

  RunMigrate;
end;

class function T16CreateBankTable.Make(AConn: IConnection): IMigration;
begin
  Result := Self.Create(AConn);
end;

end.


