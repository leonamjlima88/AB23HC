unit uMigration.Manager;

interface

uses
  uMigration.Interfaces,
  System.Generics.Collections,
  uConnection.Interfaces,
  uQry.Interfaces;

type
  TMigrationManager = class(TInterfacedObject, IMigrationManager)
  private
    FConn: IConnection;
    FQry: IQry;
    FQryMigrationsPerformed: IQry;
    FMigrations: TList<IMigration>;

    function SetUp: IMigrationManager;
    function RunPendingMigrations: IMigrationManager;
    function RegiterMigrationInformation(AInformation: IMigrationInfo; ABatch: String): IMigrationManager;
    function CreateMigrationIfNotExists: IMigrationManager;
    function CreateUUID: string;
  public
    constructor Create(AConn: IConnection);
    destructor Destroy; override;
    class function Make(AConn: IConnection): IMigrationManager;

    function Execute: IMigrationManager;
    function Migrations: TList<IMigration>;
  end;

implementation

{ TMigrationManager }

uses
  System.SysUtils,
  Winapi.Windows,
  Winapi.ActiveX,
  System.DateUtils,
  uEnv,
  uMigration.Helper,
  //u01CreateAppParamConfigTable.Migration,
  u02CreateAclRoleTable.Migration,
  u03CreateAclUserTable.Migration,
  u04CreateBrandTable.Migration;
//  u05CreateCityTable.Migration,
//  u06CreatePersonTable.Migration,
//  u07CreatePersonContactTable.Migration,
//  u08CreateBankTable.Migration,
//  u09CreateCategoryTable.Migration,
//  u10CreateCostCenterTable.Migration,
//  u11CreateSizeTable.Migration,
//  u12CreateStorageLocationTable.Migration,
//  u13CreateBankAccountTable.Migration,
//  u14CreateChartOfAccountTable.Migration,
//  u15CreateNCMTable.Migration,
//  u16CreateDocumentTable.Migration,
//  u17CreatePaymentTermTable.Migration,
//  u18CreateUnitTable.Migration,
//  u19CreateProductTable.Migration,
//  u20CreateCompanyTable.Migration,
//  u21CreateBusinessProposalTable.Migration,
//  u22CreateBusinessProposalItemTable.Migration,
//  u23CreateSaleTable.Migration,
//  u24CreateSaleItemTable.Migration,
//  u25CreateSalePaymentTable.Migration,
//  u26CreateBillPayReceiveTable.Migration,
//  u27CreatePosPrinterTable.Migration,
//  u28CreateOperationTypeTable.Migration,
//  u29CreateCFOPTable.Migration,
//  u30CreateTaxRuleTable.Migration,
//  u31CreateTaxRuleStateTable.Migration;

const
  MIGRATION_ORDER_BY_DESCRIPTION = 'select * from migration order by description';
  MIGRATION_SELECT_EMPTY         = 'select * from migration where id is null';

function TMigrationManager.SetUp: IMigrationManager;
begin
  Result := Self;

  // Criar tabela de migration se não existir
  CreateMigrationIfNotExists;

  // Migrações que já foram executadas
  FQryMigrationsPerformed.Open(MIGRATION_ORDER_BY_DESCRIPTION);

  // Lista de Migrações
  FMigrations.Clear;
//  FMigrations.Add(T01CreateAppParamConfigTable.Make(FConn));
  FMigrations.Add(T02CreateAclRoleTable.Make(FConn));
  FMigrations.Add(T03CreateAclUserTable.Make(FConn));
  FMigrations.Add(T04CreateBrandTable.Make(FConn));
//  FMigrations.Add(T05CreateCityTable.Make(FConn));
//  FMigrations.Add(T06CreatePersonTable.Make(FConn));
//  FMigrations.Add(T07CreatePersonContactTable.Make(FConn));
//  FMigrations.Add(T08CreateBankTable.Make(FConn));
//  FMigrations.Add(T09CreateCategoryTable.Make(FConn));
//  FMigrations.Add(T10CreateCostCenterTable.Make(FConn));
//  FMigrations.Add(T11CreateSizeTable.Make(FConn));
//  FMigrations.Add(T12CreateStorageLocationTable.Make(FConn));
//  FMigrations.Add(T13CreateBankAccountTable.Make(FConn));
//  FMigrations.Add(T14CreateChartOfAccountTable.Make(FConn));
//  FMigrations.Add(T15CreateNCMTable.Make(FConn));
//  FMigrations.Add(T16CreateDocumentTable.Make(FConn));
//  FMigrations.Add(T17CreatePaymentTermTable.Make(FConn));
//  FMigrations.Add(T18CreateUnitTable.Make(FConn));
//  FMigrations.Add(T19CreateProductTable.Make(FConn));
//  FMigrations.Add(T20CreateCompanyTable.Make(FConn));
//  FMigrations.Add(T21CreateBusinessProposalTable.Make(FConn));
//  FMigrations.Add(T22CreateBusinessProposalItemTable.Make(FConn));
//  FMigrations.Add(T23CreateSaleTable.Make(FConn));
//  FMigrations.Add(T24CreateSaleItemTable.Make(FConn));
//  FMigrations.Add(T25CreateSalePaymentTable.Make(FConn));
//  FMigrations.Add(T26CreateBillPayReceiveTable.Make(FConn));
//  FMigrations.Add(T27CreatePosPrinterTable.Make(FConn));
//  FMigrations.Add(T28CreateOperationTypeTable.Make(FConn));
//  FMigrations.Add(T29CreateCFOPTable.Make(FConn));
//  FMigrations.Add(T30CreateTaxRuleTable.Make(FConn));
//  FMigrations.Add(T31CreateTaxRuleStateTable.Make(FConn));
end;

constructor TMigrationManager.Create(AConn: IConnection);
begin
  FConn                   := AConn;
  FQry                    := AConn.MakeQry;
  FQryMigrationsPerformed := AConn.MakeQry;

  FMigrations := TList<IMigration>.Create;
end;

function TMigrationManager.CreateMigrationIfNotExists: IMigrationManager;
var
  lSQL: String;
begin
  Result := Self;

  FQry.Open(TMigrationHelper.SQLLocateMigrationTable(
    FConn.DriverDB,
    FConn.DataBaseName,
    'migration'
  ));
  if not FQry.DataSet.IsEmpty then
    Exit;

  FQry.ExecSQL(TMigrationHelper.SQLCreateMigrationTable(FConn.DriverDB));
end;

function TMigrationManager.CreateUUID: string;
var
  lId: TGUID;
begin
  if (CoCreateGuid(lId) = S_OK) then
    Result := GUIDToString(lId);

  Result := StringReplace(Result, '{', '', [rfReplaceAll]);
  Result := StringReplace(Result, '}', '', [rfReplaceAll]);
end;

destructor TMigrationManager.Destroy;
begin
  // Fechar transação se existir
  FConn.CommitTransaction;

  if Assigned(FMigrations) then FreeAndNil(FMigrations);
  if Assigned(FMigrations) then FreeAndNil(FMigrations);

  inherited;
end;

function TMigrationManager.Execute: IMigrationManager;
begin
  Result := Self;

  SetUp;
  RunPendingMigrations;
end;

class function TMigrationManager.Make(AConn: IConnection): IMigrationManager;
begin
  Result := Self.Create(AConn);
end;

function TMigrationManager.Migrations: TList<IMigration>;
begin
  Result := FMigrations;
end;

function TMigrationManager.RegiterMigrationInformation(AInformation: IMigrationInfo; ABatch: String): IMigrationManager;
const
  LSQL = ' INSERT INTO migration                                            '+
         '   (description, created_at_by_dev, duration, batch, executed_at) '+
         ' VALUES                                                           '+
         '   (%s, %s, %s, %s, %s)                                           ';
begin
  Result := Self;

  // Registrar Migration
  FQry.ExecSQL(Format(LSQL, [
    QuotedStr(AInformation.Description),
    QuotedStr(FormatDateTime('YYYY-MM-DD HH:MM:SS', AInformation.CreatedAtByDev)),
    QuotedStr(StringReplace(FormatFloat('0.0000', AInformation.duration), FormatSettings.DecimalSeparator, '.', [rfReplaceAll,rfIgnoreCase])),
    QuotedStr(ABatch),
    QuotedStr(FormatDateTime('YYYY-MM-DD HH:MM:SS', now))
  ]));
end;

function TMigrationManager.RunPendingMigrations: IMigrationManager;
var
  lM: IMigration;
  lBatch: String;
begin
  Result := Self;

  // Executar Migrações Pendentes
  // Batch é para controle de lote de migrations, caso precise fazer um rollback
  lBatch := CreateUUID;
  for lM in FMigrations do
  begin
    if not FQryMigrationsPerformed.Locate('description', lM.Information.Description) then
    begin
      // Executar Migração
      if lM.Execute.Information.Executed then
        RegiterMigrationInformation(lM.Information, lBatch);
    end;
  end;
end;

end.
