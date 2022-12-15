unit uSize.SQLBuilder.MySQL;

interface

uses
  uSize.SQLBuilder,
  uSize.SQLBuilder.Interfaces;

type
  TSizeSQLBuilderMySQL = class(TSizeSQLBuilder, ISizeSQLBuilder)
  public
    constructor Create;
    class function Make: ISizeSQLBuilder;
    function ScriptCreateTable: String; override;
    function ScriptSeedTable: String; override;
  end;

implementation

uses
  cqlbr.interfaces;

{ TSizeSQLBuilderMySQL }

constructor TSizeSQLBuilderMySQL.Create;
begin
  inherited Create;
  FDBName := dbnMySQL;
end;

class function TSizeSQLBuilderMySQL.Make: ISizeSQLBuilder;
begin
  Result := Self.Create;
end;

function TSizeSQLBuilderMySQL.ScriptCreateTable: String;
begin
  Result :=
    ' CREATE TABLE `size` (                                                                                              '+
    '   `id` bigint(20) NOT NULL AUTO_INCREMENT,                                                                          '+
    '   `name` varchar(100) NOT NULL,                                                                                     '+
    '   `created_at` datetime DEFAULT NULL,                                                                               '+
    '   `updated_at` datetime DEFAULT NULL,                                                                               '+
    '   `created_by_acl_user_id` bigint(20) DEFAULT NULL,                                                                 '+
    '   `updated_by_acl_user_id` bigint(20) DEFAULT NULL,                                                                 '+
    '   PRIMARY KEY (`id`),                                                                                               '+
    '   KEY `size_idx_name` (`name`),                                                                                    '+
    '   KEY `size_fk_created_by_acl_user_id` (`created_by_acl_user_id`),                                                 '+
    '   KEY `size_fk_updated_by_acl_role_id` (`updated_by_acl_user_id`),                                                 '+
    '   CONSTRAINT `size_fk_created_by_acl_user_id` FOREIGN KEY (`created_by_acl_user_id`) REFERENCES `acl_user` (`id`), '+
    '   CONSTRAINT `size_fk_updated_by_acl_role_id` FOREIGN KEY (`updated_by_acl_user_id`) REFERENCES `acl_user` (`id`)  '+
    ' )                                                                                                                   ';
end;

function TSizeSQLBuilderMySQL.ScriptSeedTable: String;
begin
  Result := '';
end;

end.
