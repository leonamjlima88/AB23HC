unit uNCM.Repository.SQL;

interface

uses
  uBase.Repository,
  uNCM.Repository.Interfaces,
  uNCM.SQLBuilder.Interfaces,
  uZLConnection.Interfaces,
  Data.DB,
  uBase.Entity,
  uPageFilter,
  uSelectWithFilter,
  uNCM;

type
  TNCMRepositorySQL = class(TBaseRepository, INCMRepository)
  private
    FNCMSQLBuilder: INCMSQLBuilder;
    constructor Create(AConn: IZLConnection; ASQLBuilder: INCMSQLBuilder);
    function DataSetToEntity(ADtsNCM: TDataSet): TBaseEntity; override;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter; override;
    function FieldExists(AColumName, AColumnValue: String; AId: Int64): Boolean;
    procedure Validate(AEntity: TBaseEntity); override;
  public
    class function Make(AConn: IZLConnection; ASQLBuilder: INCMSQLBuilder): INCMRepository;
    function Show(AId: Int64): TNCM;
 end;

implementation

uses
  XSuperObject,
  DataSet.Serialize,
  System.SysUtils,
  uApplication.Types;

{ TNCMRepositorySQL }

class function TNCMRepositorySQL.Make(AConn: IZLConnection; ASQLBuilder: INCMSQLBuilder): INCMRepository;
begin
  Result := Self.Create(AConn, ASQLBuilder);
end;

constructor TNCMRepositorySQL.Create(AConn: IZLConnection; ASQLBuilder: INCMSQLBuilder);
begin
  inherited Create;
  FConn            := AConn;
  FSQLBuilder      := ASQLBuilder;
  FNCMSQLBuilder := ASQLBuilder;
end;

function TNCMRepositorySQL.DataSetToEntity(ADtsNCM: TDataSet): TBaseEntity;
var
  lNCM: TNCM;
begin
  lNCM := TNCM.FromJSON(ADtsNCM.ToJSONObjectString);

  // NCM - Virtuais
  lNCM.created_by_acl_user.id   := ADtsNCM.FieldByName('created_by_acl_user_id').AsLargeInt;
  lNCM.created_by_acl_user.name := ADtsNCM.FieldByName('created_by_acl_user_name').AsString;
  lNCM.updated_by_acl_user.id   := ADtsNCM.FieldByName('updated_by_acl_user_id').AsLargeInt;
  lNCM.updated_by_acl_user.name := ADtsNCM.FieldByName('updated_by_acl_user_name').AsString;

  Result := lNCM;
end;

function TNCMRepositorySQL.FieldExists(AColumName, AColumnValue: String; AId: Int64): Boolean;
begin
  Result := not FConn.MakeQry.Open(
    FNCMSQLBuilder.RegisteredFields(AColumName, AColumnValue, AId)
  ).DataSet.IsEmpty;
end;

function TNCMRepositorySQL.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  Result := FNCMSQLBuilder.SelectAllWithFilter(APageFilter);
end;

function TNCMRepositorySQL.Show(AId: Int64): TNCM;
begin
  Result := ShowById(AId) as TNCM;
end;

procedure TNCMRepositorySQL.Validate(AEntity: TBaseEntity);
var
  lNCM: TNCM;
begin
  lNCM := AEntity as TNCM;

  // Verificar se ncm já existe
  if not lNCM.ncm.Trim.IsEmpty then
  begin
    if FieldExists('ncm.ncm', lNCM.ncm, lNCM.id) then
      raise Exception.Create(Format(FIELD_WITH_VALUE_IS_IN_USE, ['NCM', lNCM.ncm]));
  end;
end;

end.


