unit uPerson.UpdateAndShow.UseCase;

interface

uses
  uPerson.DTO,
  uPerson.Show.DTO,
  uPerson.Repository.Interfaces;

type
  IPersonUpdateAndShowUseCase = Interface
    ['{89480FD9-7684-44D1-9AE6-F691DA1323A1}']
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
  System.SysUtils,
  uPerson.Mapper;

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
  lPersonToUpdate := TPersonMapper.PersonDtoToEntity(AInput);
  With lPersonToUpdate.Value do
  begin
    id         := APK;
    updated_at := now;
    Validate;
  end;

  // Atualizar e Localizar registro atualizado
  FRepository.Update(lPersonToUpdate, APK, true);
  lPersonUpdated := FRepository.Show(APK, AInput.tenant_id);

  // Retornar DTO
  Result := TPersonMapper.EntityToPersonShowDto(lPersonUpdated.Value);
end;

class function TPersonUpdateAndShowUseCase.Make(ARepository: IPersonRepository): IPersonUpdateAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
