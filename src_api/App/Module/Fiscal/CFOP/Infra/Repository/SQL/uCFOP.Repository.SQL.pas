unit uCFOP.Repository.SQL;

interface

uses
  uBase.Repository,
  uCFOP.Repository.Interfaces,
  uCFOP.SQLBuilder.Interfaces,
  uZLConnection.Interfaces,
  Data.DB,
  uBase.Entity,
  uPageFilter,
  uSelectWithFilter,
  uCFOP;

type
  TCFOPRepositorySQL = class(TBaseRepository, ICFOPRepository)
  private
    FCFOPSQLBuilder: ICFOPSQLBuilder;
    constructor Create(AConn: IZLConnection; ASQLBuilder: ICFOPSQLBuilder);
    function DataSetToEntity(ADtsCFOP: TDataSet): TBaseEntity; override;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter; override;
    function FieldExists(AColumName, AColumnValue: String; AId: Int64): Boolean;
    procedure Validate(AEntity: TBaseEntity); override;
  public
    class function Make(AConn: IZLConnection; ASQLBuilder: ICFOPSQLBuilder): ICFOPRepository;
    function Show(AId: Int64): TCFOP;
 end;

implementation

uses
  XSuperObject,
  DataSet.Serialize,
  System.SysUtils,
  uApplication.Types;

{ TCFOPRepositorySQL }

class function TCFOPRepositorySQL.Make(AConn: IZLConnection; ASQLBuilder: ICFOPSQLBuilder): ICFOPRepository;
begin
  Result := Self.Create(AConn, ASQLBuilder);
end;

constructor TCFOPRepositorySQL.Create(AConn: IZLConnection; ASQLBuilder: ICFOPSQLBuilder);
begin
  inherited Create;
  FConn            := AConn;
  FSQLBuilder      := ASQLBuilder;
  FCFOPSQLBuilder  := ASQLBuilder;
end;

function TCFOPRepositorySQL.DataSetToEntity(ADtsCFOP: TDataSet): TBaseEntity;
var
  lCFOP: TCFOP;
begin
  lCFOP := TCFOP.FromJSON(ADtsCFOP.ToJSONObjectString);

  // CFOP - Virtuais
  lCFOP.created_by_acl_user.id   := ADtsCFOP.FieldByName('created_by_acl_user_id').AsLargeInt;
  lCFOP.created_by_acl_user.name := ADtsCFOP.FieldByName('created_by_acl_user_name').AsString;
  lCFOP.updated_by_acl_user.id   := ADtsCFOP.FieldByName('updated_by_acl_user_id').AsLargeInt;
  lCFOP.updated_by_acl_user.name := ADtsCFOP.FieldByName('updated_by_acl_user_name').AsString;

  Result := lCFOP;
end;

function TCFOPRepositorySQL.FieldExists(AColumName, AColumnValue: String; AId: Int64): Boolean;
begin
  Result := not FConn.MakeQry.Open(
    FCFOPSQLBuilder.RegisteredFields(AColumName, AColumnValue, AId)
  ).DataSet.IsEmpty;
end;

function TCFOPRepositorySQL.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  Result := FCFOPSQLBuilder.SelectAllWithFilter(APageFilter);
end;

function TCFOPRepositorySQL.Show(AId: Int64): TCFOP;
begin
  Result := ShowById(AId) as TCFOP;
end;

procedure TCFOPRepositorySQL.Validate(AEntity: TBaseEntity);
var
  lCFOP: TCFOP;
begin
  lCFOP := AEntity as TCFOP;

  // Verificar se code já existe
  if not lCFOP.code.Trim.IsEmpty then
  begin
    if FieldExists('cfop.code', lCFOP.code, lCFOP.id) then
      raise Exception.Create(Format(FIELD_WITH_VALUE_IS_IN_USE, ['cfop.code', lCFOP.code]));
  end;
end;

end.


