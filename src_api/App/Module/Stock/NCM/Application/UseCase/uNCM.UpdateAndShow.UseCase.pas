unit uNCM.UpdateAndShow.UseCase;

interface

uses
  uNCM.DTO,
  uNCM.Show.DTO,
  uNCM.Repository.Interfaces;

type
  INCMUpdateAndShowUseCase = Interface
    ['{D92E72A1-E818-4496-B76C-6AECC7C1B870}']
    function Execute(AInput: TNCMDTO; APK: Int64): TNCMShowDTO;
  end;

  TNCMUpdateAndShowUseCase = class(TInterfacedObject, INCMUpdateAndShowUseCase)
  private
    FRepository: INCMRepository;
    constructor Create(ARepository: INCMRepository);
  public
    class function Make(ARepository: INCMRepository): INCMUpdateAndShowUseCase;
    function Execute(AInput: TNCMDTO; APK: Int64): TNCMShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uNCM,
  System.SysUtils,
  uNCM.Mapper;

{ TNCMUpdateAndShowUseCase }

constructor TNCMUpdateAndShowUseCase.Create(ARepository: INCMRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TNCMUpdateAndShowUseCase.Execute(AInput: TNCMDTO; APK: Int64): TNCMShowDTO;
var
  lNCMToUpdate: Shared<TNCM>;
  lNCMUpdated: Shared<TNCM>;
begin
  // Carregar dados em Entity
  lNCMToUpdate := TNCMMapper.NCMDtoToEntity(AInput);
  With lNCMToUpdate.Value do
  begin
    id := APK;
    Validate;
  end;

  // Atualizar e Localizar registro atualizado
  FRepository.Update(lNCMToUpdate, APK);
  lNCMUpdated := FRepository.Show(APK);

  // Retornar DTO
  Result := TNCMMapper.EntityToNCMShowDto(lNCMUpdated);
end;

class function TNCMUpdateAndShowUseCase.Make(ARepository: INCMRepository): INCMUpdateAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
