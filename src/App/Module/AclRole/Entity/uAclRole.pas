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
  public
    constructor Create;
    destructor Destroy; override;

    property id: Int64 read Fid write Fid;
    property name: string read Fname write Fname;
  end;

implementation

{ TAclRole }

constructor TAclRole.Create;
begin
end;

destructor TAclRole.Destroy;
begin
  inherited;
end;

end.
