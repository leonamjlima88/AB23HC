unit uTenant.SQLBuilder.MySQL;

interface

uses
  uTenant.SQLBuilder.Interfaces,
  uTenant.SQLBuilder;

type
  TTenantSQLBuilderMySQL = class(TTenantSQLBuilder, ITenantSQLBuilder)
  public
    constructor Create;
    class function Make: ITenantSQLBuilder;

    // Tenant
    function ScriptCreateTable: String; override;
    function ScriptSeedTable: String; override;
  end;

implementation

uses
  cqlbr.interfaces;

{ TTenantSQLBuilderMySQL }

constructor TTenantSQLBuilderMySQL.Create;
begin
  inherited Create;
  FDBName := dbnMySQL;
end;

class function TTenantSQLBuilderMySQL.Make: ITenantSQLBuilder;
begin
  Result := Self.Create;
end;

function TTenantSQLBuilderMySQL.ScriptCreateTable: String;
begin
  Result := ' CREATE TABLE `tenant` ( '+
            ' `id` bigint(20) NOT NULL AUTO_INCREMENT, '+
            ' `name` varchar(100) NOT NULL, '+
            ' `alias_name` varchar(100) NOT NULL, '+
            ' `legal_entity_number` varchar(20) DEFAULT NULL, '+
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
            ' `created_at` datetime DEFAULT NULL, '+
            ' `updated_at` datetime DEFAULT NULL, '+
            ' PRIMARY KEY (`id`), '+
            ' KEY `tenant_idx_name` (`name`), '+
            ' KEY `tenant_idx_alias_name` (`alias_name`), '+
            ' KEY `tenant_fk_city_id` (`city_id`), '+
            ' CONSTRAINT `tenant_fk_city_id` FOREIGN KEY (`city_id`) REFERENCES `city` (`id`) '+
            ' )  ';
end;

function TTenantSQLBuilderMySQL.ScriptSeedTable: String;
begin
  Result :=
    ' insert into tenant (name, alias_name) values (''Administrador'', ''Administrador''); ';
end;

end.
