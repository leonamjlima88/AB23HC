unit uPaymentTerm.UpdateAndShow.UseCase;

interface

uses
  uPaymentTerm.DTO,
  uPaymentTerm.Show.DTO,
  uPaymentTerm.Repository.Interfaces;

type
  IPaymentTermUpdateAndShowUseCase = Interface
    ['{D92E72A1-E818-4496-B76C-6AECC7C1B870}']
    function Execute(AInput: TPaymentTermDTO; APK: Int64): TPaymentTermShowDTO;
  end;

  TPaymentTermUpdateAndShowUseCase = class(TInterfacedObject, IPaymentTermUpdateAndShowUseCase)
  private
    FRepository: IPaymentTermRepository;
    constructor Create(ARepository: IPaymentTermRepository);
  public
    class function Make(ARepository: IPaymentTermRepository): IPaymentTermUpdateAndShowUseCase;
    function Execute(AInput: TPaymentTermDTO; APK: Int64): TPaymentTermShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uPaymentTerm,
  XSuperObject,
  System.SysUtils;

{ TPaymentTermUpdateAndShowUseCase }

constructor TPaymentTermUpdateAndShowUseCase.Create(ARepository: IPaymentTermRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TPaymentTermUpdateAndShowUseCase.Execute(AInput: TPaymentTermDTO; APK: Int64): TPaymentTermShowDTO;
var
  lPaymentTermToUpdate: Shared<TPaymentTerm>;
  lPaymentTermUpdated: Shared<TPaymentTerm>;
begin
  // Carregar dados em Entity
  lPaymentTermToUpdate := TPaymentTerm.FromJSON(AInput.AsJSON);
  With lPaymentTermToUpdate.Value do
  begin
    id         := APK;
    updated_at := now;
    Validate;
  end;

  // Atualizar e Localizar registro atualizado
  FRepository.Update(lPaymentTermToUpdate, APK);
  lPaymentTermUpdated := FRepository.Show(APK);

  // Retornar DTO
  Result := TPaymentTermShowDTO.FromEntity(lPaymentTermUpdated.Value);
end;

class function TPaymentTermUpdateAndShowUseCase.Make(ARepository: IPaymentTermRepository): IPaymentTermUpdateAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
