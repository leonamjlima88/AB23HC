unit uSale.Show.UseCase;

interface

uses
  uSale.Repository.Interfaces,
  uSale.Show.DTO;

type
  ISaleShowUseCase = Interface
    ['{CFF47EFD-2AB1-47BE-AD71-9A3496488E9F}']
    function Execute(APK, ATenantId: Int64): TSaleShowDTO;
  end;

  TSaleShowUseCase = class(TInterfacedObject, ISaleShowUseCase)
  private
    FRepository: ISaleRepository;
    constructor Create(ARepository: ISaleRepository);
  public
    class function Make(ARepository: ISaleRepository): ISaleShowUseCase;
    function Execute(APK, ATenantId: Int64): TSaleShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uSale,
  uHlp,
  XSuperObject,
  System.SysUtils,
  uApplication.Types,
  uSale.Mapper;

{ TSaleShowUseCase }

constructor TSaleShowUseCase.Create(ARepository: ISaleRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TSaleShowUseCase.Execute(APK, ATenantId: Int64): TSaleShowDTO;
var
  lSaleFound: Shared<TSale>;
begin
  Result := Nil;

  // Localizar Registro
  lSaleFound := FRepository.Show(APK, ATenantId);
  if not Assigned(lSaleFound.Value) then
    Exit;

  // Retornar DTO
  Result := TSaleMapper.EntityToSaleShowDto(lSaleFound.Value);
end;

class function TSaleShowUseCase.Make(ARepository: ISaleRepository): ISaleShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
