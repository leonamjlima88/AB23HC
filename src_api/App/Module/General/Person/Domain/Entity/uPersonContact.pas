unit uPersonContact;

interface

uses
  uBase.Entity,
  uLegalEntityNumber.VO;

type
  TPersonContact = class(TBaseEntity)
  private
    Fid: Int64;
    Fperson_id: Int64;
    Fname: string;
    Femail: string;
    Fphone: string;
    Fnote: string;
    Flegal_entity_number: ILegalEntityNumberVO;
    Ftype: string;
    procedure Initialize;
  public
    constructor Create; overload;
    destructor Destroy; override;

    property id: Int64 read Fid write Fid;
    property person_id: Int64 read Fperson_id write Fperson_id;
    property name: string read Fname write Fname;
    property legal_entity_number: ILegalEntityNumberVO read Flegal_entity_number write Flegal_entity_number;
    property &type: string read Ftype write Ftype;
    property note: string read Fnote write Fnote;
    property phone: string read Fphone write Fphone;
    property email: string read Femail write Femail;

    procedure Validate; override;
  end;

implementation

uses
  System.SysUtils,
  uHlp,
  uApplication.Types;

{ TPersonContact }

constructor TPersonContact.Create;
begin
  inherited Create;
  Initialize;
end;

destructor TPersonContact.Destroy;
begin
  inherited;
end;

procedure TPersonContact.Initialize;
begin
  Flegal_entity_number := TLegalEntityNumberVO.Make(EmptyStr);
end;

procedure TPersonContact.Validate;
begin
//
end;

end.
