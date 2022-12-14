unit uPerson.Show.UseCase;

interface

uses
  uPerson.Repository.Interfaces,
  uPerson.Show.DTO;

type
  IPersonShowUseCase = Interface
    ['{98591DAC-EFA1-48B3-B656-A60B2BDB55BA}']
    function Execute(APK, ATenantId: Int64): TPersonShowDTO;
  end;

  TPersonShowUseCase = class(TInterfacedObject, IPersonShowUseCase)
  private
    FRepository: IPersonRepository;
    constructor Create(ARepository: IPersonRepository);
  public
    class function Make(ARepository: IPersonRepository): IPersonShowUseCase;
    function Execute(APK, ATenantId: Int64): TPersonShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uPerson,
  uHlp,
  XSuperObject,
  System.SysUtils,
  uApplication.Types,
  uPerson.Mapper;

{ TPersonShowUseCase }

constructor TPersonShowUseCase.Create(ARepository: IPersonRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TPersonShowUseCase.Execute(APK, ATenantId: Int64): TPersonShowDTO;
var
  lPersonFound: Shared<TPerson>;
begin
  Result := Nil;

  // Localizar Registro
  lPersonFound := FRepository.Show(APK, ATenantId);
  if not Assigned(lPersonFound.Value) then
    Exit;

  // Retornar DTO
  Result := TPersonMapper.EntityToPersonShowDto(lPersonFound.Value);
end;

class function TPersonShowUseCase.Make(ARepository: IPersonRepository): IPersonShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
