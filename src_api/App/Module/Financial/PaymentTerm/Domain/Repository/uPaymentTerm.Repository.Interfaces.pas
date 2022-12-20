unit uPaymentTerm.Repository.Interfaces;

interface

uses
  uBase.Repository.Interfaces,
  uPaymentTerm;

type
  IPaymentTermRepository = interface(IBaseRepository)
    ['{023B5E3F-13ED-4D1A-AAFA-AF0284EFFCD5}']
    function Show(AId, ATenantId: Int64): TPaymentTerm;
  end;

implementation

end.


