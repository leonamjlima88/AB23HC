unit uSize.UpdateAndShow.UseCase;

interface

uses
  uSize.DTO,
  uSize.Show.DTO,
  uSize.Repository.Interfaces;

type
  ISizeUpdateAndShowUseCase = Interface
    ['{2537BB66-AF57-4B53-BA41-9A5CF02EFC29}']
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
  XSuperObject,
  System.SysUtils;

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
  lSizeToUpdate := TSize.FromJSON(AInput.AsJSON);
  With lSizeToUpdate.Value do
  begin
    id         := APK;
    updated_at := now;
    Validate;
  end;

  // Atualizar e Localizar registro atualizado
  FRepository.Update(lSizeToUpdate, APK);
  lSizeUpdated := FRepository.Show(APK);

  // Retornar DTO
  Result := TSizeShowDTO.FromEntity(lSizeUpdated.Value);
end;

class function TSizeUpdateAndShowUseCase.Make(ARepository: ISizeRepository): ISizeUpdateAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.