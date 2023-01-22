unit uAclUser.Auth.Controller;

interface

uses
  Horse,
  Horse.GBSwagger,
  GBSwagger.Path.Registry,
  GBSwagger.Path.Attributes,
  GBSwagger.Validator.Interfaces,
  uAclUser.Repository.Interfaces,
  uAclUser.Auth.Login.DTO,
  uApplication.Types,
  uAclUser.Auth.ChangePassword.DTO,
  uAclUser.Auth.Me.DTO,
  uAppParam.Repository.Interfaces,
  uTenant.Repository.Interfaces;

Type
  [SwagPath('auth', 'Autenticação')]
  TAclUserAuthController = class
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FRepository: IAclUserRepository;
    FAppParamRepository: IAppParamRepository;
  public
    constructor Create(Req: THorseRequest; Res: THorseResponse);

    [SwagPOST('/login', 'Login')]
    [SwagParamBody('body', TAclUserAuthLoginDTO)]
    [SwagResponse(HTTP_OK, TAclUserAuthMeResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Login;

    [SwagPOST('/me', 'Me')]
    [SwagParamBody('body', TAclUserAuthLoginDTO)]
    [SwagResponse(HTTP_OK, TAclUserAuthMeResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Me;

    [SwagPOST('/logout', 'Logout')]
    [SwagParamBody('body', TAclUserAuthLoginDTO)]
    [SwagResponse(HTTP_OK, nil)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Logout;

    [SwagPUT('/change_password', 'Mudar a senha')]
    [SwagParamBody('body', TAclUserAuthChangePasswordDTO)]
    [SwagResponse(HTTP_OK, nil)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure ChangePassword;
  end;

implementation

uses
  uRepository.Factory,
  uSmartPointer,
  XSuperObject,
  uAclUser.Auth.UseCase,
  uRes;

{ TAclUserAuthController }

procedure TAclUserAuthController.ChangePassword;
var
  lInput: Shared<TAclUserAuthChangePasswordDTO>;
begin
  // Validar DTO
  lInput := TAclUserAuthChangePasswordDTO.FromJSON(FReq.Body);
  SwaggerValidator.Validate(lInput);

  // Mudar a Senha
  TAclUserAuthUseCase
    .Make           (FRepository, FAppParamRepository)
    .ChangePassword (lInput);

  // Retorno
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

constructor TAclUserAuthController.Create(Req: THorseRequest; Res: THorseResponse);
begin
  FReq                := Req;
  FRes                := Res;
  FRepository         := TRepositoryFactory.Make.AclUser;
  FAppParamRepository := TRepositoryFactory.Make(FRepository.Conn).AppParam;
end;

procedure TAclUserAuthController.Login;
var
  lInput:  Shared<TAclUserAuthLoginDTO>;
  lResult: Shared<TAclUserAuthMeDTO>;
begin
  // Validar DTO
  lInput := TAclUserAuthLoginDTO.FromJSON(FReq.Body);
  SwaggerValidator.Validate(lInput);

  // Efetuar login
  lResult := TAclUserAuthUseCase
    .Make  (FRepository, FAppParamRepository)
    .Login (lInput);

  // Retorno
  TRes.Success(FRes, lResult.Value);
end;

procedure TAclUserAuthController.Logout;
var
  lInput: Shared<TAclUserAuthLoginDTO>;
begin
  // Validar DTO
  lInput := TAclUserAuthLoginDTO.FromJSON(FReq.Body);
  SwaggerValidator.Validate(lInput);

  // Efetuar logout
  TAclUserAuthUseCase
    .Make   (FRepository, FAppParamRepository)
    .Logout (lInput);

  // Retorno
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

procedure TAclUserAuthController.Me;
begin
  Login;
end;

end.

