unit uMigration.Helper;

interface

uses
  uZLConnection.Types;

type
  TMigrationHelper = class
  private
  public
    class function SQLCreateMigrationTable(ADriverDB: TZLDriverDB): String;
    class function SQLLocateMigrationTable(ADriverDB: TZLDriverDB; ADatabase, ATableName: String): String;
  end;

implementation

{ TMigrationHelper }

uses
  System.SysUtils;

class function TMigrationHelper.SQLCreateMigrationTable(ADriverDB: TZLDriverDB): String;
begin
  case ADriverDB of
    ddMySql: Begin
      Result :=
        ' CREATE TABLE `migration` (                         '+
        '   `id` bigint(20) NOT NULL AUTO_INCREMENT,         '+
        '   `description` varchar(255) NOT NULL,             '+
        '   `created_at_by_dev` datetime NOT NULL,           '+
        '   `executed_at` datetime DEFAULT NULL,             '+
        '   `duration` decimal(18,4) DEFAULT NULL,           '+
        '   `batch` varchar(36) DEFAULT NULL,                '+
        '   PRIMARY KEY (`id`),                              '+
        '   KEY `migration_idx_description` (`description`), '+
        '   KEY `migration_idx_batch` (`batch`)              '+
        ' )                                                  ';
    end;
    ddOthers: ; // Exemplo...
  end;
end;

class function TMigrationHelper.SQLLocateMigrationTable(ADriverDB: TZLDriverDB; ADatabase, ATableName: String): String;
begin
  case ADriverDB of
    ddMySql: Begin
      Result :=
        ' SELECT                                     '+
        '   *                                        '+
        ' FROM                                       '+
        '   information_schema.TABLES                '+
        ' WHERE                                      '+
        '   TABLE_SCHEMA = '+ QuotedStr(ADatabase)    +
        ' AND                                        '+
        '   TABLE_NAME = ' + QuotedStr(ATableName)
    End;
    ddOthers: ; // Exemplo...
  end;
end;

end.
