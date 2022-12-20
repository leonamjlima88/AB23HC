unit uNCM.SQLBuilder;

interface

uses
  uPageFilter,
  uSelectWithFilter,
  uNCM,
  criteria.query.language,
  uNCM.SQLBuilder.Interfaces,
  uBase.Entity,
  cqlbr.interfaces;

type
  TNCMSQLBuilder = class(TInterfacedObject, INCMSQLBuilder)
  private
    procedure LoadDefaultFieldsToInsertOrUpdate(const ACQL: ICQL; const ANCM: TNCM);
  public
    FDBName: TDBName;
    constructor Create;

    // NCM
    function ScriptCreateTable: String; virtual; abstract;
    function ScriptSeedTable: String; virtual; abstract;
    function DeleteById(AId: Int64; ATenantId: Int64 = 0): String;
    function SelectAll: String;
    function SelectById(AId: Int64; ATenantId: Int64 = 0): String;
    function InsertInto(AEntity: TBaseEntity): String;
    function LastInsertId: String;
    function Update(AEntity: TBaseEntity; AId: Int64): String;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
    function RegisteredFields(AColumName, AColumnValue: String; AId: Int64): String;
  end;

implementation

uses
  cqlbr.select.mysql,
  cqlbr.serialize.mysql,
  System.Classes,
  System.SysUtils,
  uConnection.Types,
  uApplication.Types;

{ TNCMSQLBuilder }
constructor TNCMSQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TNCMSQLBuilder.DeleteById(AId, ATenantId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Delete
    .From('ncm')
    .Where('ncm.id = ' + AId.ToString)
  .AsString;
end;

function TNCMSQLBuilder.InsertInto(AEntity: TBaseEntity): String;
var
  lNCM: TNCM;
  lCQL: ICQL;
begin
  lNCM := AEntity as TNCM;
  lCQL := TCQL.New(FDBName)
    .Insert
    .Into('ncm')
    .&Set('created_at',             lNCM.created_at)
    .&Set('created_by_acl_user_id', lNCM.created_by_acl_user_id);

  // Carregar campos default
  LoadDefaultFieldsToInsertOrUpdate(lCQL, lNCM);

  // Retornar String SQL
  Result := lCQL.AsString;
end;

function TNCMSQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
end;

procedure TNCMSQLBuilder.LoadDefaultFieldsToInsertOrUpdate(const ACQL: ICQL; const ANCM: TNCM);
const
  LDECIMAL_PLACES = 4;
begin
  ACQL
    .&Set('name',                   ANCM.name)
    .&Set('ncm',                    ANCM.ncm)
    .&Set('national_rate',          ANCM.national_rate, LDECIMAL_PLACES)
    .&Set('imported_rate',          ANCM.imported_rate, LDECIMAL_PLACES)
    .&Set('state_rate',             ANCM.state_rate, LDECIMAL_PLACES)
    .&Set('municipal_rate',         ANCM.municipal_rate, LDECIMAL_PLACES)
    .&Set('cest',                   ANCM.cest)
    .&Set('additional_information', ANCM.additional_information)
    .&Set('start_of_validity',      ANCM.start_of_validity)
    .&Set('end_of_validity',        ANCM.end_of_validity)
end;

function TNCMSQLBuilder.RegisteredFields(AColumName, AColumnValue: String; AId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column(AColumName)
    .From('ncm')
    .Where(AColumName).Equal(AColumnValue)
    .&And('ncm.id').NotEqual(AId)
  .AsString;
end;

function TNCMSQLBuilder.SelectAll: String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('ncm.*')
    .Column('created_by_acl_user.name').&As('created_by_acl_user_name')
    .Column('updated_by_acl_user.name').&As('updated_by_acl_user_name')
    .From('ncm')
    .LeftJoin('acl_user', 'created_by_acl_user')
         .&On('created_by_acl_user.id = ncm.created_by_acl_user_id')
    .LeftJoin('acl_user', 'updated_by_acl_user')
         .&On('updated_by_acl_user.id = ncm.updated_by_acl_user_id')
  .AsString;
end;

function TNCMSQLBuilder.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  case FDBName of
    dbnMySQL: Result := TSelectWithFilter.SelectAllWithFilter(APageFilter, SelectAll, 'ncm.id', ddMySql);
  end;
end;

function TNCMSQLBuilder.SelectById(AId: Int64; ATenantId: Int64): String;
begin
  Result := SelectAll + ' WHERE ncm.id = ' + AId.ToString;
end;

function TNCMSQLBuilder.Update(AEntity: TBaseEntity; AId: Int64): String;
var
  lNCM: TNCM;
  lCQL: ICQL;
begin
  lNCM := AEntity as TNCM;
  lCQL := TCQL.New(FDBName)
    .Update('ncm')
    .&Set('updated_at',             lNCM.updated_at)
    .&Set('updated_by_acl_user_id', lNCM.updated_by_acl_user_id);

  // Carregar campos default
  LoadDefaultFieldsToInsertOrUpdate(lCQL, lNCM);

  // Retornar String SQL
  Result := lCQL.Where('ncm.id = ' + AId.ToString).AsString;
end;

end.
