unit uBase.CreateUpdate.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Buttons, Vcl.Imaging.pngimage, Vcl.WinXCtrls, Skia, Skia.Vcl;

type
  TBaseCreateUpdateView = class(TForm)
    pnlBackground: TPanel;
    pnlBackground2: TPanel;
    pnlBottomButtons: TPanel;
    pnlSave: TPanel;
    pnlSave2: TPanel;
    btnSave: TSpeedButton;
    pnlSave3: TPanel;
    imgSave: TImage;
    pnlCancel: TPanel;
    pnlCancel2: TPanel;
    btnCancel: TSpeedButton;
    pnlCancel3: TPanel;
    imgCancel4: TImage;
    pgc: TPageControl;
    tabMain: TTabSheet;
    pnlMain: TPanel;
    btnFocus: TButton;
    pnlTitle: TPanel;
    imgTitle: TImage;
    lblTitle: TLabel;
    imgCloseTitle: TImage;
    imgMinimizeTitle: TImage;
    IndicatorLoadButtonSave: TActivityIndicator;
    IndicatorLoadFormLabel: TLabel;
    imgNoSearch: TSkAnimatedImage;
    IndicatorLoadForm: TSkAnimatedImage;
    procedure imgMinimizeTitleClick(Sender: TObject); virtual;
    procedure FormCreate(Sender: TObject); virtual;
    procedure EdtFieldEnter(Sender: TObject); virtual;
    procedure EdtFieldExit(Sender: TObject); virtual;
    procedure EdtFieldKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    procedure EdtFieldKeyPress(Sender: TObject; var Key: Char); virtual;
    procedure EdtFieldClick(Sender: TObject); virtual;
    procedure ToggleSwitch1Click(Sender: TObject); virtual;
    procedure ImageShowHintClick(Sender: TObject); virtual;
    procedure pnlTitleMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    FLoadingSave: Boolean;
    FLoadingForm: Boolean;
    procedure SetLoadingForm(const Value: Boolean);
    procedure SetLoadingSave(const Value: Boolean);
  public
    property LoadingSave: Boolean read FLoadingSave write SetLoadingSave;
    property LoadingForm: Boolean read FLoadingForm write SetLoadingForm;
  end;

implementation

{$R *.dfm}

uses
  uHlp,
  Vcl.DBCtrls,
  uNotificationView,
  JvValidateEdit,
  uApplication.Types;

Const
  COLOR_ON_ENTER: TColor = $00F3ECE4;
  COLOR_ON_EXIT: TColor  = clWindow;


{ TBaseCreateUpdateView }

procedure TBaseCreateUpdateView.EdtFieldClick(Sender: TObject);
begin
  if (Sender is TEdit) then
    TEdit(Sender).SelectAll;

  if (Sender is TDBEdit) then
    TDBEdit(Sender).SelectAll;

  if (Sender is TJvValidateEdit) then
    TJvValidateEdit(Sender).SelectAll;
end;

procedure TBaseCreateUpdateView.EdtFieldEnter(Sender: TObject);
begin
 if (Sender is TEdit) then
    TEdit(Sender).Color := COLOR_ON_ENTER;

 if (Sender is TDBEdit) then
    TDBEdit(Sender).Color := COLOR_ON_ENTER;

  if (Sender is TComboBox) then
    TComboBox(Sender).Color := COLOR_ON_ENTER;

  if (Sender is TDBComboBox) then
    TDBComboBox(Sender).Color := COLOR_ON_ENTER;

  if (Sender is TMemo) then
    TMemo(Sender).Color := COLOR_ON_ENTER;

  if (Sender is TDBMemo) then
    TDBMemo(Sender).Color := COLOR_ON_ENTER;

  if (Sender is TJvValidateEdit) then
    TJvValidateEdit(Sender).Color := COLOR_ON_ENTER;
end;

procedure TBaseCreateUpdateView.EdtFieldExit(Sender: TObject);
begin
  if (Sender is TEdit) then
    TEdit(Sender).Color := COLOR_ON_EXIT;

  if (Sender is TDBEdit) then
    TDBEdit(Sender).Color := COLOR_ON_EXIT;

  if (Sender is TComboBox) then
    TComboBox(Sender).Color := COLOR_ON_EXIT;

  if (Sender is TDBComboBox) then
    TDBComboBox(Sender).Color := COLOR_ON_EXIT;

  if (Sender is TMemo) then
    TMemo(Sender).Color := COLOR_ON_EXIT;

  if (Sender is TDBMemo) then
    TDBMemo(Sender).Color := COLOR_ON_EXIT;

  if (Sender is TJvValidateEdit) then
    TJvValidateEdit(Sender).Color := COLOR_ON_EXIT;
end;

procedure TBaseCreateUpdateView.EdtFieldKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // Focus no proximo campo
  if (Key = VK_RETURN) then
    Perform(WM_NEXTDLGCTL,0,0);
end;

procedure TBaseCreateUpdateView.EdtFieldKeyPress(Sender: TObject; var Key: Char);
begin
//
end;

procedure TBaseCreateUpdateView.FormCreate(Sender: TObject);
begin
  pgc.ActivePageIndex := 0;
  IndicatorLoadButtonSave.Animate := False;
  IndicatorLoadButtonSave.Visible := False;
  THlp.createTransparentBackground(Self);
end;

procedure TBaseCreateUpdateView.ImageShowHintClick(Sender: TObject);
begin
  MessageDlg(TImage(Sender).Hint, mtInformation, [mbOK], 0);
end;

procedure TBaseCreateUpdateView.imgMinimizeTitleClick(Sender: TObject);
begin
  Application.Minimize;
  NotificationView.Execute(YOUR_APP_HAS_BEEN_MINIMIZED, tneInfo);
end;

procedure TBaseCreateUpdateView.pnlTitleMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const
  sc_DragMove = $f012;
begin
  ReleaseCapture;
  Perform(wm_SysCommand, sc_DragMove, 0);
end;

procedure TBaseCreateUpdateView.SetLoadingForm(const Value: Boolean);
var
  lLeft,
  lTop: Integer;
begin
  FLoadingForm := Value;

  case FLoadingForm of
    True: Begin
      // Ativar Loading
      IndicatorLoadForm.Visible           := True;
      IndicatorLoadForm.Animation.Enabled := True;
      IndicatorLoadFormLabel.Visible      := True;
      imgNoSearch.Animation.Enabled       := True;
      imgNoSearch.Visible                 := True;
      Screen.Cursor                       := crHourGlass;
    end;
    False: Begin
      IndicatorLoadForm.Visible           := False;
      IndicatorLoadForm.Animation.Enabled := False;
      IndicatorLoadFormLabel.Visible      := False;
      imgNoSearch.Visible                 := False;
      imgNoSearch.Animation.Enabled       := False;
      Screen.Cursor                       := crDefault;
    end;
  end;
end;

procedure TBaseCreateUpdateView.SetLoadingSave(const Value: Boolean);
begin
  FLoadingSave := Value;

  case FLoadingSave of
    True: Begin
      IndicatorLoadButtonSave.Visible := True;
      IndicatorLoadButtonSave.Animate := True;
      imgSave.Visible                 := False;
      Screen.Cursor                   := crHourGlass;
    end;
    False: Begin
      IndicatorLoadButtonSave.Visible := False;
      IndicatorLoadButtonSave.Animate := False;
      imgSave.Visible                 := True;
      Screen.Cursor                   := crDefault;
    End;
  end;
end;

procedure TBaseCreateUpdateView.ToggleSwitch1Click(Sender: TObject);
begin
  case TToggleSwitch(Sender).IsOn of
    True: Begin
      TToggleSwitch(Sender).FrameColor := clGreen;
      TToggleSwitch(Sender).ThumbColor := clGreen;
    End;
    False: Begin
      TToggleSwitch(Sender).FrameColor := clGray;
      TToggleSwitch(Sender).ThumbColor := clGray;
    End;
  end;
end;

end.
