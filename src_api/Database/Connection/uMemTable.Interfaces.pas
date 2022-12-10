unit uMemTable.Interfaces;

interface

uses
  Data.DB;

type
  IMemTable = interface
    ['{A33A8267-08DE-482A-B9B4-984E3F6A81A4}']

    function FromDataSet(ADataSet: TDataSet): IMemTable;
    function DataSet: TDataSet;
    function FieldDefs: TFieldDefs;
    function CreateDataSet: IMemTable;
    function Active: Boolean; overload;
    function Active(AValue: Boolean): IMemTable; overload;
    function EmptyDataSet: IMemTable;
    function Locate(AKeyFields, AKeyValues: Variant): Boolean;
    function AddField(AFieldName: String; AFieldType: TFieldType; ASize: Integer = 0; AFieldKind: TFieldKind = fkData): IMemTable;
  end;


implementation

end.
