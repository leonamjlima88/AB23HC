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
  Result :=
    ' CREATE TABLE `acl_role` (                  '+
    '   `id` bigint(20) NOT NULL AUTO_INCREMENT, '+
    '   `name` varchar(100) NOT NULL,            '+
    '   PRIMARY KEY (`id`),                      '+
    '   KEY `acl_role_idx_name` (`name`)         '+
    ' )                                          ';
end;

function TAclRoleSQLBuilderMySQL.ScriptSeedTable: String;
begin
  Result :=
    ' insert into acl_role (name) values (''Administrador''); '+
    ' insert into acl_role (name) values (''Colaborador'');   ';
end;

end.
