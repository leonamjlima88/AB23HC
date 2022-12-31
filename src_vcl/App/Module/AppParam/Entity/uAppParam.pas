unit uAppParam;

interface

uses
  uBase.Entity;

type
  TAppParam = class(TBaseEntity)
  private
    Ftitle: String;
    Fgroup_name: String;
    Fvalue: String;
    Ftenant_id: Int64;
    Facl_role_id: Int64;
    function Gettitle: String;
  public
    constructor Create; overload;
    destructor Destroy; override;

    property tenant_id: Int64 read Ftenant_id write Ftenant_id;
    property acl_role_id: Int64 read Facl_role_id write Facl_role_id;
    property group_name: String read Fgroup_name write Fgroup_name;
    property title: String read Gettitle write Ftitle;
    property value: String read Fvalue write Fvalue;
  end;

implementation

uses
  System.SysUtils;

{ TAppParam }

constructor TAppParam.Create;
begin
  inherited Create;
end;

destructor TAppParam.Destroy;
begin
  inherited;
end;

function TAppParam.Gettitle: String;
begin
  Result := Ftitle.Trim.toLower;
end;

end.
