unit uBrand.Repository.SQL;

interface

uses
  uBase.Repository,
  uBrand.Repository.Interfaces,
  uBrand.SQLBuilder.Interfaces,
  uZLConnection.Interfaces,
  Data.DB,
  uBase.Entity,
  uPageFilter,
  uSelectWithFilter,
  uBrand;

type
  TBrandRepositorySQL = class(TBaseRepository, IBrandRepository)
  private
    FBrandSQLBuilder: IBrandSQLBuilder;
    constructor Create(AConn: IZLConnection; ASQLBuilder: IBrandSQLBuilder);
    function DataSetToEntity(ADtsBrand: TDataSet): TBaseEntity; override;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter; override;
    procedure Validate(AEntity: TBaseEntity); override;
  public
    class function Make(AConn: IZLConnection; ASQLBuilder: IBrandSQLBuilder): IBrandRepository;
    function Show(AId, ATenantId: Int64): TBrand;
 end;

implementation

uses
  XSuperObject,
  DataSet.Serialize, System.SysUtils;

{ TBrandRepositorySQL }

class function TBrandRepositorySQL.Make(AConn: IZLConnection; ASQLBuilder: IBrandSQLBuilder): IBrandRepository;
begin
  Result := Self.Create(AConn, ASQLBuilder);
end;

constructor TBrandRepositorySQL.Create(AConn: IZLConnection; ASQLBuilder: IBrandSQLBuilder);
begin
  inherited Create;
  FConn            := AConn;
  FSQLBuilder      := ASQLBuilder;
  FBrandSQLBuilder := ASQLBuilder;
end;

function TBrandRepositorySQL.DataSetToEntity(ADtsBrand: TDataSet): TBaseEntity;
var
  lBrand: TBrand;
begin
  lBrand := TBrand.FromJSON(ADtsBrand.ToJSONObjectString);

  // Brand - Virtuais
  lBrand.created_by_acl_user.id   := ADtsBrand.FieldByName('created_by_acl_user_id').AsLargeInt;
  lBrand.created_by_acl_user.name := ADtsBrand.FieldByName('created_by_acl_user_name').AsString;
  lBrand.updated_by_acl_user.id   := ADtsBrand.FieldByName('updated_by_acl_user_id').AsLargeInt;
  lBrand.updated_by_acl_user.name := ADtsBrand.FieldByName('updated_by_acl_user_name').AsString;

  Result := lBrand;
end;

function TBrandRepositorySQL.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  Result := FBrandSQLBuilder.SelectAllWithFilter(APageFilter);
end;

function TBrandRepositorySQL.Show(AId, ATenantId: Int64): TBrand;
begin
  Result := ShowById(AId, ATenantId) as TBrand;
end;

procedure TBrandRepositorySQL.Validate(AEntity: TBaseEntity);
begin
//
end;

end.


