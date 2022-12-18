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
  u02CreateAclRoleTable.Migration,
  u03CreateAclUserTable.Migration,
  u04CreateBrandTable.Migration,
  u05AclRoleSeed.Migration,
  u06AclUserSeed.Migration,
  u07CreateCategoryTable.Migration,
  u08CreateCostCenterTable.Migration,
  u09CreateSizeTable.Migration,
  u10CreateUnitTable.Migration,
  u11CreateStorageLocationTable.Migration,
  u12CreateCityTable.Migration,
  u13CreatePersonTable.Migration,
  u14CreatePersonContactTable.Migration,
  u15CreateProductTable.Migration,
  u16CreateBankTable.Migration,
  u17CreateBankAccountTable.Migration,
  u18CreateDocumentTable.Migration,
  u19CreatePaymentTermTable.Migration;

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

  // Migrações
  FMigrations.Clear;
  FMigrations.Add(T02CreateAclRoleTable.Make(FConn));
  FMigrations.Add(T03CreateAclUserTable.Make(FConn));
  FMigrations.Add(T04CreateBrandTable.Make(FConn));
  FMigrations.Add(T05AclRoleSeed.Make(FConn));
  FMigrations.Add(T06AclUserSeed.Make(FConn));
  FMigrations.Add(T07CreateCategoryTable.Make(FConn));
  FMigrations.Add(T08CreateCostCenterTable.Make(FConn));
  FMigrations.Add(T09CreateSizeTable.Make(FConn));
  FMigrations.Add(T10CreateUnitTable.Make(FConn));
  FMigrations.Add(T11CreateStorageLocationTable.Make(FConn));
  FMigrations.Add(T12CreateCityTable.Make(FConn));
  FMigrations.Add(T13CreatePersonTable.Make(FConn));
  FMigrations.Add(T14CreatePersonContactTable.Make(FConn));
  FMigrations.Add(T15CreateProductTable.Make(FConn));
  FMigrations.Add(T16CreateBankTable.Make(FConn));
  FMigrations.Add(T17CreateBankAccountTable.Make(FConn));
  FMigrations.Add(T18CreateDocumentTable.Make(FConn));
  FMigrations.Add(T19CreatePaymentTermTable.Make(FConn));
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
