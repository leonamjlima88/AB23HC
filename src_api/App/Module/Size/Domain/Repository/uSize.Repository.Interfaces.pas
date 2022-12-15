unit uSize.Repository.Interfaces;

interface

uses
  uBase.Repository.Interfaces,
  uSize;

type
  ISizeRepository = interface(IBaseRepository)
    ['{B598F0C8-B708-43C4-B015-84BAA83575D1}']
    function Show(AId: Int64): TSize;
  end;

implementation

end.


