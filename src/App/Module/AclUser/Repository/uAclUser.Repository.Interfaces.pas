unit uAclUser.Repository.Interfaces;

interface

uses
  uBase.Repository.Interfaces,
  uAclUser;

type
  IAclUserRepository = interface(IBaseRepository)
    ['{004B81E6-C3EB-4962-A9E7-E3325722CF6A}']

    function Show(AId: Int64): TAclUser;
  end;

implementation

end.


