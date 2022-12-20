unit uOperationType.Repository.Interfaces;

interface

uses
  uBase.Repository.Interfaces,
  uOperationType;

type
  IOperationTypeRepository = interface(IBaseRepository)
    ['{023B5E3F-13ED-4D1A-AAFA-AF0284EFFCD5}']
    function Show(AId, ATenantId: Int64): TOperationType;
  end;

implementation

end.


