unit uAppParam;

interface

uses
  uApplication.Types,
  uAclUser,
  uBase.Entity,
  Data.DB;

type
  TAppParam = class(TBaseEntity)
  private
    Fid: Int64;
    Facl_role_id: Int64;
    Fgroup_name: String;
    Ftitle: String;
    Fvalue: String;
    Ftenant_id: Int64;

    procedure Initialize;
  public
    constructor Create; overload;
    destructor Destroy; override;

    property id: Int64 read Fid write Fid;
    property tenant_id: Int64 read Ftenant_id write Ftenant_id;
    property acl_role_id: Int64 read Facl_role_id write Facl_role_id;
    property group_name: String read Fgroup_name write Fgroup_name;
    property title: String read Ftitle write Ftitle;
    property value: String read Fvalue write Fvalue;

    procedure Validate; override;
  end;

implementation

uses
  System.SysUtils;

{ TAppParam }

constructor TAppParam.Create;
begin
  inherited Create;
  Initialize;
end;

destructor TAppParam.Destroy;
begin
  inherited;
end;

procedure TAppParam.Initialize;
begin
//
end;

procedure TAppParam.Validate;
begin
  if (Ftenant_id <= 0) then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['tenant_id']));

  if (Fgroup_name.Trim.IsEmpty) then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['group_name']));

  if (Ftitle.Trim.IsEmpty) then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['title']));
end;

end.
