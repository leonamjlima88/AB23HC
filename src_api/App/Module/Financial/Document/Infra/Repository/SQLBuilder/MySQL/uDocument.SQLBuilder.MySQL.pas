unit uDocument.SQLBuilder.MySQL;

interface

uses
  uDocument.SQLBuilder,
  uDocument.SQLBuilder.Interfaces;

type
  TDocumentSQLBuilderMySQL = class(TDocumentSQLBuilder, IDocumentSQLBuilder)
  public
    constructor Create;
    class function Make: IDocumentSQLBuilder;
    function ScriptCreateTable: String; override;
    function ScriptSeedTable: String; override;
  end;

implementation

uses
  cqlbr.interfaces;

{ TDocumentSQLBuilderMySQL }

constructor TDocumentSQLBuilderMySQL.Create;
begin
  inherited Create;
  FDBName := dbnMySQL;
end;

class function TDocumentSQLBuilderMySQL.Make: IDocumentSQLBuilder;
begin
  Result := Self.Create;
end;

function TDocumentSQLBuilderMySQL.ScriptCreateTable: String;
begin
  Result := ' CREATE TABLE `document` ( '+
            '   `id` bigint(20) NOT NULL AUTO_INCREMENT, '+
            '   `name` varchar(100) NOT NULL, '+
            '   `is_release_as_completed` tinyint(4) DEFAULT NULL, '+
            '   `created_at` datetime DEFAULT NULL, '+
            '   `updated_at` datetime DEFAULT NULL, '+
            '   `created_by_acl_user_id` bigint(20) DEFAULT NULL, '+
            '   `updated_by_acl_user_id` bigint(20) DEFAULT NULL, '+
            '   PRIMARY KEY (`id`), '+
            '   KEY `document_idx_name` (`name`), '+
            '   KEY `document_fk_created_by_acl_user_id` (`created_by_acl_user_id`), '+
            '   KEY `document_fk_updated_by_acl_role_id` (`updated_by_acl_user_id`), '+
            '   CONSTRAINT `document_fk_created_by_acl_user_id` FOREIGN KEY (`created_by_acl_user_id`) REFERENCES `acl_user` (`id`), '+
            '   CONSTRAINT `document_fk_updated_by_acl_role_id` FOREIGN KEY (`updated_by_acl_user_id`) REFERENCES `acl_user` (`id`) '+
            ' ) ';
end;

function TDocumentSQLBuilderMySQL.ScriptSeedTable: String;
begin
  Result := '';
end;

end.
