unit uDocument.Repository.SQL;

interface

uses
  uBase.Repository,
  uDocument.Repository.Interfaces,
  uDocument.SQLBuilder.Interfaces,
  uZLConnection.Interfaces,
  Data.DB,
  uBase.Entity,
  uPageFilter,
  uSelectWithFilter,
  uDocument;

type
  TDocumentRepositorySQL = class(TBaseRepository, IDocumentRepository)
  private
    FDocumentSQLBuilder: IDocumentSQLBuilder;
    constructor Create(AConn: IZLConnection; ASQLBuilder: IDocumentSQLBuilder);
    function DataSetToEntity(ADtsDocument: TDataSet): TBaseEntity; override;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter; override;
    procedure Validate(AEntity: TBaseEntity); override;
  public
    class function Make(AConn: IZLConnection; ASQLBuilder: IDocumentSQLBuilder): IDocumentRepository;
    function Show(AId, ATenantId: Int64): TDocument;
 end;

implementation

uses
  XSuperObject,
  DataSet.Serialize;

{ TDocumentRepositorySQL }

class function TDocumentRepositorySQL.Make(AConn: IZLConnection; ASQLBuilder: IDocumentSQLBuilder): IDocumentRepository;
begin
  Result := Self.Create(AConn, ASQLBuilder);
end;

constructor TDocumentRepositorySQL.Create(AConn: IZLConnection; ASQLBuilder: IDocumentSQLBuilder);
begin
  inherited Create;
  FConn            := AConn;
  FSQLBuilder      := ASQLBuilder;
  FDocumentSQLBuilder := ASQLBuilder;
end;

function TDocumentRepositorySQL.DataSetToEntity(ADtsDocument: TDataSet): TBaseEntity;
var
  lDocument: TDocument;
begin
  lDocument := TDocument.FromJSON(ADtsDocument.ToJSONObjectString);

  // Document - Virtuais
  lDocument.created_by_acl_user.id   := ADtsDocument.FieldByName('created_by_acl_user_id').AsLargeInt;
  lDocument.created_by_acl_user.name := ADtsDocument.FieldByName('created_by_acl_user_name').AsString;
  lDocument.updated_by_acl_user.id   := ADtsDocument.FieldByName('updated_by_acl_user_id').AsLargeInt;
  lDocument.updated_by_acl_user.name := ADtsDocument.FieldByName('updated_by_acl_user_name').AsString;

  Result := lDocument;
end;

function TDocumentRepositorySQL.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  Result := FDocumentSQLBuilder.SelectAllWithFilter(APageFilter);
end;

function TDocumentRepositorySQL.Show(AId, ATenantId: Int64): TDocument;
begin
  Result := ShowById(AId, ATenantId) as TDocument;
end;

procedure TDocumentRepositorySQL.Validate(AEntity: TBaseEntity);
begin
//
end;

end.


