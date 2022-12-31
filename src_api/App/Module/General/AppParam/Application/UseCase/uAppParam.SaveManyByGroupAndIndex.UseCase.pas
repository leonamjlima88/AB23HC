unit uAppParam.SaveManyByGroupAndIndex.UseCase;

interface

uses
  uAppParam.Repository.Interfaces,
  uAppParamMany.DTO,
  uIndexResult;

type
  IAppParamSaveManyByGroupAndIndexUseCase = Interface
    ['{642DA945-163F-46A7-87C5-F8351098D71D}']
    function Execute(AInput: TAppParamManyDTO): IIndexResult;
  end;

  TAppParamSaveManyByGroupAndIndexUseCase = class(TInterfacedObject, IAppParamSaveManyByGroupAndIndexUseCase)
  private
    FRepository: IAppParamRepository;
    constructor Create(ARepository: IAppParamRepository);
  public
    class function Make(ARepository: IAppParamRepository): IAppParamSaveManyByGroupAndIndexUseCase;
    function Execute(AInput: TAppParamManyDTO): IIndexResult;
  end;

implementation

uses
  uSmartPointer,
  uAppParam,
  XSuperObject,
  System.Generics.Collections,
  uAppParam.DTO,
  uPageFilter,
  System.Classes,
  System.SysUtils;

{ TAppParamSaveManyByGroupAndIndexUseCase }

constructor TAppParamSaveManyByGroupAndIndexUseCase.Create(ARepository: IAppParamRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TAppParamSaveManyByGroupAndIndexUseCase.Execute(AInput: TAppParamManyDTO): IIndexResult;
var
  lAppParamList: Shared<TObjectList<TAppParam>>;
  lAppParam: TAppParam;
  lI: Integer;
begin
  // Carregar dados em Entity
  lAppParamList := TObjectList<TAppParam>.Create;
  for lI := 0 to Pred(AInput.app_param_list.Count) do
  begin
    lAppParam             := TAppParam.FromJSON(AInput.app_param_list.Items[lI].AsJSON);
    lAppParam.tenant_id   := AInput.tenant_id;
    lAppParam.group_name  := AInput.group_name;
    lAppParamList.Value.Add(lAppParam);
  end;

  Try
    FRepository.Conn.StartTransaction;

    // Apagar registros antes de inserir
    FRepository.DeleteManyByGroup(AInput.group_name, AInput.tenant_id);

    // Inserir registros
    for lI := 0 to Pred(lAppParamList.Value.Count) do
      FRepository.Store(lAppParamList.Value.Items[lI]);

    FRepository.Conn.CommitTransaction;
  Except
    FRepository.Conn.RollBackTransaction;
    raise;
  end;

  // Retornar registros que foram salvos
  Result := FRepository.Index(TPageFilter.Make
    .AddWhere('app_param.tenant_id',  TcondOperator.coEqual, AInput.tenant_id.ToString)
    .AddWhere('app_param.group_name', TcondOperator.coEqual, AInput.group_name)
  );
end;

class function TAppParamSaveManyByGroupAndIndexUseCase.Make(ARepository: IAppParamRepository): IAppParamSaveManyByGroupAndIndexUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
