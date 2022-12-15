unit uPerson.SQLBuilder.MySQL;

interface

uses
  uPerson.SQLBuilder.Interfaces,
  uPerson.SQLBuilder;

type
  TPersonSQLBuilderMySQL = class(TPersonSQLBuilder, IPersonSQLBuilder)
  public
    constructor Create;
    class function Make: IPersonSQLBuilder;

    // Person
    function ScriptCreateTable: String; override;
    function ScriptSeedTable: String; override;

    // PersonContact
    function PersonContactScriptCreateTable: String; override;
  end;

implementation

uses
  cqlbr.interfaces;

{ TPersonSQLBuilderMySQL }

constructor TPersonSQLBuilderMySQL.Create;
begin
  inherited Create;
  FDBName := dbnMySQL;
end;

class function TPersonSQLBuilderMySQL.Make: IPersonSQLBuilder;
begin
  Result := Self.Create;
end;

function TPersonSQLBuilderMySQL.PersonContactScriptCreateTable: String;
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

function TPersonSQLBuilderMySQL.ScriptCreateTable: String;
begin
  Result := ' CREATE TABLE `person` ( '+
            ' `id` bigint(20) NOT NULL AUTO_INCREMENT, '+
            ' `name` varchar(100) NOT NULL, '+
            ' `alias_name` varchar(100) NOT NULL, '+
            ' `ein` varchar(20) DEFAULT NULL, '+
            ' `icms_taxpayer` tinyint(4) DEFAULT NULL, '+
            ' `state_registration` varchar(20) DEFAULT NULL, '+
            ' `municipal_registration` varchar(20) DEFAULT NULL, '+
            ' `zipcode` varchar(10) DEFAULT NULL, '+
            ' `address` varchar(100) DEFAULT NULL, '+
            ' `address_number` varchar(15) DEFAULT NULL, '+
            ' `complement` varchar(100) DEFAULT NULL, '+
            ' `district` varchar(100) DEFAULT NULL, '+
            ' `city_id` bigint(20) DEFAULT NULL, '+
            ' `reference_point` varchar(100) DEFAULT NULL, '+
            ' `phone_1` varchar(40) DEFAULT NULL, '+
            ' `phone_2` varchar(40) DEFAULT NULL, '+
            ' `phone_3` varchar(40) DEFAULT NULL, '+
            ' `company_email` varchar(100) DEFAULT NULL, '+
            ' `financial_email` varchar(100) DEFAULT NULL, '+
            ' `internet_page` varchar(255) DEFAULT NULL, '+
            ' `note` text, '+
            ' `bank_note` text, '+
            ' `commercial_note` text, '+
            ' `is_customer` tinyint(4) DEFAULT NULL, '+
            ' `is_seller` tinyint(4) DEFAULT NULL, '+
            ' `is_supplier` tinyint(4) DEFAULT NULL, '+
            ' `is_carrier` tinyint(4) DEFAULT NULL, '+
            ' `is_technician` tinyint(4) DEFAULT NULL, '+
            ' `is_employee` tinyint(4) DEFAULT NULL, '+
            ' `is_other` tinyint(4) DEFAULT NULL, '+
            ' `is_final_customer` tinyint(4) DEFAULT NULL, '+
            ' `created_at` datetime DEFAULT NULL, '+
            ' `updated_at` datetime DEFAULT NULL, '+
            ' `created_by_acl_user_id` bigint(20) DEFAULT NULL, '+
            ' `updated_by_acl_user_id` bigint(20) DEFAULT NULL, '+
            ' PRIMARY KEY (`id`), '+
            ' KEY `person_idx_name` (`name`), '+
            ' KEY `person_idx_alias_name` (`alias_name`), '+
            ' KEY `person_fk_city_id` (`city_id`), '+
            ' KEY `person_fk_created_by_acl_user_id` (`created_by_acl_user_id`), '+
            ' KEY `person_fk_updated_by_acl_role_id` (`updated_by_acl_user_id`), '+
            ' CONSTRAINT `person_fk_created_by_acl_user_id` FOREIGN KEY (`created_by_acl_user_id`) REFERENCES `acl_user` (`id`), '+
            ' CONSTRAINT `person_fk_updated_by_acl_role_id` FOREIGN KEY (`updated_by_acl_user_id`) REFERENCES `acl_user` (`id`), '+
            ' CONSTRAINT `person_fk_city_id` FOREIGN KEY (`city_id`) REFERENCES `city` (`id`) '+
            ' )  ';
end;

function TPersonSQLBuilderMySQL.ScriptSeedTable: String;
begin
  Result := '';
end;

end.
