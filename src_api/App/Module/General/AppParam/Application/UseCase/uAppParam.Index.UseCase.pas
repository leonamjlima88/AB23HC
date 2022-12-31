unit uAppParam.Index.UseCase;

interface

uses
  uAppParam.Repository.Interfaces,
  uPageFilter,
  uIndexResult;

type
  IAppParamIndexUseCase = Interface
    ['{C7AD1E01-0E71-491E-AFBD-9E9904E77DBE}']
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

  TAppParamIndexUseCase = class(TInterfacedObject, IAppParamIndexUseCase)
  private
    FRepository: IAppParamRepository;
    constructor Create(ARepository: IAppParamRepository);
  public
    class function Make(ARepository: IAppParamRepository): IAppParamIndexUseCase;
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

implementation

{ TAppParamIndexUseCase }

constructor TAppParamIndexUseCase.Create(ARepository: IAppParamRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TAppParamIndexUseCase.Execute(APageFilter: IPageFilter): IIndexResult;
begin
  Result := FRepository.Index(APageFilter);
end;

class function TAppParamIndexUseCase.Make(ARepository: IAppParamRepository): IAppParamIndexUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
