unit uQry.Interfaces;

interface

uses
  Data.DB;

type
  IQry = Interface
    ['{DAA2CF91-1A34-4539-8191-5BFE8C9190C9}']

    function Open(ASQL: String): IQry;
    function ExecSQL(ASQL: String): IQry;
    function DataSet: TDataSet;
    function Close: IQry;
    function Locate(AKeyFields, AKeyValues: String): Boolean;
  end;

implementation

end.
