unit uCostCenter.Repository.Interfaces;

interface

uses
  uBase.Repository.Interfaces,
  uCostCenter;

type
  ICostCenterRepository = interface(IBaseRepository)
    ['{0BDAAE73-C5D3-4E4F-9422-1A60A080B87E}']
    function Show(AId, ATenantId: Int64): TCostCenter;
  end;

implementation

end.


