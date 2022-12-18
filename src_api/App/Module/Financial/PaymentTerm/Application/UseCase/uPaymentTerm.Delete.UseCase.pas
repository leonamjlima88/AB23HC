unit uPaymentTerm.Delete.UseCase;

interface

uses
  uPaymentTerm.Repository.Interfaces;

type
  IPaymentTermDeleteUseCase = Interface
    ['{596944D4-AC7E-4612-8539-C7B4EF1316F5}']
    function Execute(APK: Int64): Boolean;
  end;

  TPaymentTermDeleteUseCase = class(TInterfacedObject, IPaymentTermDeleteUseCase)
  private
    FRepository: IPaymentTermRepository;
    constructor Create(ARepository: IPaymentTermRepository);
  public
    class function Make(ARepository: IPaymentTermRepository): IPaymentTermDeleteUseCase;
    function Execute(APK: Int64): Boolean;
  end;

implementation

{ TPaymentTermDeleteUseCase }

constructor TPaymentTermDeleteUseCase.Create(ARepository: IPaymentTermRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TPaymentTermDeleteUseCase.Execute(APK: Int64): Boolean;
begin
  // Deletar Registro
  Result := FRepository.Delete(APK);
end;

class function TPaymentTermDeleteUseCase.Make(ARepository: IPaymentTermRepository): IPaymentTermDeleteUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
