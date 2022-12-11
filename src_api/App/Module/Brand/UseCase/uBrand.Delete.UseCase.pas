unit uBrand.Delete.UseCase;

interface

uses
  uBrand.Repository.Interfaces;

type
  IBrandDeleteUseCase = Interface
    ['{0C975B53-23AB-4037-81DE-D835CFF11B43}']
    function Execute(APK: Int64): Boolean;
  end;

  TBrandDeleteUseCase = class(TInterfacedObject, IBrandDeleteUseCase)
  private
    FRepository: IBrandRepository;
    constructor Create(ARepository: IBrandRepository);
  public
    class function Make(ARepository: IBrandRepository): IBrandDeleteUseCase;
    function Execute(APK: Int64): Boolean;
  end;

implementation

{ TBrandDeleteUseCase }

constructor TBrandDeleteUseCase.Create(ARepository: IBrandRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TBrandDeleteUseCase.Execute(APK: Int64): Boolean;
begin
  // Deletar Registro
  Result := FRepository.Delete(APK);
end;

class function TBrandDeleteUseCase.Make(ARepository: IBrandRepository): IBrandDeleteUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
