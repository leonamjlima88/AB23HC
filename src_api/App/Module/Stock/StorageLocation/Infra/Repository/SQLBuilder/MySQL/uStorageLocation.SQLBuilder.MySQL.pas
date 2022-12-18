unit uStorageLocation.SQLBuilder.MySQL;

interface

uses
  uStorageLocation.SQLBuilder,
  uStorageLocation.SQLBuilder.Interfaces;

type
  TStorageLocationSQLBuilderMySQL = class(TStorageLocationSQLBuilder, IStorageLocationSQLBuilder)
  public
    constructor Create;
    class function Make: IStorageLocationSQLBuilder;
    function ScriptCreateTable: String; override;
    function ScriptSeedTable: String; override;
  end;

implementation

uses
  cqlbr.interfaces;

{ TStorageLocationSQLBuilderMySQL }

constructor TStorageLocationSQLBuilderMySQL.Create;
begin
  inherited Create;
  FDBName := dbnMySQL;
end;

class function TStorageLocationSQLBuilderMySQL.Make: IStorageLocationSQLBuilder;
begin
  Result := Self.Create;
end;

function TStorageLocationSQLBuilderMySQL.ScriptCreateTable: String;
begin
  Result :=
    ' CREATE TABLE `storage_location` (                                                                                              '+
    '   `id` bigint(20) NOT NULL AUTO_INCREMENT,                                                                          '+
    '   `name` varchar(100) NOT NULL,                                                                                     '+
    '   `created_at` datetime DEFAULT NULL,                                                                               '+
    '   `updated_at` datetime DEFAULT NULL,                                                                               '+
    '   `created_by_acl_user_id` bigint(20) DEFAULT NULL,                                                                 '+
    '   `updated_by_acl_user_id` bigint(20) DEFAULT NULL,                                                                 '+
    '   `tenant_id` bigint NOT NULL, '+
    '   PRIMARY KEY (`id`),                                                                                               '+
    '   KEY `storage_location_idx_name` (`name`),                                                                                    '+
    '   KEY `storage_location_fk_created_by_acl_user_id` (`created_by_acl_user_id`),                                                 '+
    '   KEY `storage_location_fk_updated_by_acl_role_id` (`updated_by_acl_user_id`),                                                 '+
    '   KEY `storage_location_fk_tenant_id` (`tenant_id`), '+
    '   CONSTRAINT `storage_location_fk_created_by_acl_user_id` FOREIGN KEY (`created_by_acl_user_id`) REFERENCES `acl_user` (`id`), '+
    '   CONSTRAINT `storage_location_fk_updated_by_acl_role_id` FOREIGN KEY (`updated_by_acl_user_id`) REFERENCES `acl_user` (`id`),  '+
    '   CONSTRAINT `storage_location_fk_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `tenant` (`id`) '+
    ' )                                                                                                                   ';
end;

function TStorageLocationSQLBuilderMySQL.ScriptSeedTable: String;
begin
  Result := '';
end;

end.
