unit uBase.Repository.Interfaces;

interface

uses
  uZLConnection.Interfaces,
  uBase.Entity,
  Data.DB,
  uPageFilter,
  uSelectWithFilter,
  uIndexResult;

type
  IBaseRepository = Interface
    ['{5C559435-CF16-4128-8F11-E403508CDB35}']

    function Conn: IZLConnection;
    function Delete(AId: Int64; ATenantId: Int64 = 0): Boolean;
    function Index(APageFilter: IPageFilter): IIndexResult;
    function ShowById(AId: Int64; ATenantId: Int64 = 0): TBaseEntity;
    function Store(AEntity: TBaseEntity): Int64;
    function Update(AEntity: TBaseEntity; AId: Int64): Boolean;
    function DataSetToEntity(ADtsBrand: TDataSet): TBaseEntity;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
  end;

implementation

end.
