unit uBank.Repository.SQL;

interface

uses
  uBase.Repository,
  uBank.Repository.Interfaces,
  uBank.SQLBuilder.Interfaces,
  uZLConnection.Interfaces,
  Data.DB,
  uBase.Entity,
  uPageFilter,
  uSelectWithFilter,
  uBank;

type
  TBankRepositorySQL = class(TBaseRepository, IBankRepository)
  private
    FBankSQLBuilder: IBankSQLBuilder;
    constructor Create(AConn: IZLConnection; ASQLBuilder: IBankSQLBuilder);
    function DataSetToEntity(ADtsBank: TDataSet): TBaseEntity; override;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter; override;
    function FieldExists(AColumName, AColumnValue: String; AId: Int64): Boolean;
    procedure Validate(AEntity: TBaseEntity); override;
  public
    class function Make(AConn: IZLConnection; ASQLBuilder: IBankSQLBuilder): IBankRepository;
    function Show(AId: Int64): TBank;
 end;

implementation

uses
  XSuperObject,
  DataSet.Serialize, System.SysUtils, uApplication.Types;

{ TBankRepositorySQL }

class function TBankRepositorySQL.Make(AConn: IZLConnection; ASQLBuilder: IBankSQLBuilder): IBankRepository;
begin
  Result := Self.Create(AConn, ASQLBuilder);
end;

constructor TBankRepositorySQL.Create(AConn: IZLConnection; ASQLBuilder: IBankSQLBuilder);
begin
  inherited Create;
  FConn            := AConn;
  FSQLBuilder      := ASQLBuilder;
  FBankSQLBuilder  := ASQLBuilder;
end;

function TBankRepositorySQL.DataSetToEntity(ADtsBank: TDataSet): TBaseEntity;
var
  lBank: TBank;
begin
  lBank := TBank.FromJSON(ADtsBank.ToJSONObjectString);

  // Bank - Virtuais
  lBank.created_by_acl_user.id   := ADtsBank.FieldByName('created_by_acl_user_id').AsLargeInt;
  lBank.created_by_acl_user.name := ADtsBank.FieldByName('created_by_acl_user_name').AsString;
  lBank.updated_by_acl_user.id   := ADtsBank.FieldByName('updated_by_acl_user_id').AsLargeInt;
  lBank.updated_by_acl_user.name := ADtsBank.FieldByName('updated_by_acl_user_name').AsString;

  Result := lBank;
end;

function TBankRepositorySQL.FieldExists(AColumName, AColumnValue: String; AId: Int64): Boolean;
begin
  Result := not FConn.MakeQry.Open(
    FBankSQLBuilder.RegisteredFields(AColumName, AColumnValue, AId)
  ).DataSet.IsEmpty;
end;

function TBankRepositorySQL.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  Result := FBankSQLBuilder.SelectAllWithFilter(APageFilter);
end;

function TBankRepositorySQL.Show(AId: Int64): TBank;
begin
  Result := ShowById(AId) as TBank;
end;

procedure TBankRepositorySQL.Validate(AEntity: TBaseEntity);
var
  lBank: TBank;
begin
  lBank := AEntity as TBank;

  // Verificar se code já existe
  if not lBank.code.Trim.IsEmpty then
  begin
    if FieldExists('bank.code', lBank.code, lBank.id) then
      raise Exception.Create(Format(FIELD_WITH_VALUE_IS_IN_USE, ['Código do Banco', lBank.code]));
  end;
end;

end.


