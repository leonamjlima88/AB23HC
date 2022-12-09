unit uAclUser.Mapper;

interface

uses
  uAclUser,
  Data.DB,
  DataSet.Serialize,
  XSuperObject;

type
  TAclUserMapper = class
  public
    class function DataSetToEntity(const ADtsAclUser: TDataSet): TAclUser;
  end;

implementation

uses
  uHlp;

{ TAclUserMapper }

class function TAclUserMapper.DataSetToEntity(const ADtsAclUser: TDataSet): TAclUser;
begin
  Result := TAclUser.FromJSON(ADtsAclUser.ToJSONObjectString);

  // AclUser
  Result.is_superuser := THlp.IntBool(ADtsAclUser.FieldByName('is_superuser').AsInteger);

  // Virtuais
  Result.acl_role.id   := ADtsAclUser.FieldByName('acl_role_id').AsLargeInt;
  Result.acl_role.name := ADtsAclUser.FieldByName('acl_role_name').AsString;
end;

end.


