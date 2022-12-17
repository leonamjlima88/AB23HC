unit uStorageLocation.Repository.Interfaces;

interface

uses
  uBase.Repository.Interfaces,
  uStorageLocation;

type
  IStorageLocationRepository = interface(IBaseRepository)
['{DA5E9DE9-4926-4F0F-BE80-5F5DC83DD440}']
    function Show(AId: Int64): TStorageLocation;
  end;

implementation

end.


