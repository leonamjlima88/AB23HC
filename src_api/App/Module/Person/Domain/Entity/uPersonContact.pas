unit uPersonContact;

interface

uses
  uBase.Entity;

type
  TPersonContact = class(TBaseEntity)
  private
    Fid: Int64;
    Fperson_id: Int64;
    Fname: string;
    Femail: string;
    Fphone: string;
    Fnote: string;
    Fein: string;
    Ftype: string;
    procedure Initialize;
    function Getein: string;
  public
    constructor Create; overload;
    destructor Destroy; override;

    property id: Int64 read Fid write Fid;
    property person_id: Int64 read Fperson_id write Fperson_id;
    property name: string read Fname write Fname;
    property ein: string read Getein write Fein;
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

function TPersonContact.Getein: string;
begin
  Result := THlp.OnlyNumbers(Fein);
end;

procedure TPersonContact.Initialize;
begin
  //
end;

procedure TPersonContact.Validate;
begin
  // Validar CPF/CNPJ se preenchido
  if not Fein.Trim.IsEmpty then
  begin
    if not THlp.CpfOrCnpjIsValid(Fein) then
      raise Exception.Create(Format(FIELD_WITH_VALUE_IS_INVALID, ['person_contact.ein', Fein]));
  end;
end;

end.
