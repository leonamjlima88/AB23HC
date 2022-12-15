unit uPersonContactSQLBuilder;

interface

uses
  cqlbr.interfaces,
  uBase.Entity;

type
 TPersonContactSQLBuilder = class
  private
    FDBName: TDBName;
  public
    constructor Create(ADBName: TDBName);

    // PersonContact
    function SelectAll: String;
    function DeleteByPersonId(APersonId: Int64): String;
    function SelectByPersonId(APersonId: Int64): String;
    function InsertInto(AEntity: TBaseEntity): String;
  end;

implementation

uses
  criteria.query.language,
  System.Classes,
  System.SysUtils, uPersonContact;

{ TPersonContactSQLBuilder }
constructor TPersonContactSQLBuilder.Create(ADBName: TDBName);
begin
  FDBName := ADBName;
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
    .&Set('ein',       lPersonContact.ein)
    .&Set('type',      lPersonContact.&type)
    .&Set('note',      lPersonContact.note)
    .&Set('phone',     lPersonContact.phone)
    .&Set('email',     lPersonContact.email)
  .AsString;
end;

function TPersonContactSQLBuilder.SelectAll: String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('person_contact.*')
    .From('person_contact')
  .AsString;
end;

function TPersonContactSQLBuilder.SelectByPersonId(APersonId: Int64): String;
begin
  Result := SelectAll + ' WHERE person_contact.person_id = ' + APersonId.ToString;
end;

end.
