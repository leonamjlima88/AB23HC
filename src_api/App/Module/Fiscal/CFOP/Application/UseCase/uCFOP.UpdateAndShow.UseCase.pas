unit uCFOP.UpdateAndShow.UseCase;

interface

uses
  uCFOP.DTO,
  uCFOP.Show.DTO,
  uCFOP.Repository.Interfaces;

type
  ICFOPUpdateAndShowUseCase = Interface
    ['{D92E72A1-E818-4496-B76C-6AECC7C1B870}']
    function Execute(AInput: TCFOPDTO; APK: Int64): TCFOPShowDTO;
  end;

  TCFOPUpdateAndShowUseCase = class(TInterfacedObject, ICFOPUpdateAndShowUseCase)
  private
    FRepository: ICFOPRepository;
    constructor Create(ARepository: ICFOPRepository);
  public
    class function Make(ARepository: ICFOPRepository): ICFOPUpdateAndShowUseCase;
    function Execute(AInput: TCFOPDTO; APK: Int64): TCFOPShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uCFOP,
  System.SysUtils,
  uCFOP.Mapper;

{ TCFOPUpdateAndShowUseCase }

constructor TCFOPUpdateAndShowUseCase.Create(ARepository: ICFOPRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TCFOPUpdateAndShowUseCase.Execute(AInput: TCFOPDTO; APK: Int64): TCFOPShowDTO;
var
  lCFOPToUpdate: Shared<TCFOP>;
  lCFOPUpdated: Shared<TCFOP>;
begin
  // Carregar dados em Entity
  lCFOPToUpdate := TCFOPMapper.CFOPDtoToEntity(AInput);
  With lCFOPToUpdate.Value do
  begin
    id         := APK;
    updated_at := now;
    Validate;
  end;

  // Atualizar e Localizar registro atualizado
  FRepository.Update(lCFOPToUpdate, APK);
  lCFOPUpdated := FRepository.Show(APK);

  // Retornar DTO
  Result := TCFOPMapper.EntityToCFOPShowDto(lCFOPUpdated);
end;

class function TCFOPUpdateAndShowUseCase.Make(ARepository: ICFOPRepository): ICFOPUpdateAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
