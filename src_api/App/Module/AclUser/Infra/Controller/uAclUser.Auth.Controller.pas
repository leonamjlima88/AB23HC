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
  uAclUser.Auth.Me.DTO;

Type
  [SwagPath('auth', 'Autenticação')]
  TAclUserAuthController = class
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FRepository: IAclUserRepository;
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
  lAclUserAuthChangePasswordDTO: Shared<TAclUserAuthChangePasswordDTO>;
begin
  // Validar DTO
  lAclUserAuthChangePasswordDTO := TAclUserAuthChangePasswordDTO.FromJSON(FReq.Body);
  SwaggerValidator.Validate(lAclUserAuthChangePasswordDTO);

  // Mudar a Senha
  TAclUserAuthUseCase
    .Make           (FRepository)
    .ChangePassword (lAclUserAuthChangePasswordDTO);

  // Retorno
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

constructor TAclUserAuthController.Create(Req: THorseRequest; Res: THorseResponse);
begin
  FReq               := Req;
  FRes               := Res;
  FRepository := TRepositoryFactory.Make.AclUser;
end;

procedure TAclUserAuthController.Login;
var
  lAclUserAuthLoginDTO: Shared<TAclUserAuthLoginDTO>;
  lAclUserAuthMeDTO: Shared<TAclUserAuthMeDTO>;
begin
  // Validar DTO
  lAclUserAuthLoginDTO := TAclUserAuthLoginDTO.FromJSON(FReq.Body);
  SwaggerValidator.Validate(lAclUserAuthLoginDTO);

  // Efetuar login
  lAclUserAuthMeDTO := TAclUserAuthUseCase
    .Make  (FRepository)
    .Login (lAclUserAuthLoginDTO);

  // Retorno
  TRes.Success(FRes, lAclUserAuthMeDTO.Value, HTTP_CREATED);
end;

procedure TAclUserAuthController.Logout;
var
  lAclUserAuthLoginDTO: Shared<TAclUserAuthLoginDTO>;
begin
  // Validar DTO
  lAclUserAuthLoginDTO := TAclUserAuthLoginDTO.FromJSON(FReq.Body);
  SwaggerValidator.Validate(lAclUserAuthLoginDTO);

  // Efetuar logout
  TAclUserAuthUseCase
    .Make   (FRepository)
    .Logout (lAclUserAuthLoginDTO);

  // Retorno
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

procedure TAclUserAuthController.Me;
begin
  Login;
end;

end.

