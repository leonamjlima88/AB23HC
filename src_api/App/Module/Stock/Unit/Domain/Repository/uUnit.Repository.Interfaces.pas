unit uUnit.Repository.Interfaces;

interface

uses
  uBase.Repository.Interfaces,
  uUnit;

type
  IUnitRepository = interface(IBaseRepository)
    ['{B598F0C8-B708-43C4-B015-84BAA83575D1}']
    function Show(AId: Int64): TUnit;
  end;

implementation

end.


