unit uAppParam.UpdateAndShow.UseCase;

interface

uses
  uAppParam.DTO,
  uAppParam.Show.DTO,
  uAppParam.Repository.Interfaces;

type
  IAppParamUpdateAndShowUseCase = Interface
    ['{72C7ED76-19B5-4490-9FD7-FF2A8AED8052}']
    function Execute(AInput: TAppParamDTO; APK: Int64): TAppParamShowDTO;
  end;

  TAppParamUpdateAndShowUseCase = class(TInterfacedObject, IAppParamUpdateAndShowUseCase)
  private
    FRepository: IAppParamRepository;
    constructor Create(ARepository: IAppParamRepository);
  public
    class function Make(ARepository: IAppParamRepository): IAppParamUpdateAndShowUseCase;
    function Execute(AInput: TAppParamDTO; APK: Int64): TAppParamShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uAppParam,
  XSuperObject,
  System.SysUtils,
  uAppParam.Mapper;

{ TAppParamUpdateAndShowUseCase }

constructor TAppParamUpdateAndShowUseCase.Create(ARepository: IAppParamRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TAppParamUpdateAndShowUseCase.Execute(AInput: TAppParamDTO; APK: Int64): TAppParamShowDTO;
var
  lAppParamToUpdate: Shared<TAppParam>;
  lAppParamUpdated: Shared<TAppParam>;
begin
  // Carregar dados em Entity
  lAppParamToUpdate := TAppParamMapper.AppParamDtoToEntity(AInput);
  With lAppParamToUpdate.Value do
  begin
    id := APK;
    Validate;
  end;

  // Atualizar e Localizar registro atualizado
  FRepository.Update(lAppParamToUpdate, APK);
  lAppParamUpdated := FRepository.Show(APK, AInput.tenant_id);

  // Retornar DTO
  Result := TAppParamMapper.EntityToAppParamShowDto(lAppParamUpdated);
end;

class function TAppParamUpdateAndShowUseCase.Make(ARepository: IAppParamRepository): IAppParamUpdateAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
