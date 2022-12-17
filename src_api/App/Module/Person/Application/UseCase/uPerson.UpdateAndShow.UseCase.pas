unit uPerson.UpdateAndShow.UseCase;

interface

uses
  uPerson.DTO,
  uPerson.Show.DTO,
  uPerson.Repository.Interfaces;

type
  IPersonUpdateAndShowUseCase = Interface
    ['{2537BB66-AF57-4B53-BA41-9A5CF02EFC29}']
    function Execute(AInput: TPersonDTO; APK: Int64): TPersonShowDTO;
  end;

  TPersonUpdateAndShowUseCase = class(TInterfacedObject, IPersonUpdateAndShowUseCase)
  private
    FRepository: IPersonRepository;
    constructor Create(ARepository: IPersonRepository);
  public
    class function Make(ARepository: IPersonRepository): IPersonUpdateAndShowUseCase;
    function Execute(AInput: TPersonDTO; APK: Int64): TPersonShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uPerson,
  XSuperObject,
  System.SysUtils;

{ TPersonUpdateAndShowUseCase }

constructor TPersonUpdateAndShowUseCase.Create(ARepository: IPersonRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TPersonUpdateAndShowUseCase.Execute(AInput: TPersonDTO; APK: Int64): TPersonShowDTO;
var
  lPersonToUpdate: Shared<TPerson>;
  lPersonUpdated: Shared<TPerson>;
begin
  // Carregar dados em Entity
  lPersonToUpdate := TPerson.FromJSON(AInput.AsJSON);
  With lPersonToUpdate.Value do
  begin
    id         := APK;
    updated_at := now;
    Validate;
  end;

  // Atualizar e Localizar registro atualizado
  FRepository.Update(lPersonToUpdate, APK, true);
  lPersonUpdated := FRepository.Show(APK);

  // Retornar DTO
  Result := TPersonShowDTO.FromEntity(lPersonUpdated.Value);
end;

class function TPersonUpdateAndShowUseCase.Make(ARepository: IPersonRepository): IPersonUpdateAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
