unit uDocument.SQLBuilder;

interface

uses
  uPageFilter,
  uSelectWithFilter,
  uDocument,
  criteria.query.language,
  uDocument.SQLBuilder.Interfaces,
  uBase.Entity;

type
  TDocumentSQLBuilder = class(TInterfacedObject, IDocumentSQLBuilder)
  public
    FDBName: TDBName;
    constructor Create;

    // Document
    function ScriptCreateTable: String; virtual; abstract;
    function ScriptSeedTable: String; virtual; abstract;
    function DeleteById(AId: Int64; ATenantId: Int64): String;
    function SelectAll: String;
    function SelectById(AId: Int64; ATenantId: Int64): String;
    function InsertInto(AEntity: TBaseEntity): String;
    function LastInsertId: String;
    function Update(AEntity: TBaseEntity; AId: Int64): String;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
  end;

implementation

uses
  cqlbr.interfaces,
  cqlbr.select.mysql,
  cqlbr.serialize.mysql,
  System.Classes,
  System.SysUtils,
  uConnection.Types,
  uApplication.Types;

{ TDocumentSQLBuilder }
constructor TDocumentSQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TDocumentSQLBuilder.DeleteById(AId, ATenantId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Delete
    .From('document')
    .Where('document.id = ' + AId.ToString)
  .AsString;
end;

function TDocumentSQLBuilder.InsertInto(AEntity: TBaseEntity): String;
var
  lDocument: TDocument;
begin
  lDocument := AEntity as TDocument;
  Result := TCQL.New(FDBName)
    .Insert
    .Into('document')
    .&Set('name',                    lDocument.name)
    .&Set('is_release_as_completed', lDocument.is_release_as_completed)
    .&Set('created_at',              lDocument.created_at)
    .&Set('created_by_acl_user_id',  lDocument.created_by_acl_user_id)
  .AsString;
end;

function TDocumentSQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
end;

function TDocumentSQLBuilder.SelectAll: String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('document.*')
    .Column('created_by_acl_user.name').&As('created_by_acl_user_name')
    .Column('updated_by_acl_user.name').&As('updated_by_acl_user_name')
    .From('document')
    .LeftJoin('acl_user', 'created_by_acl_user')
         .&On('created_by_acl_user.id = document.created_by_acl_user_id')
    .LeftJoin('acl_user', 'updated_by_acl_user')
         .&On('updated_by_acl_user.id = document.updated_by_acl_user_id')
  .AsString;
end;

function TDocumentSQLBuilder.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  case FDBName of
    dbnMySQL: Result := TSelectWithFilter.SelectAllWithFilter(APageFilter, SelectAll, 'document.id', ddMySql);
  end;
end;

function TDocumentSQLBuilder.SelectById(AId: Int64; ATenantId: Int64): String;
begin
  Result := SelectAll + ' WHERE document.id = ' + AId.ToString;
end;

function TDocumentSQLBuilder.Update(AEntity: TBaseEntity; AId: Int64): String;
var
  lDocument: TDocument;
begin
  lDocument := AEntity as TDocument;
  Result := TCQL.New(FDBName)
    .Update('document')
    .&Set('name',                    lDocument.name)
    .&Set('is_release_as_completed', lDocument.is_release_as_completed)
    .&Set('updated_at',              lDocument.updated_at)
    .&Set('updated_by_acl_user_id',  lDocument.updated_by_acl_user_id)
    .Where('document.id = ' + AId.ToString)
  .AsString;
end;

end.
