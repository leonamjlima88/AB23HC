unit uLogin.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TLoginView = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Panel3: TPanel;
    LbUsuario: TLabel;
    edtLogin: TEdit;
    LbSenha: TLabel;
    edtLoginPassword: TEdit;
    pnlLogin3: TPanel;
    pnlLogin2: TPanel;
    btnLogin: TSpeedButton;
    pnlLogin: TPanel;
    imgLogin: TImage;
    pnlCancel: TPanel;
    pnlCancel2: TPanel;
    btnCancel: TSpeedButton;
    pnlCancel3: TPanel;
    imgCancel4: TImage;
    pnlBackground: TPanel;
    procedure btnLoginClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure edtLoginKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtLoginPasswordKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function ChangeUserLogger: integer;
  end;

var
  LoginView: TLoginView;

implementation

{$R *.dfm}

uses
  RESTRequest4D,
  uAclUser,
  XSuperObject,
  uUserLogged,
  uEnv;

procedure TLoginView.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TLoginView.btnLoginClick(Sender: TObject);
const
  LBODY = '{"login":"%s","login_password":"%s"}';
var
  lResponse: IResponse;
  lAclUser: TAclUser;
begin
  // Efetuar Requisição de login
  lResponse := TRequest.New.BaseURL(ENV.APP_BASE_URI + '/auth/login')
    .AddHeader ('Content-Type', 'application/json')
    .AddHeader ('Accept', 'application/json')
    .Accept    ('application/json')
    .AddBody   (Format(LBODY, [edtLogin.Text, edtLoginPassword.Text]))
    .Post;
  if not (lResponse.StatusCode = 200) then
  begin
    ShowMessage(SO(lResponse.Content).S['message']);
    Abort;
  end;

  // Carregar dados do usuário
  lAclUser := TAclUser.FromJSON(SO(lResponse.Content).O['data']);
  lAclUser.login_password := edtLoginPassword.Text;
  UserLogged.Current(lAclUser);

  ModalResult := mrOK;
end;

class function TLoginView.ChangeUserLogger: integer;
var
  lView: TLoginView;
begin
  lView := TLoginView.Create(nil);
  try
    Result := lView.ShowModal;
  finally
    lView.Hide;
    FreeAndNil(lView);
  end;
end;

procedure TLoginView.edtLoginKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // Focus no proximo campo
  if (Key = VK_RETURN) then
    Perform(WM_NEXTDLGCTL,0,0);
end;

procedure TLoginView.edtLoginPasswordKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    btnLoginClick(btnLogin);
end;

procedure TLoginView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // ESC - Fechar
  if (Key = VK_ESCAPE) then
  begin
    btnCancelClick(btnCancel);
    Exit;
  end;
end;

procedure TLoginView.FormShow(Sender: TObject);
begin
  edtLogin.Text         := 'lead';
  edtLoginPassword.Text := 'lead321';
end;

end.
