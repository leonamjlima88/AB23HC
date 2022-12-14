unit uBank.UpdateAndShow.UseCase;

interface

uses
  uBank.DTO,
  uBank.Show.DTO,
  uBank.Repository.Interfaces;

type
  IBankUpdateAndShowUseCase = Interface
['{E6B11BF4-7F9B-415A-9486-F21F6051C42A}']
    function Execute(AInput: TBankDTO; APK: Int64): TBankShowDTO;
  end;

  TBankUpdateAndShowUseCase = class(TInterfacedObject, IBankUpdateAndShowUseCase)
  private
    FRepository: IBankRepository;
    constructor Create(ARepository: IBankRepository);
  public
    class function Make(ARepository: IBankRepository): IBankUpdateAndShowUseCase;
    function Execute(AInput: TBankDTO; APK: Int64): TBankShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uBank,
  System.SysUtils,
  uBank.Mapper;

{ TBankUpdateAndShowUseCase }

constructor TBankUpdateAndShowUseCase.Create(ARepository: IBankRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TBankUpdateAndShowUseCase.Execute(AInput: TBankDTO; APK: Int64): TBankShowDTO;
var
  lBankToUpdate: Shared<TBank>;
  lBankUpdated: Shared<TBank>;
begin
  // Carregar dados em Entity
  lBankToUpdate := TBankMapper.BankDtoToEntity(AInput);
  With lBankToUpdate.Value do
  begin
    id := APK;
    Validate;
  end;

  // Atualizar e Localizar registro atualizado
  FRepository.Update(lBankToUpdate, APK);
  lBankUpdated := FRepository.Show(APK);

  // Retornar DTO
  Result := TBankMapper.EntityToBankShowDto(lBankUpdated);
end;

class function TBankUpdateAndShowUseCase.Make(ARepository: IBankRepository): IBankUpdateAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
