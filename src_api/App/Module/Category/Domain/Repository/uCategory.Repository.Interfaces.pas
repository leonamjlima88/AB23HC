unit uCategory.Repository.Interfaces;

interface

uses
  uBase.Repository.Interfaces,
  uCategory;

type
  ICategoryRepository = interface(IBaseRepository)
    ['{7A5BF516-4DAA-4C70-AB59-142B7D9ABFF3}']
    function Show(AId: Int64): TCategory;
  end;

implementation

end.


