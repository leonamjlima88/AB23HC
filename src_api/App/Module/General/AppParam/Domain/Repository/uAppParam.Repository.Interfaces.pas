unit uAppParam.Repository.Interfaces;

interface

uses
  uBase.Repository.Interfaces,
  uAppParam,
  System.Generics.Collections;

type
  IAppParamRepository = interface(IBaseRepository)
    ['{474F1489-341C-47D1-BBE9-6D2AEBBFA91B}']
    function Show(AId, ATenantId: Int64): TAppParam;
    function DeleteManyByGroup(AGroupName: String; ATenantId: Int64): IAppParamRepository;
  end;

implementation

end.


