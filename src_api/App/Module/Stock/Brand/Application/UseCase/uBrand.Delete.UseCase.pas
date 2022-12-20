unit uBrand.Delete.UseCase;

interface

uses
  uBrand.Repository.Interfaces;

type
  IBrandDeleteUseCase = Interface
    ['{596944D4-AC7E-4612-8539-C7B4EF1316F5}']
    function Execute(APK, ATenantId: Int64): Boolean;
  end;

  TBrandDeleteUseCase = class(TInterfacedObject, IBrandDeleteUseCase)
  private
    FRepository: IBrandRepository;
    constructor Create(ARepository: IBrandRepository);
  public
    class function Make(ARepository: IBrandRepository): IBrandDeleteUseCase;
    function Execute(APK, ATenantId: Int64): Boolean;
  end;

implementation

{ TBrandDeleteUseCase }

constructor TBrandDeleteUseCase.Create(ARepository: IBrandRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TBrandDeleteUseCase.Execute(APK, ATenantId: Int64): Boolean;
begin
  // Deletar Registro
  Result := FRepository.Delete(APK, ATenantId);
end;

class function TBrandDeleteUseCase.Make(ARepository: IBrandRepository): IBrandDeleteUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
