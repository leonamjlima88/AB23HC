unit uEnv;

interface

uses
  SysUtils,
  IniFiles,
  uZLConnection.Types;

type
  TEnv = class(TIniFile)
  private
    procedure SetAPP_BASE_URI(const Value: String);
    function GetAPP_BASE_URI: String;
    function GetAPP_LIBTYPE: TZLConnLibType;
    procedure SetAPP_LIBTYPE(const Value: TZLConnLibType);
  public
    property APP_BASE_URI: String read GetAPP_BASE_URI write SetAPP_BASE_URI;
    property APP_LIBTYPE: TZLConnLibType read GetAPP_LIBTYPE write SetAPP_LIBTYPE;
  end;

var
  ENV: TEnv;

implementation

uses
  Vcl.Forms;

{ TEnv }

function TEnv.GetAPP_BASE_URI: String;
begin
  Result := ReadString('APP', 'BASE_URI', EmptyStr);
end;

function TEnv.GetAPP_LIBTYPE: TZLConnLibType;
var
  lLibType: String;
begin
  lLibType := ReadString('APP','LIBTYPE','FIREDAC').Trim.ToUpper;
  if (lLibType = 'FIREDAC') then
    Result := TZLConnLibType.ctFireDAC;
end;

procedure TEnv.SetAPP_BASE_URI(const Value: String);
begin
  WriteString('APP', 'BASE_URI', Value);
end;

procedure TEnv.SetAPP_LIBTYPE(const Value: TZLConnLibType);
begin
//
end;

initialization
  ENV := TEnv.Create(ExtractFilePath(Application.ExeName) + 'env.ini');
finalization
  FreeAndNil(ENV);

end.

