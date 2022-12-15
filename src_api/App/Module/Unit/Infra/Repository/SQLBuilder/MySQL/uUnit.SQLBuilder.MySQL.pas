unit uUnit.SQLBuilder.MySQL;

interface

uses
  uUnit.SQLBuilder,
  uUnit.SQLBuilder.Interfaces;

type
  TUnitSQLBuilderMySQL = class(TUnitSQLBuilder, IUnitSQLBuilder)
  public
    constructor Create;
    class function Make: IUnitSQLBuilder;
    function ScriptCreateTable: String; override;
    function ScriptSeedTable: String; override;
  end;

implementation

uses
  cqlbr.interfaces;

{ TUnitSQLBuilderMySQL }

constructor TUnitSQLBuilderMySQL.Create;
begin
  inherited Create;
  FDBName := dbnMySQL;
end;

class function TUnitSQLBuilderMySQL.Make: IUnitSQLBuilder;
begin
  Result := Self.Create;
end;

function TUnitSQLBuilderMySQL.ScriptCreateTable: String;
begin
  Result :=
    ' CREATE TABLE `unit` (                                                                                              '+
    '   `id` bigint(20) NOT NULL AUTO_INCREMENT,                                                                          '+
    '   `name` varchar(100) NOT NULL,                                                                                     '+
    '   `created_at` datetime DEFAULT NULL,                                                                               '+
    '   `updated_at` datetime DEFAULT NULL,                                                                               '+
    '   `created_by_acl_user_id` bigint(20) DEFAULT NULL,                                                                 '+
    '   `updated_by_acl_user_id` bigint(20) DEFAULT NULL,                                                                 '+
    '   PRIMARY KEY (`id`),                                                                                               '+
    '   KEY `unit_idx_name` (`name`),                                                                                    '+
    '   KEY `unit_fk_created_by_acl_user_id` (`created_by_acl_user_id`),                                                 '+
    '   KEY `unit_fk_updated_by_acl_role_id` (`updated_by_acl_user_id`),                                                 '+
    '   CONSTRAINT `unit_fk_created_by_acl_user_id` FOREIGN KEY (`created_by_acl_user_id`) REFERENCES `acl_user` (`id`), '+
    '   CONSTRAINT `unit_fk_updated_by_acl_role_id` FOREIGN KEY (`updated_by_acl_user_id`) REFERENCES `acl_user` (`id`)  '+
    ' )                                                                                                                   ';
end;

function TUnitSQLBuilderMySQL.ScriptSeedTable: String;
begin
  Result := '';
end;

end.
