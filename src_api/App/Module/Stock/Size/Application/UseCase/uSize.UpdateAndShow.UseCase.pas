unit uSize.UpdateAndShow.UseCase;

interface

uses
  uSize.DTO,
  uSize.Show.DTO,
  uSize.Repository.Interfaces;

type
  ISizeUpdateAndShowUseCase = Interface
['{51C5860E-D044-40F1-9AEA-E0F08E96A30B}']
    function Execute(AInput: TSizeDTO; APK: Int64): TSizeShowDTO;
  end;

  TSizeUpdateAndShowUseCase = class(TInterfacedObject, ISizeUpdateAndShowUseCase)
  private
    FRepository: ISizeRepository;
    constructor Create(ARepository: ISizeRepository);
  public
    class function Make(ARepository: ISizeRepository): ISizeUpdateAndShowUseCase;
    function Execute(AInput: TSizeDTO; APK: Int64): TSizeShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uSize,
  System.SysUtils,
  uSize.Mapper;

{ TSizeUpdateAndShowUseCase }

constructor TSizeUpdateAndShowUseCase.Create(ARepository: ISizeRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TSizeUpdateAndShowUseCase.Execute(AInput: TSizeDTO; APK: Int64): TSizeShowDTO;
var
  lSizeToUpdate: Shared<TSize>;
  lSizeUpdated: Shared<TSize>;
begin
  // Carregar dados em Entity
  lSizeToUpdate := TSizeMapper.SizeDtoToEntity(AInput);
  With lSizeToUpdate.Value do
  begin
    id := APK;
    Validate;
  end;

  // Atualizar e Localizar registro atualizado
  FRepository.Update(lSizeToUpdate, APK);
  lSizeUpdated := FRepository.Show(APK, AInput.tenant_id);

  // Retornar DTO
  Result := TSizeMapper.EntityToSizeShowDto(lSizeUpdated);
end;

class function TSizeUpdateAndShowUseCase.Make(ARepository: ISizeRepository): ISizeUpdateAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
