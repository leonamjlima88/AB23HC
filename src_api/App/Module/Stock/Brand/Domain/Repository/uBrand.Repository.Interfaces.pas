unit uBrand.Repository.Interfaces;

interface

uses
  uBase.Repository.Interfaces,
  uBrand;

type
  IBrandRepository = interface(IBaseRepository)
    ['{023B5E3F-13ED-4D1A-AAFA-AF0284EFFCD5}']
    function Show(AId: Int64): TBrand;
  end;

implementation

end.


