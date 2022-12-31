unit uAppParam.SQLBuilder.MySQL;

interface

uses
  uAppParam.SQLBuilder,
  uAppParam.SQLBuilder.Interfaces;

type
  TAppParamSQLBuilderMySQL = class(TAppParamSQLBuilder, IAppParamSQLBuilder)
  public
    constructor Create;
    class function Make: IAppParamSQLBuilder;
    function ScriptCreateTable: String; override;
    function ScriptSeedTable: String; override;
  end;

implementation

uses
  cqlbr.interfaces;

{ TAppParamSQLBuilderMySQL }

constructor TAppParamSQLBuilderMySQL.Create;
begin
  inherited Create;
  FDBName := dbnMySQL;
end;

class function TAppParamSQLBuilderMySQL.Make: IAppParamSQLBuilder;
begin
  Result := Self.Create;
end;

function TAppParamSQLBuilderMySQL.ScriptCreateTable: String;
begin
  Result := ' CREATE TABLE `app_param` ( '+
            ' `id` bigint(20) NOT NULL AUTO_INCREMENT, '+
            ' `tenant_id` bigint(20) NOT NULL, '+
            ' `acl_role_id` bigint(20) DEFAULT NULL, '+
            ' `group_name` varchar(255) DEFAULT NULL, '+
            ' `title` varchar(255) DEFAULT NULL, '+
            ' `value` text, '+
            ' PRIMARY KEY (`id`), '+
            ' KEY `app_param_fk_tenant_id_idx` (`tenant_id`), '+
            ' KEY `app_param_idx_group_name` (`group_name`), '+
            ' KEY `app_param_fk_acl_role_id_idx` (`acl_role_id`), '+
            ' CONSTRAINT `app_param_fk_acl_role_id` FOREIGN KEY (`acl_role_id`) REFERENCES `acl_role` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION, '+
            ' CONSTRAINT `app_param_fk_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `tenant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE '+
            ' ) ';

end;

function TAppParamSQLBuilderMySQL.ScriptSeedTable: String;
begin
  Result := '';
end;

end.
