unit uCFOP.SQLBuilder.MySQL;

interface

uses
  uCFOP.SQLBuilder,
  uCFOP.SQLBuilder.Interfaces;

type
  TCFOPSQLBuilderMySQL = class(TCFOPSQLBuilder, ICFOPSQLBuilder)
  public
    constructor Create;
    class function Make: ICFOPSQLBuilder;
    function ScriptCreateTable: String; override;
    function ScriptSeedTable: String; override;
  end;

implementation

uses
  cqlbr.interfaces;

{ TCFOPSQLBuilderMySQL }

constructor TCFOPSQLBuilderMySQL.Create;
begin
  inherited Create;
  FDBName := dbnMySQL;
end;

class function TCFOPSQLBuilderMySQL.Make: ICFOPSQLBuilder;
begin
  Result := Self.Create;
end;

function TCFOPSQLBuilderMySQL.ScriptCreateTable: String;
begin
  Result := ' CREATE TABLE `cfop` ( '+
            '   `id` bigint(20) NOT NULL AUTO_INCREMENT, '+
            '   `name` varchar(100) NOT NULL, '+
            '   `code` varchar(10) NOT NULL, '+
            '   `operation_type` tinyint(4) NOT NULL COMMENT ''[0..1] 0-Entrada, 1-Saída'', '+
            '   `created_at` datetime DEFAULT NULL, '+
            '   `updated_at` datetime DEFAULT NULL, '+
            '   `created_by_acl_user_id` bigint(20) DEFAULT NULL, '+
            '   `updated_by_acl_user_id` bigint(20) DEFAULT NULL, '+
            '   PRIMARY KEY (`id`), '+
            '   KEY `cfop_idx_name` (`name`), '+
            '   KEY `cfop_fk_created_by_acl_user_id` (`created_by_acl_user_id`), '+
            '   KEY `cfop_fk_updated_by_acl_role_id` (`updated_by_acl_user_id`), '+
            '   CONSTRAINT `cfop_fk_created_by_acl_user_id` FOREIGN KEY (`created_by_acl_user_id`) REFERENCES `acl_user` (`id`), '+
            '   CONSTRAINT `cfop_fk_updated_by_acl_role_id` FOREIGN KEY (`updated_by_acl_user_id`) REFERENCES `acl_user` (`id`) '+
            ' )  ';
end;

function TCFOPSQLBuilderMySQL.ScriptSeedTable: String;
begin
  Result := '';
end;

end.
