unit uAclUser.SQLBuilder.Firebird;

interface

uses
  uAclUser.SQLBuilder,
  uAclUser.SQLBuilder.Interfaces;

type
  TAclUserSQLBuilderFirebird = class(TAclUserSQLBuilder, IAclUserSQLBuilder)
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

{ TAclUserSQLBuilderFirebird }

constructor TAclUserSQLBuilderFirebird.Create;
begin
  inherited Create;
  FDBName := dbnFirebird;
end;

class function TAclUserSQLBuilderFirebird.Make: IAclUserSQLBuilder;
begin
  Result := Self.Create;
end;

function TAclUserSQLBuilderFirebird.ScriptCreateTable: String;
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

function TAclUserSQLBuilderFirebird.ScriptSeedTable: String;
begin
  Result := TCQL.New(dbnFirebird)
    .Insert
    .Into('acl_user')
    .&Set('name', 'adm')
    .&Set('login', 'adm')
    .&Set('login_password', THlp.encrypt(ENCRYPTATION_KEY, '13'))
    .&Set('acl_role_id', 1)
    .&Set('is_superuser', 1)
  .AsString;
end;

end.
