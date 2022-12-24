unit uUnit.SQLBuilder.MySQL;

interface

uses
  uUnit.SQLBuilder,
  uUnit.SQLBuilder.Interfaces;

type
  TUnitSQLBuilderMySQL = class(TUnitSQLBuilder, IUnitSQLBuilder)
  public
    constructor Create;
    class function Make: IUnitSQLBuilder;
    function ScriptCreateTable: String; override;
    function ScriptSeedTable: String; override;
  end;

implementation

uses
  cqlbr.interfaces,
  uSmartPointer,
  System.Classes;

{ TUnitSQLBuilderMySQL }

constructor TUnitSQLBuilderMySQL.Create;
begin
  inherited Create;
  FDBName := dbnMySQL;
end;

class function TUnitSQLBuilderMySQL.Make: IUnitSQLBuilder;
begin
  Result := Self.Create;
end;

function TUnitSQLBuilderMySQL.ScriptCreateTable: String;
begin
  Result :=
    ' CREATE TABLE `unit` (                                                                                               '+
    '   `id` bigint(20) NOT NULL AUTO_INCREMENT,                                                                          '+
    '   `name` varchar(10) NOT NULL,                                                                                      '+
    '   `description` varchar(100) DEFAULT NULL,                                                                          '+
    '   `created_at` datetime DEFAULT NULL,                                                                               '+
    '   `updated_at` datetime DEFAULT NULL,                                                                               '+
    '   `created_by_acl_user_id` bigint(20) DEFAULT NULL,                                                                 '+
    '   `updated_by_acl_user_id` bigint(20) DEFAULT NULL,                                                                 '+
    '   PRIMARY KEY (`id`),                                                                                               '+
    '   KEY `unit_idx_name` (`name`),                                                                                     '+
    '   KEY `unit_fk_created_by_acl_user_id` (`created_by_acl_user_id`),                                                  '+
    '   KEY `unit_fk_updated_by_acl_role_id` (`updated_by_acl_user_id`),                                                  '+
    '   CONSTRAINT `unit_fk_created_by_acl_user_id` FOREIGN KEY (`created_by_acl_user_id`) REFERENCES `acl_user` (`id`),  '+
    '   CONSTRAINT `unit_fk_updated_by_acl_role_id` FOREIGN KEY (`updated_by_acl_user_id`) REFERENCES `acl_user` (`id`)   '+
    ' )                                                                                                                   ';
end;

function TUnitSQLBuilderMySQL.ScriptSeedTable: String;
var
  lStrList: Shared<TStringList>;
begin
  lStrList := TStringList.Create;
  lStrList.Value.Add('INSERT INTO `unit` (`id`,`name`,`description`) VALUES (1,''UN'',''Unidade'');');
  lStrList.Value.Add('INSERT INTO `unit` (`id`,`name`,`description`) VALUES (2,''PC'',''Peça'');');
  lStrList.Value.Add('INSERT INTO `unit` (`id`,`name`,`description`) VALUES (3,''KG'',''Quilograma'');');
  lStrList.Value.Add('INSERT INTO `unit` (`id`,`name`,`description`) VALUES (4,''KM'',''Quilômetro'');');
  lStrList.Value.Add('INSERT INTO `unit` (`id`,`name`,`description`) VALUES (5,''MT'',''Metro'');');
  lStrList.Value.Add('INSERT INTO `unit` (`id`,`name`,`description`) VALUES (6,''DM'',''Decímetro'');');
  lStrList.Value.Add('INSERT INTO `unit` (`id`,`name`,`description`) VALUES (7,''CM'',''Centímetro'');');
  lStrList.Value.Add('INSERT INTO `unit` (`id`,`name`,`description`) VALUES (8,''MM'',''Milímetro'');');
  lStrList.Value.Add('INSERT INTO `unit` (`id`,`name`,`description`) VALUES (9,''G'',''Grama'');');
  lStrList.Value.Add('INSERT INTO `unit` (`id`,`name`,`description`) VALUES (10,''CG'',''Centigrama'');');
  lStrList.Value.Add('INSERT INTO `unit` (`id`,`name`,`description`) VALUES (11,''MG'',''Miligrama'');');
  lStrList.Value.Add('INSERT INTO `unit` (`id`,`name`,`description`) VALUES (12,''LT'',''Litro'');');
  lStrList.Value.Add('INSERT INTO `unit` (`id`,`name`,`description`) VALUES (13,''CL'',''Centilitro'');');
  lStrList.Value.Add('INSERT INTO `unit` (`id`,`name`,`description`) VALUES (14,''ML'',''Mililitro'');');
  lStrList.Value.Add('INSERT INTO `unit` (`id`,`name`,`description`) VALUES (15,''KM2'',''Quilometro quadrado'');');
  lStrList.Value.Add('INSERT INTO `unit` (`id`,`name`,`description`) VALUES (16,''M2'',''Metro quadrado'');');
  lStrList.Value.Add('INSERT INTO `unit` (`id`,`name`,`description`) VALUES (17,''CM2'',''Centímetro quadrado'');');
  lStrList.Value.Add('INSERT INTO `unit` (`id`,`name`,`description`) VALUES (18,''MM2'',''Milímetro quadrado'');');
  lStrList.Value.Add('INSERT INTO `unit` (`id`,`name`,`description`) VALUES (19,''KM3'',''Quilômetro cúbico'');');
  lStrList.Value.Add('INSERT INTO `unit` (`id`,`name`,`description`) VALUES (20,''M3'',''Metro cúbico'');');
  lStrList.Value.Add('INSERT INTO `unit` (`id`,`name`,`description`) VALUES (21,''CM3'',''Centímetro cúbico'');');
  lStrList.Value.Add('INSERT INTO `unit` (`id`,`name`,`description`) VALUES (22,''MM3'',''Milímetro cúbico'');');

  Result := lStrList.Value.Text;
end;

end.
