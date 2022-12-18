unit uNCM.SQLBuilder.MySQL;

interface

uses
  uNCM.SQLBuilder,
  uNCM.SQLBuilder.Interfaces;

type
  TNCMSQLBuilderMySQL = class(TNCMSQLBuilder, INCMSQLBuilder)
  public
    constructor Create;
    class function Make: INCMSQLBuilder;
    function ScriptCreateTable: String; override;
    function ScriptSeedTable: String; override;
  end;

implementation

uses
  cqlbr.interfaces;

{ TNCMSQLBuilderMySQL }

constructor TNCMSQLBuilderMySQL.Create;
begin
  inherited Create;
  FDBName := dbnMySQL;
end;

class function TNCMSQLBuilderMySQL.Make: INCMSQLBuilder;
begin
  Result := Self.Create;
end;

function TNCMSQLBuilderMySQL.ScriptCreateTable: String;
begin
  Result := ' CREATE TABLE `ncm` ( '+
            '   `id` bigint(20) NOT NULL AUTO_INCREMENT, '+
            '   `name` varchar(255) DEFAULT NULL, '+
            '   `ncm` varchar(45) NOT NULL, '+
            '   `national_rate` decimal(18,4) DEFAULT NULL, '+
            '   `imported_rate` decimal(18,4) DEFAULT NULL, '+
            '   `state_rate` decimal(18,4) DEFAULT NULL, '+
            '   `municipal_rate` decimal(18,4) DEFAULT NULL, '+
            '   `cest` varchar(45) DEFAULT NULL, '+
            '   `additional_information` text, '+
            '   `start_of_validity` date DEFAULT NULL, '+
            '   `end_of_validity` date DEFAULT NULL, '+
            '   `created_at` datetime DEFAULT NULL, '+
            '   `updated_at` datetime DEFAULT NULL, '+
            '   `created_by_acl_user_id` bigint(20) DEFAULT NULL, '+
            '   `updated_by_acl_user_id` bigint(20) DEFAULT NULL, '+
            '   PRIMARY KEY (`id`), '+
            '   KEY `ncm_fk_created_by_acl_user_id` (`created_by_acl_user_id`), '+
            '   KEY `ncm_fk_updated_by_acl_user_id` (`updated_by_acl_user_id`), '+
            '   KEY `ncm_idx_cest` (`cest`), '+
            '   KEY `ncm_idx_start_of_validity` (`start_of_validity`), '+
            '   KEY `ncm_idx_end_of_validity` (`end_of_validity`), '+
            '   CONSTRAINT `ncm_fk_created_by_acl_user_id` FOREIGN KEY (`created_by_acl_user_id`) REFERENCES `acl_user` (`id`), '+
            '   CONSTRAINT `ncm_fk_updated_by_acl_user_id` FOREIGN KEY (`updated_by_acl_user_id`) REFERENCES `acl_user` (`id`) '+
            ' ) ';
end;

function TNCMSQLBuilderMySQL.ScriptSeedTable: String;
begin
  Result := '';
end;

end.
