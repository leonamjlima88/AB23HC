unit uBank.Show.UseCase;

interface

uses
  uBank.Repository.Interfaces,
  uBank.Show.DTO;

type
  IBankShowUseCase = Interface
['{DB51DEE5-451A-46FF-A3F6-D2C6C59DD5D9}']
    function Execute(APK: Int64): TBankShowDTO;
  end;

  TBankShowUseCase = class(TInterfacedObject, IBankShowUseCase)
  private
    FRepository: IBankRepository;
    constructor Create(ARepository: IBankRepository);
  public
    class function Make(ARepository: IBankRepository): IBankShowUseCase;
    function Execute(APK: Int64): TBankShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uBank,
  uHlp,
  System.SysUtils,
  uApplication.Types,
  uBank.Mapper;

{ TBankShowUseCase }

constructor TBankShowUseCase.Create(ARepository: IBankRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TBankShowUseCase.Execute(APK: Int64): TBankShowDTO;
var
  lBankFound: Shared<TBank>;
begin
  Result := Nil;

  // Localizar Registro
  lBankFound := FRepository.Show(APK);
  if not Assigned(lBankFound.Value) then
    Exit;

  // Retornar DTO
  Result := TBankMapper.EntityToBankShowDto(lBankFound);
end;

class function TBankShowUseCase.Make(ARepository: IBankRepository): IBankShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
