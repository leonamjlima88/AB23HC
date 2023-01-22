unit uBusinessProposal.Show.UseCase;

interface

uses
  uBusinessProposal.Repository.Interfaces,
  uBusinessProposal.Show.DTO;

type
  IBusinessProposalShowUseCase = Interface
    ['{88B3E730-8904-45A4-9BE1-2CF650E54C3F}']
    function Execute(APK, ATenantId: Int64): TBusinessProposalShowDTO;
  end;

  TBusinessProposalShowUseCase = class(TInterfacedObject, IBusinessProposalShowUseCase)
  private
    FRepository: IBusinessProposalRepository;
    constructor Create(ARepository: IBusinessProposalRepository);
  public
    class function Make(ARepository: IBusinessProposalRepository): IBusinessProposalShowUseCase;
    function Execute(APK, ATenantId: Int64): TBusinessProposalShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uBusinessProposal,
  uHlp,
  XSuperObject,
  System.SysUtils,
  uApplication.Types,
  uBusinessProposal.Mapper;

{ TBusinessProposalShowUseCase }

constructor TBusinessProposalShowUseCase.Create(ARepository: IBusinessProposalRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TBusinessProposalShowUseCase.Execute(APK, ATenantId: Int64): TBusinessProposalShowDTO;
var
  lBusinessProposalFound: Shared<TBusinessProposal>;
begin
  Result := Nil;

  // Localizar Registro
  lBusinessProposalFound := FRepository.Show(APK, ATenantId);
  if not Assigned(lBusinessProposalFound.Value) then
    Exit;

  // Retornar DTO
  Result := TBusinessProposalMapper.EntityToBusinessProposalShowDto(lBusinessProposalFound.Value);
end;

class function TBusinessProposalShowUseCase.Make(ARepository: IBusinessProposalRepository): IBusinessProposalShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
