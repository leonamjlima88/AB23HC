unit uAclRole;

interface

uses
  uApplication.Types,
  uBase.Entity;

type
  TAclRole = class(TBaseEntity)
  private
    Fid: Int64;
    Fname: string;
    Ftenant_id: Int64;
  public
    constructor Create; overload;
    destructor Destroy; override;

    property id: Int64 read Fid write Fid;
    property name: string read Fname write Fname;
    property tenant_id: Int64 read Ftenant_id write Ftenant_id;

    procedure Validate; override;
  end;

implementation

uses
  System.SysUtils;

{ TAclRole }

constructor TAclRole.Create;
begin
  inherited Create;
end;

destructor TAclRole.Destroy;
begin
  inherited;
end;

procedure TAclRole.Validate;
begin
  if Fname.Trim.IsEmpty then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['name']));

  if (Ftenant_id <= 0) then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['tenant_id']));
end;

end.
