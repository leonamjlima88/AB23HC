unit uPersonContact.SQLBuilder;

interface

uses
  uPersonContact.SQLBuilder.Interfaces,
  cqlbr.interfaces,
  uBase.Entity;

type
  TPersonContactSQLBuilder = class(TInterfacedObject, IPersonContactSQLBuilder)
  public
    FDBName: TDBName;
    constructor Create;

    function ScriptCreateTable: String; virtual; abstract;
    function DeleteById(AId: Int64; ATenantId: Int64 = 0): String;
    function SelectById(AId: Int64; ATenantId: Int64 = 0): String;
    function SelectAll: String;
    function InsertInto(AEntity: TBaseEntity): String;
    function LastInsertId: String;
    function Update(AEntity: TBaseEntity; AId: Int64): String;
    function DeleteByPersonId(APersonId: Int64): String;
    function SelectByPersonId(APersonId: Int64): String;
  end;

implementation

uses
  criteria.query.language,
  System.SysUtils,
  uPersonContact,
  uApplication.Types,
  uConnection.Types;

{ TPersonContactSQLBuilder }
constructor TPersonContactSQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TPersonContactSQLBuilder.DeleteById(AId, ATenantId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Delete
    .From('person_contact')
    .Where('person_contact.id = ' + AId.ToString)
  .AsString;
end;

function TPersonContactSQLBuilder.DeleteByPersonId(APersonId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Delete
    .From('person_contact')
    .Where('person_contact.person_id = ' + APersonId.ToString)
  .AsString;
end;

function TPersonContactSQLBuilder.InsertInto(AEntity: TBaseEntity): String;
var
  lPersonContact: TPersonContact;
begin
  lPersonContact := AEntity as TPersonContact;
  Result := TCQL.New(FDBName)
    .Insert
    .Into('person_contact')
    .&Set('person_id', lPersonContact.person_id)
    .&Set('name',      lPersonContact.name)
    .&Set('ein',       lPersonContact.ein.Value)
    .&Set('type',      lPersonContact.&type)
    .&Set('note',      lPersonContact.note)
    .&Set('phone',     lPersonContact.phone)
    .&Set('email',     lPersonContact.email)
  .AsString;
end;

function TPersonContactSQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
end;

function TPersonContactSQLBuilder.SelectAll: String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('person_contact.*')
    .From('person_contact')
  .AsString;
end;

function TPersonContactSQLBuilder.SelectById(AId: Int64; ATenantId: Int64): String;
begin
  Result := SelectAll + ' WHERE person_contact.id = ' + AId.ToString;
end;

function TPersonContactSQLBuilder.SelectByPersonId(APersonId: Int64): String;
begin
  Result :=SelectAll + ' WHERE person_contact.person_id = ' + APersonId.ToString;
end;

function TPersonContactSQLBuilder.Update(AEntity: TBaseEntity; AId: Int64): String;
var
  lPersonContact: TPersonContact;
begin
  lPersonContact := AEntity as TPersonContact;
  Result := TCQL.New(FDBName)
    .Insert
    .Into('person_contact')
    .&Set('person_id', lPersonContact.person_id)
    .&Set('name',      lPersonContact.name)
    .&Set('ein',       lPersonContact.ein.Value)
    .&Set('type',      lPersonContact.&type)
    .&Set('note',      lPersonContact.note)
    .&Set('phone',     lPersonContact.phone)
    .&Set('email',     lPersonContact.email)
    .Where('person_contact.id = ' + AId.ToString)
  .AsString;
end;

end.
