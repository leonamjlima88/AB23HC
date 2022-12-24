unit uAclUser.SQLBuilder.MySQL;

interface

uses
  uAclUser.SQLBuilder,
  uAclUser.SQLBuilder.Interfaces;

type
  TAclUserSQLBuilderMySQL = class(TAclUserSQLBuilder, IAclUserSQLBuilder)
  public
    constructor Create;
    class function Make: IAclUserSQLBuilder;
    function ScriptCreateTable: String; override;
    function ScriptSeedTable: String; override;
  end;

implementation

uses
  cqlbr.interfaces,
  criteria.query.language,
  uHlp,
  uApplication.Types;

{ TAclUserSQLBuilderMySQL }

constructor TAclUserSQLBuilderMySQL.Create;
begin
  inherited Create;
  FDBName := dbnMySQL;
end;

class function TAclUserSQLBuilderMySQL.Make: IAclUserSQLBuilder;
begin
  Result := Self.Create;
end;

function TAclUserSQLBuilderMySQL.ScriptCreateTable: String;
begin
  Result := ' CREATE TABLE `acl_user` (                                                                       '+
            '   `id` bigint(20) NOT NULL AUTO_INCREMENT,                                                      '+
            '   `name` varchar(100) NOT NULL,                                                                 '+
            '   `login` varchar(100) NOT NULL,                                                                '+
            '   `login_password` varchar(100) NOT NULL,                                                       '+
            '   `acl_role_id` bigint(20) NOT NULL,                                                            '+
            '   `is_superuser` tinyint(4) DEFAULT NULL,                                                       '+
            '   `last_token` text,                                                                            '+
            '   `last_expiration` datetime DEFAULT NULL,                                                      '+
            '   PRIMARY KEY (`id`),                                                                           '+
            '   UNIQUE KEY `login_UNIQUE` (`login`),                                                          '+
            '   KEY `acl_user_fk_acl_role_id` (`acl_role_id`),                                                '+
            '   CONSTRAINT `acl_user_fk_acl_role_id` FOREIGN KEY (`acl_role_id`) REFERENCES `acl_role` (`id`) '+
            ' )                                                                                               ';
end;

function TAclUserSQLBuilderMySQL.ScriptSeedTable: String;
begin
  Result := TCQL.New(dbnMySQL)
    .Insert
    .Into('acl_user')
    .&Set('name',           'lead')
    .&Set('login',          'lead')
    .&Set('login_password', THlp.encrypt(ENCRYPTATION_KEY, 'lead321'))
    .&Set('acl_role_id',    1)
    .&Set('is_superuser',   1)
  .AsString;
end;

end.
