unit uYesOrNo.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.Buttons, Skia, Skia.Vcl;

type
  TYesOrNoView = class(TForm)
    pnlBackground: TPanel;
    pnl02Message: TPanel;
    memMsg: TMemo;
    pnl03Botoes: TPanel;
    pnlNo: TPanel;
    btnNo: TSpeedButton;
    pnlYes: TPanel;
    btnYes: TSpeedButton;
    imgYes: TImage;
    pnl01Titulo: TPanel;
    imgFechar: TImage;
    imgMinimizar: TImage;
    imgRestaurar: TImage;
    Panel1: TPanel;
    lblTitulo: TLabel;
    SkAnimatedImage1: TSkAnimatedImage;
    procedure btnNoClick(Sender: TObject);
    procedure btnYesClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function Handle(AMessage: String; ATitle: String = ''): Integer;
  end;

var
  YesOrNoView: TYesOrNoView;

implementation

uses
  uHlp;

{$R *.dfm}

class function TYesOrNoView.Handle(AMessage, ATitle: String): Integer;
Var
  lView: TYesOrNoView;
begin
  lView := TYesOrNoView.Create(nil);
  Try
    if not ATitle.Trim.IsEmpty then lView.lblTitulo.Caption := ATitle;
    lView.memMsg.Lines.Text := AMessage;

    Result := lView.ShowModal;
  Finally
    lView.Hide;
    FreeAndNil(lView);
  End;
end;

procedure TYesOrNoView.btnNoClick(Sender: TObject);
begin
  ModalResult := MrCancel;
end;

procedure TYesOrNoView.btnYesClick(Sender: TObject);
begin
  ModalResult := MrOK;
end;

procedure TYesOrNoView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // Esc - Botão NÃO
  if (Key = VK_ESCAPE) then
  Begin
    btnNoClick(btnNo);
    Exit;
  End;

  // Enter - Botão SIM
  if (Key = VK_RETURN) then
  Begin
    btnYesClick(btnYes);
    Exit;
  End;
end;

procedure TYesOrNoView.FormShow(Sender: TObject);
begin
  THlp.createTransparentBackground(Self);
end;

end.
