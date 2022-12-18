unit uAclRole.SQLBuilder.MySQL;

interface

uses
  uAclRole.SQLBuilder,
  uAclRole.SQLBuilder.Interfaces;

type
  TAclRoleSQLBuilderMySQL = class(TAclRoleSQLBuilder, IAclRoleSQLBuilder)
  public
    constructor Create;
    class function Make: IAclRoleSQLBuilder;
    function ScriptCreateTable: String; override;
    function ScriptSeedTable: String; override;
  end;

implementation

uses
  cqlbr.interfaces;

{ TAclRoleSQLBuilderMySQL }

constructor TAclRoleSQLBuilderMySQL.Create;
begin
  inherited Create;
  FDBName := dbnMySQL;
end;

class function TAclRoleSQLBuilderMySQL.Make: IAclRoleSQLBuilder;
begin
  Result := Self.Create;
end;

function TAclRoleSQLBuilderMySQL.ScriptCreateTable: String;
begin
  Result := ' CREATE TABLE `acl_role` ('+
            '  `id` bigint NOT NULL AUTO_INCREMENT,'+
            '   `name` varchar(100) NOT NULL,'+
            '   `tenant_id` bigint NOT NULL,'+
            '   PRIMARY KEY (`id`),'+
            '   KEY `acl_role_fk_tenant_id` (`tenant_id`),'+
            '   CONSTRAINT `acl_role_fk_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `tenant` (`id`)'+
            ' ) ';
end;

function TAclRoleSQLBuilderMySQL.ScriptSeedTable: String;
begin
  Result :=
    ' insert into acl_role (name, tenant_id) values (''Administrador'', 1); '+
    ' insert into acl_role (name, tenant_id) values (''Colaborador'', 1);   ';
end;

end.
