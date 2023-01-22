unit uPerson.ShowByIdAndPersonType.UseCase;

interface

uses
  uPerson.Repository.Interfaces,
  uPerson.Show.DTO,
  uPersonShowByIdAndPersonType.DTO;

type
  IPersonShowByIdAndPersonTypeUseCase = Interface
    ['{13049B22-3816-4843-8CD2-8F8F09E04DDF}']
    function Execute(AInput: TPersonShowByIdAndPersonTypeDTO): TPersonShowDTO;
  end;

  TPersonShowByIdAndPersonTypeUseCase = class(TInterfacedObject, IPersonShowByIdAndPersonTypeUseCase)
  private
    FRepository: IPersonRepository;
    constructor Create(ARepository: IPersonRepository);
  public
    class function Make(ARepository: IPersonRepository): IPersonShowByIdAndPersonTypeUseCase;
    function Execute(AInput: TPersonShowByIdAndPersonTypeDTO): TPersonShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uPerson,
  uHlp,
  XSuperObject,
  System.SysUtils,
  uApplication.Types,
  uPerson.Mapper,
  uPageFilter,
  uIndexResult;

{ TPersonShowByIdAndPersonTypeUseCase }

constructor TPersonShowByIdAndPersonTypeUseCase.Create(ARepository: IPersonRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TPersonShowByIdAndPersonTypeUseCase.Execute(AInput: TPersonShowByIdAndPersonTypeDTO): TPersonShowDTO;
const
  IS_TRUE = '1';
var
  lPersonFound: Shared<TPerson>;
  lPageFilter: IPageFilter;
  lIndexResult: IIndexResult;
begin
  Result := Nil;

  // Filtro de dados
  lPageFilter := TPageFilter.Make
    .AddWhere('person.id',        coEqual, AInput.id.ToString)
    .AddWhere('person.tenant_id', coEqual, AInput.tenant_id.ToString);
  if (AInput.is_customer > 0)   then lPageFilter.AddOrWhere('person.is_customer',   coEqual, IS_TRUE);
  if (AInput.is_seller > 0)     then lPageFilter.AddOrWhere('person.is_seller',     coEqual, IS_TRUE);
  if (AInput.is_supplier > 0)   then lPageFilter.AddOrWhere('person.is_supplier',   coEqual, IS_TRUE);
  if (AInput.is_carrier > 0)    then lPageFilter.AddOrWhere('person.is_carrier',    coEqual, IS_TRUE);
  if (AInput.is_technician > 0) then lPageFilter.AddOrWhere('person.is_technician', coEqual, IS_TRUE);
  if (AInput.is_employee > 0)   then lPageFilter.AddOrWhere('person.is_employee',   coEqual, IS_TRUE);
  if (AInput.is_other > 0)      then lPageFilter.AddOrWhere('person.is_other',      coEqual, IS_TRUE);

  // Localizar Registro
  lIndexResult := FRepository.Index(lPageFilter);
  if lIndexResult.Data.DataSet.IsEmpty then
    Exit;

  // Retornar DTO
  lPersonFound := FRepository.Show(AInput.id, AInput.tenant_id);
  Result       := TPersonMapper.EntityToPersonShowDto(lPersonFound.Value);
end;

class function TPersonShowByIdAndPersonTypeUseCase.Make(ARepository: IPersonRepository): IPersonShowByIdAndPersonTypeUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
