unit uNotificationView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.Buttons, Skia, Skia.Vcl;

type
  TTypeNotificationEnum = (tneSuccess, tneError, tneInfo, tneWarning);
  TNotificationView = class(TForm)
    pnlBorder: TPanel;
    pnlBackground: TPanel;
    memMsg: TMemo;
    Timer1: TTimer;
    btnFocus: TButton;
    pnlBorder2: TPanel;
    SkAnimatedImage1: TSkAnimatedImage;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
  public
    procedure Execute(const AMsg: String; ATypeNotification: TTypeNotificationEnum = tneSuccess);
  end;

var
  NotificationView: TNotificationView;

const
  SUCCESS_DARK_COLOR = $00437C10;
  SUCCESS_BRIGHT_COLOR = $00DEF8C7;

  ERROR_DARK_COLOR = $002C1A60;
  ERROR_BRIGHT_COLOR = $00EFEBFA;

  INFO_DARK_COLOR = $0034301F;
  INFO_BRIGHT_COLOR = $00DEDAC9;

  WARNING_DARK_COLOR = $0010797C;
  WARNING_BRIGHT_COLOR = $00D8F9FA;

implementation

{$R *.dfm}

procedure TNotificationView.Execute(const AMsg: String; ATypeNotification: TTypeNotificationEnum);
begin
  SkAnimatedImage1.Animation.Enabled := False;
  SkAnimatedImage1.Animation.Enabled := True;
  case ATypeNotification of
    tneSuccess: Begin
      pnlBorder.Color     := SUCCESS_DARK_COLOR;
      pnlBorder2.Color    := SUCCESS_DARK_COLOR;
    End;
    tneError: Begin
      pnlBorder.Color     := ERROR_DARK_COLOR;
      pnlBorder2.Color    := ERROR_DARK_COLOR;
    End;
    tneInfo: Begin
      pnlBorder.Color     := INFO_DARK_COLOR;
      pnlBorder2.Color    := INFO_DARK_COLOR;
    End;
    tneWarning: Begin
      pnlBorder.Color     := WARNING_DARK_COLOR;
      pnlBorder2.Color    := WARNING_DARK_COLOR;
    End;
  end;

  memMsg.Lines.Text := AMsg;

  Timer1.Enabled := False;
  Timer1.Enabled := True;
  Self.Show;
end;

procedure TNotificationView.FormCreate(Sender: TObject);
Var
  CxScreen, CyScreen, CxFullScreen,
  CyFullScreen, CyCaption: Integer;
begin
  Self.BorderStyle := bsNone;

  CxScreen     := GetSystemMetrics(SM_CXSCREEN);
  CyScreen     := GetSystemMetrics(SM_CYSCREEN);
  CxFullScreen := GetSystemMetrics(SM_CXFULLSCREEN);
  CyFullScreen := GetSystemMetrics(SM_CYFULLSCREEN);
  CyCaption    := GetSystemMetrics(SM_CYCAPTION);

  Self.Top  := (CyScreen-(CyScreen-CyFullScreen)+CyCaption+1)-Self.Height-10;
  Self.Left := Trunc(((CxScreen-(CxScreen-CxFullScreen))/2)-(Self.Width/2));
end;

procedure TNotificationView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) or (Key = VK_RETURN) then
    Self.Hide;
end;

procedure TNotificationView.SpeedButton1Click(Sender: TObject);
begin
  Self.Hide;
end;

procedure TNotificationView.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  Close;
end;

initialization
  NotificationView := TNotificationView.Create(Application);

end.
