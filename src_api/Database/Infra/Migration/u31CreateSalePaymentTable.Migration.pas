unit u31CreateSalePaymentTable.Migration;

interface

uses
  uMigration.Base,
  uMigration.Interfaces,
  uZLConnection.Interfaces;

type
  T31CreateSalePaymentTable = class(TMigrationBase, IMigration)
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
  uSalePayment.SQLBuilder.Interfaces,
  uSQLBuilder.Factory;

{ T31CreateSalePaymentTable }

function T31CreateSalePaymentTable.RunMigrate: IMigration;
var
  lStartTime: Cardinal;
  lDuration: Double;
  lSQLBuilder: ISalePaymentSQLBuilder;
begin
  Result      := Self;
  lStartTime  := GetTickCount;
  lSQLBuilder := TSQLBuilderFactory.Make(FConn.DriverDB).SalePayment;

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

constructor T31CreateSalePaymentTable.Create(AConn: IZLConnection);
begin
  inherited Create(AConn);

  // Informações da Migration
  FInformation.CreatedAtByDev(StrToDateTime('22/01/2023 17:06:00'));
end;

function T31CreateSalePaymentTable.Execute: IMigration;
begin
  Result := Self;

  // Não executar migration se tabela já existir
  FQry.Open(TMigrationHelper.SQLLocateMigrationTable(
    FConn.DriverDB,
    FConn.DataBaseName,
    'sale_payment'
  ));
  if not FQry.DataSet.IsEmpty then
  begin
    FInformation.Executed(True).Duration(-1);
    Exit;
  end;

  RunMigrate;
end;

class function T31CreateSalePaymentTable.Make(AConn: IZLConnection): IMigration;
begin
  Result := Self.Create(AConn);
end;

end.


