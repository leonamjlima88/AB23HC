unit uPerson.Delete.UseCase;

interface

uses
  uPerson.Repository.Interfaces;

type
  IPersonDeleteUseCase = Interface
    ['{0C975B53-23AB-4037-81DE-D835CFF11B43}']
    function Execute(APK: Int64): Boolean;
  end;

  TPersonDeleteUseCase = class(TInterfacedObject, IPersonDeleteUseCase)
  private
    FRepository: IPersonRepository;
    constructor Create(ARepository: IPersonRepository);
  public
    class function Make(ARepository: IPersonRepository): IPersonDeleteUseCase;
    function Execute(APK: Int64): Boolean;
  end;

implementation

{ TPersonDeleteUseCase }

constructor TPersonDeleteUseCase.Create(ARepository: IPersonRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TPersonDeleteUseCase.Execute(APK: Int64): Boolean;
begin
  // Deletar Registro
  Result := FRepository.Delete(APK);
end;

class function TPersonDeleteUseCase.Make(ARepository: IPersonRepository): IPersonDeleteUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
