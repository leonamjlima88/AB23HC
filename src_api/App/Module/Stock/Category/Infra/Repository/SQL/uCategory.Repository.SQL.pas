unit uCategory.Repository.SQL;

interface

uses
  uBase.Repository,
  uCategory.Repository.Interfaces,
  uCategory.SQLBuilder.Interfaces,
  uConnection.Interfaces,
  Data.DB,
  uBase.Entity,
  uPageFilter,
  uSelectWithFilter,
  uCategory;

type
  TCategoryRepositorySQL = class(TBaseRepository, ICategoryRepository)
  private
    FCategorySQLBuilder: ICategorySQLBuilder;
    constructor Create(AConn: IConnection; ASQLBuilder: ICategorySQLBuilder);
    function DataSetToEntity(ADtsCategory: TDataSet): TBaseEntity; override;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter; override;
    procedure Validate(AEntity: TBaseEntity); override;
  public
    class function Make(AConn: IConnection; ASQLBuilder: ICategorySQLBuilder): ICategoryRepository;
    function Show(AId, ATenantId: Int64): TCategory;
 end;

implementation

uses
  XSuperObject,
  DataSet.Serialize;

{ TCategoryRepositorySQL }

class function TCategoryRepositorySQL.Make(AConn: IConnection; ASQLBuilder: ICategorySQLBuilder): ICategoryRepository;
begin
  Result := Self.Create(AConn, ASQLBuilder);
end;

constructor TCategoryRepositorySQL.Create(AConn: IConnection; ASQLBuilder: ICategorySQLBuilder);
begin
  inherited Create;
  FConn            := AConn;
  FSQLBuilder      := ASQLBuilder;
  FCategorySQLBuilder := ASQLBuilder;
end;

function TCategoryRepositorySQL.DataSetToEntity(ADtsCategory: TDataSet): TBaseEntity;
var
  lCategory: TCategory;
begin
  lCategory := TCategory.FromJSON(ADtsCategory.ToJSONObjectString);

  // Category - Virtuais
  lCategory.created_by_acl_user.id   := ADtsCategory.FieldByName('created_by_acl_user_id').AsLargeInt;
  lCategory.created_by_acl_user.name := ADtsCategory.FieldByName('created_by_acl_user_name').AsString;
  lCategory.updated_by_acl_user.id   := ADtsCategory.FieldByName('updated_by_acl_user_id').AsLargeInt;
  lCategory.updated_by_acl_user.name := ADtsCategory.FieldByName('updated_by_acl_user_name').AsString;

  Result := lCategory;
end;

function TCategoryRepositorySQL.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  Result := FCategorySQLBuilder.SelectAllWithFilter(APageFilter);
end;

function TCategoryRepositorySQL.Show(AId, ATenantId: Int64): TCategory;
begin
  Result := ShowById(AId, ATenantId) as TCategory;
end;

procedure TCategoryRepositorySQL.Validate(AEntity: TBaseEntity);
begin
//
end;

end.


