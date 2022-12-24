unit uAclRole;

interface

uses
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

end.
