unit uNCM.SQLBuilder;

interface

uses
  uPageFilter,
  uSelectWithFilter,
  uNCM,
  criteria.query.language,
  uNCM.SQLBuilder.Interfaces,
  uBase.Entity;

type
  TNCMSQLBuilder = class(TInterfacedObject, INCMSQLBuilder)
  public
    FDBName: TDBName;
    constructor Create;

    // NCM
    function ScriptCreateTable: String; virtual; abstract;
    function ScriptSeedTable: String; virtual; abstract;
    function DeleteById(AId: Int64): String;
    function SelectAll: String;
    function SelectById(AId: Int64): String;
    function InsertInto(AEntity: TBaseEntity): String;
    function LastInsertId: String;
    function Update(AEntity: TBaseEntity; AId: Int64): String;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
    function RegisteredFields(AColumName, AColumnValue: String; AId: Int64): String;
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

{ TNCMSQLBuilder }
constructor TNCMSQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TNCMSQLBuilder.DeleteById(AId: Int64): String;
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
begin
  lNCM := AEntity as TNCM;
  Result := TCQL.New(FDBName)
    .Insert
    .Into('ncm')
    .&Set('name',                   lNCM.name)
    .&Set('ncm',                    lNCM.ncm)
    .&Set('national_rate',          Extended(lNCM.national_rate))
    .&Set('imported_rate',          Extended(lNCM.imported_rate))
    .&Set('state_rate',             Extended(lNCM.state_rate))
    .&Set('municipal_rate',         Extended(lNCM.municipal_rate))
    .&Set('cest',                   lNCM.cest)
    .&Set('additional_information', lNCM.additional_information)
    .&Set('start_of_validity',      lNCM.start_of_validity)
    .&Set('end_of_validity',        lNCM.end_of_validity)
    .&Set('created_at',             lNCM.created_at)
    .&Set('created_by_acl_user_id', lNCM.created_by_acl_user_id)
  .AsString;
end;

function TNCMSQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
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

function TNCMSQLBuilder.SelectById(AId: Int64): String;
begin
  Result := SelectAll + ' WHERE ncm.id = ' + AId.ToString;
end;

function TNCMSQLBuilder.Update(AEntity: TBaseEntity; AId: Int64): String;
var
  lNCM: TNCM;
begin
  lNCM := AEntity as TNCM;
  Result := TCQL.New(FDBName)
    .Update('ncm')
    .&Set('name',                   lNCM.name)
    .&Set('ncm',                    lNCM.ncm)
    .&Set('national_rate',          Extended(lNCM.national_rate))
    .&Set('imported_rate',          Extended(lNCM.imported_rate))
    .&Set('state_rate',             Extended(lNCM.state_rate))
    .&Set('municipal_rate',         Extended(lNCM.municipal_rate))
    .&Set('cest',                   lNCM.cest)
    .&Set('additional_information', lNCM.additional_information)
    .&Set('start_of_validity',      lNCM.start_of_validity)
    .&Set('end_of_validity',        lNCM.end_of_validity)
    .&Set('updated_at',             lNCM.updated_at)
    .&Set('updated_by_acl_user_id', lNCM.updated_by_acl_user_id)
    .Where('ncm.id = ' + AId.ToString)
  .AsString;
end;

end.
