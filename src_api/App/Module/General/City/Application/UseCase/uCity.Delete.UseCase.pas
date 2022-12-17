unit uCity.Delete.UseCase;

interface

uses
  uCity.Repository.Interfaces;

type
  ICityDeleteUseCase = Interface
['{EDAEFAB3-1FFA-40EF-87CC-1732B912EBBA}']
    function Execute(APK: Int64): Boolean;
  end;

  TCityDeleteUseCase = class(TInterfacedObject, ICityDeleteUseCase)
  private
    FRepository: ICityRepository;
    constructor Create(ARepository: ICityRepository);
  public
    class function Make(ARepository: ICityRepository): ICityDeleteUseCase;
    function Execute(APK: Int64): Boolean;
  end;

implementation

{ TCityDeleteUseCase }

constructor TCityDeleteUseCase.Create(ARepository: ICityRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TCityDeleteUseCase.Execute(APK: Int64): Boolean;
begin
  // Deletar Registro
  Result := FRepository.Delete(APK);
end;

class function TCityDeleteUseCase.Make(ARepository: ICityRepository): ICityDeleteUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
