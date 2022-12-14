unit uPaymentTerm.Show.UseCase;

interface

uses
  uPaymentTerm.Repository.Interfaces,
  uPaymentTerm.Show.DTO;

type
  IPaymentTermShowUseCase = Interface
    ['{768BA1BB-108D-420C-9781-4C63A243846A}']
    function Execute(APK, ATenantId: Int64): TPaymentTermShowDTO;
  end;

  TPaymentTermShowUseCase = class(TInterfacedObject, IPaymentTermShowUseCase)
  private
    FRepository: IPaymentTermRepository;
    constructor Create(ARepository: IPaymentTermRepository);
  public
    class function Make(ARepository: IPaymentTermRepository): IPaymentTermShowUseCase;
    function Execute(APK, ATenantId: Int64): TPaymentTermShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uPaymentTerm,
  uPaymentTerm.Mapper,
  uHlp,
  System.SysUtils,
  uApplication.Types;

{ TPaymentTermShowUseCase }

constructor TPaymentTermShowUseCase.Create(ARepository: IPaymentTermRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TPaymentTermShowUseCase.Execute(APK, ATenantId: Int64): TPaymentTermShowDTO;
var
  lPaymentTermFound: Shared<TPaymentTerm>;
begin
  Result := Nil;

  // Localizar Registro
  lPaymentTermFound := FRepository.Show(APK, ATenantId);
  if not Assigned(lPaymentTermFound.Value) then
    Exit;

  // Retornar DTO
  Result := TPaymentTermMapper.EntityToPaymentTermShowDto(lPaymentTermFound);
end;

class function TPaymentTermShowUseCase.Make(ARepository: IPaymentTermRepository): IPaymentTermShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
