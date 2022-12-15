unit uCity.Repository.Interfaces;

interface

uses
  uBase.Repository.Interfaces,
  uCity;

type
  ICityRepository = interface(IBaseRepository)
['{8E03D158-E8F9-43CC-B3FE-EBD45B1DA7BD}']
    function Show(AId: Int64): TCity;
  end;

implementation

end.


