unit uBrand;

interface

uses
  uBase.Entity;

type
  TBrand = class(TBaseEntity)
  private
    Fid: Int64;
    Fname: string;
    Fupdated_at: TDateTime;
    Fcreated_at: TDateTime;
    Fupdated_by_acl_user_id: Int64;
    Fcreated_by_acl_user_id: Int64;
  public
    property id: Int64 read Fid write Fid;
    property name: string read Fname write Fname;
    property created_at: TDateTime read Fcreated_at write Fcreated_at;
    property updated_at: TDateTime read Fupdated_at write Fupdated_at;
    property created_by_acl_user_id: Int64 read Fcreated_by_acl_user_id write Fcreated_by_acl_user_id;
    property updated_by_acl_user_id: Int64 read Fupdated_by_acl_user_id write Fupdated_by_acl_user_id;

    function Validate: String; override;
  end;

implementation

uses
  System.SysUtils;

{ TBrand }

function TBrand.Validate: String;
var
  lIsInserting: Boolean;
  lErrors: String;
begin
  lIsInserting := id = 0;

  if Fname.Trim.IsEmpty then
    lErrors := lErrors + 'O campo [Nome] é obrigatório' + #13;

  Result := lErrors;
end;

end.
