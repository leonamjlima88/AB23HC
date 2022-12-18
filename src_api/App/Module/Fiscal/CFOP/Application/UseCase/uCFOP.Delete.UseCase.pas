unit uCFOP.Delete.UseCase;

interface

uses
  uCFOP.Repository.Interfaces;

type
  ICFOPDeleteUseCase = Interface
    ['{596944D4-AC7E-4612-8539-C7B4EF1316F5}']
    function Execute(APK: Int64): Boolean;
  end;

  TCFOPDeleteUseCase = class(TInterfacedObject, ICFOPDeleteUseCase)
  private
    FRepository: ICFOPRepository;
    constructor Create(ARepository: ICFOPRepository);
  public
    class function Make(ARepository: ICFOPRepository): ICFOPDeleteUseCase;
    function Execute(APK: Int64): Boolean;
  end;

implementation

{ TCFOPDeleteUseCase }

constructor TCFOPDeleteUseCase.Create(ARepository: ICFOPRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TCFOPDeleteUseCase.Execute(APK: Int64): Boolean;
begin
  // Deletar Registro
  Result := FRepository.Delete(APK);
end;

class function TCFOPDeleteUseCase.Make(ARepository: ICFOPRepository): ICFOPDeleteUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
