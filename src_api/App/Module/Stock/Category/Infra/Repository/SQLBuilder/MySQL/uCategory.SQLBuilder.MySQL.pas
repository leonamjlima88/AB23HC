unit uCategory.SQLBuilder.MySQL;

interface

uses
  uCategory.SQLBuilder,
  uCategory.SQLBuilder.Interfaces;

type
  TCategorySQLBuilderMySQL = class(TCategorySQLBuilder, ICategorySQLBuilder)
  public
    constructor Create;
    class function Make: ICategorySQLBuilder;
    function ScriptCreateTable: String; override;
    function ScriptSeedTable: String; override;
  end;

implementation

uses
  cqlbr.interfaces;

{ TCategorySQLBuilderMySQL }

constructor TCategorySQLBuilderMySQL.Create;
begin
  inherited Create;
  FDBName := dbnMySQL;
end;

class function TCategorySQLBuilderMySQL.Make: ICategorySQLBuilder;
begin
  Result := Self.Create;
end;

function TCategorySQLBuilderMySQL.ScriptCreateTable: String;
begin
  Result :=
    ' CREATE TABLE `category` (                                                                                               '+
    '   `id` bigint(20) NOT NULL AUTO_INCREMENT,                                                                              '+
    '   `name` varchar(100) NOT NULL,                                                                                         '+
    '   `created_at` datetime DEFAULT NULL,                                                                                   '+
    '   `updated_at` datetime DEFAULT NULL,                                                                                   '+
    '   `created_by_acl_user_id` bigint(20) DEFAULT NULL,                                                                     '+
    '   `updated_by_acl_user_id` bigint(20) DEFAULT NULL,                                                                     '+
    '   `tenant_id` bigint NOT NULL, '+
    '   PRIMARY KEY (`id`),                                                                                                   '+
    '   KEY `category_idx_name` (`name`),                                                                                     '+
    '   KEY `category_fk_created_by_acl_user_id` (`created_by_acl_user_id`),                                                  '+
    '   KEY `category_fk_updated_by_acl_role_id` (`updated_by_acl_user_id`),                                                  '+
    '   KEY `category_fk_tenant_id` (`tenant_id`), '+
    '   CONSTRAINT `category_fk_created_by_acl_user_id` FOREIGN KEY (`created_by_acl_user_id`) REFERENCES `acl_user` (`id`),  '+
    '   CONSTRAINT `category_fk_updated_by_acl_role_id` FOREIGN KEY (`updated_by_acl_user_id`) REFERENCES `acl_user` (`id`),  '+
    '   CONSTRAINT `category_fk_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `tenant` (`id`) '+
    ' )                                                                                                                       ';
end;

function TCategorySQLBuilderMySQL.ScriptSeedTable: String;
begin
  Result := '';
end;

end.
