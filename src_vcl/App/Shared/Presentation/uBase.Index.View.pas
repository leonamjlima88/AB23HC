unit uBase.Index.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.StorageBin,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, JvExStdCtrls, JvEdit,
  JvValidateEdit, Vcl.WinXCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids, Vcl.Imaging.pngimage, JvExDBGrids, JvDBGrid, JvExControls, JvGradient,
  Skia, Skia.Vcl;

type
  TBaseIndexView = class(TForm)
    dtsIndex: TDataSource;
    pnlBackground: TPanel;
    pnlContent: TPanel;
    pnlTitle: TPanel;
    lblTitle: TLabel;
    pnlTitleBottomBar: TPanel;
    scbContent: TScrollBox;
    pnlGrid: TPanel;
    pnlGrid2: TPanel;
    pnlButtonsTop: TPanel;
    pnlOptions: TPanel;
    pnlOptions2: TPanel;
    pnlOptions3: TPanel;
    imgOptions: TImage;
    pnlAppend: TPanel;
    pnlAppend2: TPanel;
    btnAppend: TSpeedButton;
    pnlAppend3: TPanel;
    imgAppend: TImage;
    pnlNavigator: TPanel;
    SplitView1: TSplitView;
    pnlSplitView: TPanel;
    pnlSplitView3: TPanel;
    imgSplitView: TImage;
    lblSplitView: TLabel;
    lblSplitView2: TLabel;
    pnlSplitViewApply: TPanel;
    pnlSplitViewApply2: TPanel;
    imgSplitViewApply: TImage;
    pnlSplitViewApply3: TPanel;
    btnSplitViewApply: TSpeedButton;
    pnlSplitViewHide: TPanel;
    pnlSplitViewHide2: TPanel;
    imgSplitViewHide: TImage;
    pnlSplitView2: TPanel;
    scbSplitView: TScrollBox;
    lblNavShowingRecords: TLabel;
    pnlNavFirst3: TPanel;
    pnlNavFirst2: TPanel;
    pnlNavLast3: TPanel;
    pnlNavLast2: TPanel;
    pnlNavPrior4: TPanel;
    pnlNavPrior2: TPanel;
    pnlNavPrior: TPanel;
    btnNavPrior: TSpeedButton;
    pnlNavNext4: TPanel;
    pnlNavNext2: TPanel;
    pnlNavNext: TPanel;
    btnNavNext: TSpeedButton;
    pnlNavCurrentPage2: TPanel;
    pnlNavCurrentPage: TPanel;
    edtNavCurrentPage: TJvValidateEdit;
    btnNavFirst: TSpeedButton;
    btnNavLast: TSpeedButton;
    pnlNavLimitPerPage: TPanel;
    pnlNavLimitPerPage2: TPanel;
    lblNavLimitPerPage: TLabel;
    edtNavLimitPerPage: TJvValidateEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    edtNavLastPageNumber: TEdit;
    pnlFilterClean2: TPanel;
    pnlFilterClean: TPanel;
    imgFilterClean: TImage;
    pnlSearch: TPanel;
    pnlSearch4: TPanel;
    pnlSearch2: TPanel;
    lblSearch: TLabel;
    Panel3: TPanel;
    pnlDbgrid: TPanel;
    DBGrid1: TJvDBGrid;
    pnlFilter: TPanel;
    pnlFilter2: TPanel;
    imgFilter: TImage;
    btnFilter: TSpeedButton;
    pnlSearch3: TPanel;
    Panel4: TPanel;
    imgSearchClear: TImage;
    pnlSearch5: TPanel;
    lblSearchTitle: TLabel;
    edtSearchValue: TEdit;
    pnlImgDoSearch: TPanel;
    lblNoSearch: TLabel;
    imgNoSearch2: TImage;
    imgNoSearch: TSkAnimatedImage;
    imgDoSearch: TImage;
    IndicatorLoadButtonDoSearch: TActivityIndicator;
    imgTitle: TImage;
    SkAnimatedImage1: TSkAnimatedImage;
    procedure FormCreate(Sender: TObject); virtual;
    procedure FormShow(Sender: TObject); virtual;
    procedure btnFilterClick(Sender: TObject); virtual;
    procedure imgSplitViewHideClick(Sender: TObject); virtual;
    procedure imgFilterCleanClick(Sender: TObject); virtual;
    procedure btnSplitViewApplyClick(Sender: TObject); virtual;
    procedure EdtFieldClick(Sender: TObject); virtual;
    procedure EdtFieldEnter(Sender: TObject); virtual;
    procedure EdtFieldExit(Sender: TObject); virtual;
    procedure EdtFieldKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    procedure pnlContentMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    FTransparentBackground: TForm;
    FLoadingSearch: Boolean;
    procedure SetLoadingSearch(const Value: Boolean);
  public
    { Public declarations }
    property LoadingSearch: Boolean read FLoadingSearch write SetLoadingSearch;
  end;

var
  BaseIndexView: TBaseIndexView;

implementation

{$R *.dfm}

uses
  uHlp;

Const
  COLOR_ON_ENTER: TColor = $00F3ECE4;
  COLOR_ON_EXIT: TColor  = clWindow;

procedure TBaseIndexView.btnFilterClick(Sender: TObject);
begin
  SplitView1.Opened := not SplitView1.Opened;
end;

procedure TBaseIndexView.btnSplitViewApplyClick(Sender: TObject);
begin
  SplitView1.Opened := False;
end;

procedure TBaseIndexView.EdtFieldClick(Sender: TObject);
begin
  if (Sender is TEdit) then
    TEdit(Sender).SelectAll;

  if (Sender is TJvValidateEdit) then
    TJvValidateEdit(Sender).SelectAll;
end;

procedure TBaseIndexView.EdtFieldEnter(Sender: TObject);
begin
 if (Sender is TEdit) then
    TEdit(Sender).Color := COLOR_ON_ENTER;

  if (Sender is TComboBox) then
    TComboBox(Sender).Color := COLOR_ON_ENTER;

  if (Sender is TMemo) then
    TMemo(Sender).Color := COLOR_ON_ENTER;

  if (Sender is TJvValidateEdit) then
    TJvValidateEdit(Sender).Color := COLOR_ON_ENTER;
end;

procedure TBaseIndexView.EdtFieldExit(Sender: TObject);
begin
  if (Sender is TEdit) then
    TEdit(Sender).Color := COLOR_ON_EXIT;

  if (Sender is TComboBox) then
    TComboBox(Sender).Color := COLOR_ON_EXIT;

  if (Sender is TMemo) then
    TMemo(Sender).Color := COLOR_ON_EXIT;

  if (Sender is TJvValidateEdit) then
    TJvValidateEdit(Sender).Color := COLOR_ON_EXIT;
end;

procedure TBaseIndexView.EdtFieldKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // Focus no proximo campo
  if (Key = VK_RETURN) then
    Perform(WM_NEXTDLGCTL,0,0);
end;

procedure TBaseIndexView.FormCreate(Sender: TObject);
begin
  IndicatorLoadButtonDoSearch.Animate := False;
  IndicatorLoadButtonDoSearch.Visible := False;
  DBGrid1.SendToBack;
  SplitView1.Width  := 320;
  SplitView1.Opened := False;
end;

procedure TBaseIndexView.FormShow(Sender: TObject);
begin
  DBGrid1.AutoSizeColumnIndex := Pred(DBGrid1.Columns.Count);
  DBGrid1.AutoSizeColumns     := true;
  if edtSearchValue.CanFocus then
    edtSearchValue.SetFocus;
end;

procedure TBaseIndexView.imgFilterCleanClick(Sender: TObject);
begin
  // Limpar componentes de filtro
end;

procedure TBaseIndexView.imgSplitViewHideClick(Sender: TObject);
begin
  SplitView1.Opened := False;
end;

procedure TBaseIndexView.pnlContentMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const
  sc_DragMove = $f012;
begin
  ReleaseCapture;
  Perform(wm_SysCommand, sc_DragMove, 0);
end;

procedure TBaseIndexView.SetLoadingSearch(const Value: Boolean);
begin
  FLoadingSearch := Value;

  case FLoadingSearch of
    True: Begin
      IndicatorLoadButtonDoSearch.Visible := True;
      IndicatorLoadButtonDoSearch.Animate := True;
      imgDoSearch.Visible                 := False;
      imgNoSearch.Enabled                 := True;
      DBGrid1.SendToBack;
      DBGrid1.Visible                     := False;
      Screen.Cursor                       := crHourGlass;
    end;
    False: Begin
      IndicatorLoadButtonDoSearch.Visible := False;
      IndicatorLoadButtonDoSearch.Animate := False;
      imgDoSearch.Visible                 := True;
      DBGrid1.Visible                     := True;
      DBGrid1.BringToFront;
      imgNoSearch.Enabled                 := False;
      Screen.Cursor                       := crDefault;
    End;
  end;
end;

end.
