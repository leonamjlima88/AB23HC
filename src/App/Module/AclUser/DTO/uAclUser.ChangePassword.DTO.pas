unit uAclUser.ChangePassword.DTO;

interface

type
  TAclUserChangePasswordDTO = class(TInterfacedObject)
    current_password: string;
    new_password: string;
    login: string;
  end;

implementation

end.
