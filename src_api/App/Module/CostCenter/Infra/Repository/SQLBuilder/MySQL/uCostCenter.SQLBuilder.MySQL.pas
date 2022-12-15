unit uCostCenter.SQLBuilder.MySQL;

interface

uses
  uCostCenter.SQLBuilder,
  uCostCenter.SQLBuilder.Interfaces;

type
  TCostCenterSQLBuilderMySQL = class(TCostCenterSQLBuilder, ICostCenterSQLBuilder)
  public
    constructor Create;
    class function Make: ICostCenterSQLBuilder;
    function ScriptCreateTable: String; override;
    function ScriptSeedTable: String; override;
  end;

implementation

uses
  cqlbr.interfaces;

{ TCostCenterSQLBuilderMySQL }

constructor TCostCenterSQLBuilderMySQL.Create;
begin
  inherited Create;
  FDBName := dbnMySQL;
end;

class function TCostCenterSQLBuilderMySQL.Make: ICostCenterSQLBuilder;
begin
  Result := Self.Create;
end;

function TCostCenterSQLBuilderMySQL.ScriptCreateTable: String;
begin
  Result :=
    ' CREATE TABLE `cost_center` (                                                                                              '+
    '   `id` bigint(20) NOT NULL AUTO_INCREMENT,                                                                          '+
    '   `name` varchar(100) NOT NULL,                                                                                     '+
    '   `created_at` datetime DEFAULT NULL,                                                                               '+
    '   `updated_at` datetime DEFAULT NULL,                                                                               '+
    '   `created_by_acl_user_id` bigint(20) DEFAULT NULL,                                                                 '+
    '   `updated_by_acl_user_id` bigint(20) DEFAULT NULL,                                                                 '+
    '   PRIMARY KEY (`id`),                                                                                               '+
    '   KEY `cost_center_idx_name` (`name`),                                                                                    '+
    '   KEY `cost_center_fk_created_by_acl_user_id` (`created_by_acl_user_id`),                                                 '+
    '   KEY `cost_center_fk_updated_by_acl_role_id` (`updated_by_acl_user_id`),                                                 '+
    '   CONSTRAINT `cost_center_fk_created_by_acl_user_id` FOREIGN KEY (`created_by_acl_user_id`) REFERENCES `acl_user` (`id`), '+
    '   CONSTRAINT `cost_center_fk_updated_by_acl_role_id` FOREIGN KEY (`updated_by_acl_user_id`) REFERENCES `acl_user` (`id`)  '+
    ' )                                                                                                                   ';
end;

function TCostCenterSQLBuilderMySQL.ScriptSeedTable: String;
begin
  Result := '';
end;

end.
