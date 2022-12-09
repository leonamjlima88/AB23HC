unit uAclRole.Repository.Interfaces;

interface

uses
  uBase.Repository.Interfaces,
  uAclRole;

type
  IAclRoleRepository = interface(IBaseRepository)
    ['{BFC833C4-854D-4AD2-8CFD-60BF3E2C87C8}']
    function Show(AId: Int64): TAclRole;
  end;

implementation

end.


