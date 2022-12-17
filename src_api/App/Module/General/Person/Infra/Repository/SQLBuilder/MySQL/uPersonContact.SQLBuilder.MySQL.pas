unit uPersonContact.SQLBuilder.MySQL;

interface

uses
  uPersonContact.SQLBuilder,
  uPersonContact.SQLBuilder.Interfaces;

type
  TPersonContactSQLBuilderMySQL = class(TPersonContactSQLBuilder, IPersonContactSQLBuilder)
  public
    constructor Create;
    class function Make: IPersonContactSQLBuilder;
    function ScriptCreateTable: String; override;
  end;

implementation

uses
  cqlbr.interfaces;

{ TPersonContactSQLBuilderMySQL }

constructor TPersonContactSQLBuilderMySQL.Create;
begin
  inherited Create;
  FDBName := dbnMySQL;
end;

class function TPersonContactSQLBuilderMySQL.Make: IPersonContactSQLBuilder;
begin
  Result := Self.Create;
end;

function TPersonContactSQLBuilderMySQL.ScriptCreateTable: String;
begin
  Result := ' CREATE TABLE `person_contact` ( '+
            '   `id` bigint(20) NOT NULL AUTO_INCREMENT, '+
            '   `person_id` bigint(20) NOT NULL, '+
            '   `name` varchar(100) DEFAULT NULL, '+
            '   `ein` varchar(20) DEFAULT NULL, '+
            '   `type` varchar(100) DEFAULT NULL, '+
            '   `note` text, '+
            '   `phone` varchar(40) DEFAULT NULL, '+
            '   `email` varchar(255) DEFAULT NULL, '+
            '   PRIMARY KEY (`id`), '+
            '   KEY `person_contact_fk_person_id` (`person_id`), '+
            '   CONSTRAINT `person_contact_fk_person_id` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE CASCADE ON UPDATE CASCADE '+
            ' )  ';
end;

end.
