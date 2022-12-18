unit uCity.SQLBuilder.MySQL;

interface

uses
  uCity.SQLBuilder,
  uCity.SQLBuilder.Interfaces;

type
  TCitySQLBuilderMySQL = class(TCitySQLBuilder, ICitySQLBuilder)
  public
    constructor Create;
    class function Make: ICitySQLBuilder;
    function ScriptCreateTable: String; override;
    function ScriptSeedTable: String; override;
  end;

implementation

uses
  cqlbr.interfaces;

{ TCitySQLBuilderMySQL }

constructor TCitySQLBuilderMySQL.Create;
begin
  inherited Create;
  FDBName := dbnMySQL;
end;

class function TCitySQLBuilderMySQL.Make: ICitySQLBuilder;
begin
  Result := Self.Create;
end;

function TCitySQLBuilderMySQL.ScriptCreateTable: String;
begin
  Result := ' CREATE TABLE `city` ( '+
            '   `id` bigint(20) NOT NULL AUTO_INCREMENT, '+
            '   `name` varchar(100) NOT NULL, '+
            '   `state` char(2) NOT NULL, '+
            '   `country` varchar(100) NOT NULL, '+
            '   `ibge_code` varchar(30) NOT NULL, '+
            '   `country_ibge_code` varchar(30) NOT NULL, '+
            '   `identification` varchar(100), '+
            '   `created_at` datetime, '+
            '   `updated_at` datetime, '+
            '   `created_by_acl_user_id` bigint(20), '+
            '   `updated_by_acl_user_id` bigint(20), '+
            '   PRIMARY KEY (`id`), '+
            '   KEY `city_idx_state` (`state`) '+
            ' ) ';
end;

function TCitySQLBuilderMySQL.ScriptSeedTable: String;
begin
  Result := '';
end;

end.
