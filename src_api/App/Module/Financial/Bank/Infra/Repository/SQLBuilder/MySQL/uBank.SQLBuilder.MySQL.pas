unit uBank.SQLBuilder.MySQL;

interface

uses
  uBank.SQLBuilder,
  uBank.SQLBuilder.Interfaces;

type
  TBankSQLBuilderMySQL = class(TBankSQLBuilder, IBankSQLBuilder)
  public
    constructor Create;
    class function Make: IBankSQLBuilder;
    function ScriptCreateTable: String; override;
    function ScriptSeedTable: String; override;
  end;

implementation

uses
  cqlbr.interfaces;

{ TBankSQLBuilderMySQL }

constructor TBankSQLBuilderMySQL.Create;
begin
  inherited Create;
  FDBName := dbnMySQL;
end;

class function TBankSQLBuilderMySQL.Make: IBankSQLBuilder;
begin
  Result := Self.Create;
end;

function TBankSQLBuilderMySQL.ScriptCreateTable: String;
begin
  Result :=
    ' CREATE TABLE `bank` (                                                                                               '+
    '   `id` bigint(20) NOT NULL AUTO_INCREMENT,                                                                          '+
    '   `name` varchar(100) NOT NULL,                                                                                     '+
    '   `code` char(3) NOT NULL,                                                                                          '+
    '   `created_at` datetime DEFAULT NULL,                                                                               '+
    '   `updated_at` datetime DEFAULT NULL,                                                                               '+
    '   `created_by_acl_user_id` bigint(20) DEFAULT NULL,                                                                 '+
    '   `updated_by_acl_user_id` bigint(20) DEFAULT NULL,                                                                 '+
    '   PRIMARY KEY (`id`),                                                                                               '+
    '   KEY `bank_idx_name` (`name`),                                                                                     '+
    '   KEY `bank_fk_created_by_acl_user_id` (`created_by_acl_user_id`),                                                  '+
    '   KEY `bank_fk_updated_by_acl_role_id` (`updated_by_acl_user_id`),                                                  '+
    '   CONSTRAINT `bank_fk_created_by_acl_user_id` FOREIGN KEY (`created_by_acl_user_id`) REFERENCES `acl_user` (`id`),  '+
    '   CONSTRAINT `bank_fk_updated_by_acl_role_id` FOREIGN KEY (`updated_by_acl_user_id`) REFERENCES `acl_user` (`id`)   '+
    ' )                                                                                                                   ';
end;

function TBankSQLBuilderMySQL.ScriptSeedTable: String;
begin
  Result := '';
end;

end.
