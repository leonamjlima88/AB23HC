unit uSize.Delete.UseCase;

interface

uses
  uSize.Repository.Interfaces;

type
  ISizeDeleteUseCase = Interface
['{F9789E8A-4088-4A61-B6F4-0DEF1C94C9A5}']
    function Execute(APK: Int64): Boolean;
  end;

  TSizeDeleteUseCase = class(TInterfacedObject, ISizeDeleteUseCase)
  private
    FRepository: ISizeRepository;
    constructor Create(ARepository: ISizeRepository);
  public
    class function Make(ARepository: ISizeRepository): ISizeDeleteUseCase;
    function Execute(APK: Int64): Boolean;
  end;

implementation

{ TSizeDeleteUseCase }

constructor TSizeDeleteUseCase.Create(ARepository: ISizeRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TSizeDeleteUseCase.Execute(APK: Int64): Boolean;
begin
  // Deletar Registro
  Result := FRepository.Delete(APK);
end;

class function TSizeDeleteUseCase.Make(ARepository: ISizeRepository): ISizeDeleteUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
