unit uBase.SQLBuilder.Interfaces;

interface

uses
  uApplication.Types,
  uBase.Entity;

type
  IBaseSQLBuilder = interface
    ['{FF5034FC-76B7-4CD0-BED9-70976A2D3500}']

    function ScriptCreateTable: String;
    function DeleteById(AId: Int64): String;
    function SelectById(AId: Int64): String;
    function InsertInto(AEntity: TBaseEntity): String;
    function LastInsertId: String;
    function Update(AEntity: TBaseEntity; AId: Int64): String;
  end;

implementation

end.
