unit uAppParam.Show.UseCase;

interface

uses
  uAppParam.Repository.Interfaces,
  uAppParam.Show.DTO;

type
  IAppParamShowUseCase = Interface
    ['{9420BD12-477B-47E3-B66E-AB7243E125F9}']
    function Execute(APK, ATenantId: Int64): TAppParamShowDTO;
  end;

  TAppParamShowUseCase = class(TInterfacedObject, IAppParamShowUseCase)
  private
    FRepository: IAppParamRepository;
    constructor Create(ARepository: IAppParamRepository);
  public
    class function Make(ARepository: IAppParamRepository): IAppParamShowUseCase;
    function Execute(APK, ATenantId: Int64): TAppParamShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uAppParam,
  uHlp,
  XSuperObject,
  System.SysUtils,
  uApplication.Types,
  uAppParam.Mapper;

{ TAppParamShowUseCase }

constructor TAppParamShowUseCase.Create(ARepository: IAppParamRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TAppParamShowUseCase.Execute(APK, ATenantId: Int64): TAppParamShowDTO;
var
  lAppParamFound: Shared<TAppParam>;
begin
  Result := Nil;

  // Localizar Registro
  lAppParamFound := FRepository.Show(APK, ATenantId);
  if not Assigned(lAppParamFound.Value) then
    Exit;

  // Retornar DTO
  Result := TAppParamMapper.EntityToAppParamShowDto(lAppParamFound);
end;

class function TAppParamShowUseCase.Make(ARepository: IAppParamRepository): IAppParamShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
