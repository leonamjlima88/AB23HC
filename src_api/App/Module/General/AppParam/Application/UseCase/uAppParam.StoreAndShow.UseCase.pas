unit uAppParam.StoreAndShow.UseCase;

interface

uses
  uAppParam.DTO,
  uAppParam.Show.DTO,
  uAppParam.Repository.Interfaces;

type
  IAppParamStoreAndShowUseCase = Interface
    ['{CB938D35-4D9D-4F1F-8A2F-130334A8D402}']
    function Execute(AInput: TAppParamDTO): TAppParamShowDTO;
  end;

  TAppParamStoreAndShowUseCase = class(TInterfacedObject, IAppParamStoreAndShowUseCase)
  private
    FRepository: IAppParamRepository;
    constructor Create(ARepository: IAppParamRepository);
  public
    class function Make(ARepository: IAppParamRepository): IAppParamStoreAndShowUseCase;
    function Execute(AInput: TAppParamDTO): TAppParamShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uAppParam,
  XSuperObject,
  uAppParam.Mapper;

{ TAppParamStoreAndShowUseCase }

constructor TAppParamStoreAndShowUseCase.Create(ARepository: IAppParamRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TAppParamStoreAndShowUseCase.Execute(AInput: TAppParamDTO): TAppParamShowDTO;
var
  lAppParamToStore: Shared<TAppParam>;
  lAppParamStored: Shared<TAppParam>;
  lPK: Int64;
begin
  // Carregar dados em Entity
  lAppParamToStore := TAppParamMapper.AppParamDtoToEntity(AInput);
  lAppParamToStore.Value.Validate;

  // Incluir e Localizar registro incluso
  lPK             := FRepository.Store(lAppParamToStore);
  lAppParamStored := FRepository.Show(lPK, AInput.tenant_id);

  // Retornar DTO
  Result := TAppParamMapper.EntityToAppParamShowDto(lAppParamStored);
end;

class function TAppParamStoreAndShowUseCase.Make(ARepository: IAppParamRepository): IAppParamStoreAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
