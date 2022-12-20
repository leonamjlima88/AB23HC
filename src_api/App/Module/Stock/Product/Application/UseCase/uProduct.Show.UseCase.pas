unit uProduct.Show.UseCase;

interface

uses
  uProduct.Repository.Interfaces,
  uProduct.Show.DTO;

type
  IProductShowUseCase = Interface
    ['{EF49441B-0BCE-4969-BF29-D81734350309}']
    function Execute(APK, ATenantId: Int64): TProductShowDTO;
  end;

  TProductShowUseCase = class(TInterfacedObject, IProductShowUseCase)
  private
    FRepository: IProductRepository;
    constructor Create(ARepository: IProductRepository);
  public
    class function Make(ARepository: IProductRepository): IProductShowUseCase;
    function Execute(APK, ATenantId: Int64): TProductShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uProduct,
  uHlp,
  XSuperObject,
  System.SysUtils,
  uApplication.Types;

{ TProductShowUseCase }

constructor TProductShowUseCase.Create(ARepository: IProductRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TProductShowUseCase.Execute(APK, ATenantId: Int64): TProductShowDTO;
var
  lProductFound: Shared<TProduct>;
begin
  // Localizar Registro
  lProductFound := FRepository.Show(APK, ATenantId);
  if not Assigned(lProductFound.Value) then
    raise Exception.Create(Format(RECORD_NOT_FOUND_WITH_ID, [APK]));

  // Retornar DTO
  Result := TProductShowDTO.FromEntity(lProductFound.Value);
end;

class function TProductShowUseCase.Make(ARepository: IProductRepository): IProductShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
