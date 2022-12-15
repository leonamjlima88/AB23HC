unit uCategory.Delete.UseCase;

interface

uses
  uCategory.Repository.Interfaces;

type
  ICategoryDeleteUseCase = Interface
    ['{EE59D8A3-8442-4FD1-ACD5-5A05FE1BC79A}']
    function Execute(APK: Int64): Boolean;
  end;

  TCategoryDeleteUseCase = class(TInterfacedObject, ICategoryDeleteUseCase)
  private
    FRepository: ICategoryRepository;
    constructor Create(ARepository: ICategoryRepository);
  public
    class function Make(ARepository: ICategoryRepository): ICategoryDeleteUseCase;
    function Execute(APK: Int64): Boolean;
  end;

implementation

{ TCategoryDeleteUseCase }

constructor TCategoryDeleteUseCase.Create(ARepository: ICategoryRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TCategoryDeleteUseCase.Execute(APK: Int64): Boolean;
begin
  // Deletar Registro
  Result := FRepository.Delete(APK);
end;

class function TCategoryDeleteUseCase.Make(ARepository: ICategoryRepository): ICategoryDeleteUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
