unit uProduct.Delete.UseCase;

interface

uses
  uProduct.Repository.Interfaces;

type
  IProductDeleteUseCase = Interface
    ['{0C975B53-23AB-4037-81DE-D835CFF11B43}']
    function Execute(APK: Int64): Boolean;
  end;

  TProductDeleteUseCase = class(TInterfacedObject, IProductDeleteUseCase)
  private
    FRepository: IProductRepository;
    constructor Create(ARepository: IProductRepository);
  public
    class function Make(ARepository: IProductRepository): IProductDeleteUseCase;
    function Execute(APK: Int64): Boolean;
  end;

implementation

{ TProductDeleteUseCase }

constructor TProductDeleteUseCase.Create(ARepository: IProductRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TProductDeleteUseCase.Execute(APK: Int64): Boolean;
begin
  // Deletar Registro
  Result := FRepository.Delete(APK);
end;

class function TProductDeleteUseCase.Make(ARepository: IProductRepository): IProductDeleteUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
