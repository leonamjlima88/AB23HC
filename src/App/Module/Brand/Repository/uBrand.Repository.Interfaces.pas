unit uBrand.Repository.Interfaces;

interface

uses
  uBase.Repository.Interfaces,
  uBrand;

type
  IBrandRepository = interface(IBaseRepository)
    ['{B598F0C8-B708-43C4-B015-84BAA83575D1}']
    function Show(AId: Int64): TBrand;
  end;

implementation

end.


