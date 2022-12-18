unit uStorageLocation.Delete.UseCase;

interface

uses
  uStorageLocation.Repository.Interfaces;

type
  IStorageLocationDeleteUseCase = Interface
['{5CB7E47F-A461-4267-B3E0-E872CF909D61}']
    function Execute(APK: Int64): Boolean;
  end;

  TStorageLocationDeleteUseCase = class(TInterfacedObject, IStorageLocationDeleteUseCase)
  private
    FRepository: IStorageLocationRepository;
    constructor Create(ARepository: IStorageLocationRepository);
  public
    class function Make(ARepository: IStorageLocationRepository): IStorageLocationDeleteUseCase;
    function Execute(APK: Int64): Boolean;
  end;

implementation

{ TStorageLocationDeleteUseCase }

constructor TStorageLocationDeleteUseCase.Create(ARepository: IStorageLocationRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TStorageLocationDeleteUseCase.Execute(APK: Int64): Boolean;
begin
  // Deletar Registro
  Result := FRepository.Delete(APK);
end;

class function TStorageLocationDeleteUseCase.Make(ARepository: IStorageLocationRepository): IStorageLocationDeleteUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
