unit uProduct.Delete.UseCase;

interface

uses
  uProduct.Repository.Interfaces;

type
  IProductDeleteUseCase = Interface
    ['{E8C2AB97-C2D8-43ED-BC14-AA3BC5BF0273}']
    function Execute(APK, ATenantId: Int64): Boolean;
  end;

  TProductDeleteUseCase = class(TInterfacedObject, IProductDeleteUseCase)
  private
    FRepository: IProductRepository;
    constructor Create(ARepository: IProductRepository);
  public
    class function Make(ARepository: IProductRepository): IProductDeleteUseCase;
    function Execute(APK, ATenantId: Int64): Boolean;
  end;

implementation

{ TProductDeleteUseCase }

constructor TProductDeleteUseCase.Create(ARepository: IProductRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TProductDeleteUseCase.Execute(APK, ATenantId: Int64): Boolean;
begin
  // Deletar Registro
  Result := FRepository.Delete(APK, ATenantId);
end;

class function TProductDeleteUseCase.Make(ARepository: IProductRepository): IProductDeleteUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
