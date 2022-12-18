unit uOperationType.SQLBuilder.MySQL;

interface

uses
  uOperationType.SQLBuilder,
  uOperationType.SQLBuilder.Interfaces;

type
  TOperationTypeSQLBuilderMySQL = class(TOperationTypeSQLBuilder, IOperationTypeSQLBuilder)
  public
    constructor Create;
    class function Make: IOperationTypeSQLBuilder;
    function ScriptCreateTable: String; override;
    function ScriptSeedTable: String; override;
  end;

implementation

uses
  cqlbr.interfaces;

{ TOperationTypeSQLBuilderMySQL }

constructor TOperationTypeSQLBuilderMySQL.Create;
begin
  inherited Create;
  FDBName := dbnMySQL;
end;

class function TOperationTypeSQLBuilderMySQL.Make: IOperationTypeSQLBuilder;
begin
  Result := Self.Create;
end;

function TOperationTypeSQLBuilderMySQL.ScriptCreateTable: String;
begin
  Result := ' CREATE TABLE `operation_type` ( '+
            '   `id` bigint(20) NOT NULL AUTO_INCREMENT, '+
            '   `name` varchar(100) NOT NULL, '+
            '   `document_type` tinyint(4) NOT NULL, '+
            '   `issue_purpose` tinyint(4) NOT NULL, '+
            '   `operation_nature_description` varchar(255) NOT NULL, '+
            '   `created_at` datetime DEFAULT NULL, '+
            '   `updated_at` datetime DEFAULT NULL, '+
            '   `created_by_acl_user_id` bigint(20) DEFAULT NULL, '+
            '   `updated_by_acl_user_id` bigint(20) DEFAULT NULL, '+
            '   PRIMARY KEY (`id`), '+
            '   KEY `operation_type_idx_name` (`name`), '+
            '   KEY `operation_type_fk_created_by_acl_user_id` (`created_by_acl_user_id`), '+
            '   KEY `operation_type_fk_updated_by_acl_role_id` (`updated_by_acl_user_id`), '+
            '   CONSTRAINT `operation_type_fk_created_by_acl_user_id` FOREIGN KEY (`created_by_acl_user_id`) REFERENCES `acl_user` (`id`), '+
            '   CONSTRAINT `operation_type_fk_updated_by_acl_role_id` FOREIGN KEY (`updated_by_acl_user_id`) REFERENCES `acl_user` (`id`) '+
            ' ) ';
end;

function TOperationTypeSQLBuilderMySQL.ScriptSeedTable: String;
begin
  Result := '';
end;

end.
