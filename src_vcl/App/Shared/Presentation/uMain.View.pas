unit uMain.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus,
  Vcl.Imaging.jpeg, Vcl.ComCtrls, JvExControls, JvXPCore, JvXPBar,
  Vcl.WinXCtrls, Vcl.Imaging.pngimage, System.Actions, Vcl.ActnList,

  uSmartPointer,
  uBrand.Index.View;

type
  TMainView = class(TForm)
    ActionList1: TActionList;
    actClose: TAction;
    actPerson: TAction;
    actCity: TAction;
    actBrand: TAction;
    actCategory: TAction;
    actSize: TAction;
    actStorageLocation: TAction;
    actUnid: TAction;
    actProduct: TAction;
    actBank: TAction;
    actCostCenter: TAction;
    actBankAccount: TAction;
    actChartOfAccount: TAction;
    actDocument: TAction;
    actPaymentTerm: TAction;
    actBillPayReceive: TAction;
    actNCM: TAction;
    actBusinessProposal: TAction;
    actSale: TAction;
    actMyCompany: TAction;
    actPosPrinter: TAction;
    actAppParamConfig: TAction;
    actAppParamConfigSat: TAction;
    actOperationType: TAction;
    actCFOP: TAction;
    actTaxRule: TAction;
    btnFocus: TButton;
    pnlBackground: TPanel;
    pnlTopBar: TPanel;
    imgShowOrHideSideBar: TImage;
    Image1: TImage;
    Image4: TImage;
    lblDate: TLabel;
    lblNameOfTheWeek: TLabel;
    lblCompanyAliasName: TLabel;
    imgDadosEmpLogo: TImage;
    lblCompanyEin: TLabel;
    imgNetConnected: TImage;
    imgNetDisconnected: TImage;
    SplitView1: TSplitView;
    Panel7: TPanel;
    Image8: TImage;
    lblUserLoggedLogin: TLabel;
    Image9: TImage;
    lblStationNumber: TLabel;
    Image10: TImage;
    lblPcName: TLabel;
    ScrollBox1: TScrollBox;
    XPBarStock: TJvXPBar;
    imgCatalago: TImage;
    menuFinanceiro: TJvXPBar;
    imgFinanceiro: TImage;
    menuFavoritos: TJvXPBar;
    imgFavoritos: TImage;
    imgFavoritosAjustar: TImage;
    menuCompras: TJvXPBar;
    imgCompras: TImage;
    menuVendas: TJvXPBar;
    imgVendas: TImage;
    menuRelatorios: TJvXPBar;
    imgRelatorios: TImage;
    menuFiscal: TJvXPBar;
    Image3: TImage;
    XPBarConfiguration: TJvXPBar;
    imgConfiguracoes: TImage;
    Panel1: TPanel;
    pnlBody: TPanel;
    pgcActiveForms: TPageControl;
    TabSheet1: TTabSheet;
    pnlDashboard: TPanel;
    imgPrinc: TImage;
    btnCloseTabSheet: TButton;
    PopupMenu1: TPopupMenu;
    Abas1: TMenuItem;
    mniCloseCurrentTab: TMenuItem;
    mniCloseOthersTab: TMenuItem;
    mniCloseAllTabs: TMenuItem;
    tmrCheckInternet: TTimer;
    procedure FormShow(Sender: TObject);
    procedure tmrCheckInternetTimer(Sender: TObject);
    procedure imgNetDisconnectedClick(Sender: TObject);
    procedure actBrandExecute(Sender: TObject);
    procedure pgcActiveFormsMouseEnter(Sender: TObject);
    procedure pgcActiveFormsMouseLeave(Sender: TObject);
    procedure pgcActiveFormsMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure imgCloseTabSheetClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure mniCloseCurrentTabClick(Sender: TObject);
    procedure mniCloseOthersTabClick(Sender: TObject);
    procedure mniCloseAllTabsClick(Sender: TObject);
    procedure xpBarClick(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actPersonExecute(Sender: TObject);
  private
    FTabSheetTag: Integer;
    FNetConnectedLog: IShared<TStringList>;
    FIsNetConnected: Boolean;
    FBrandHandleLocateView: TBrandIndexView;
    procedure SetIsNetConnected(const Value: Boolean);
    procedure LoadUserLoggedOnMainScreen;
    function  LoadAndShowForm(const AFrmClass: TComponentClass; ACaption: String): TForm;
    procedure ShowTabCloseButtonOnHotTab;
  public
    property IsNetConnected: Boolean read FIsNetConnected write SetIsNetConnected;
  end;

var
  MainView: TMainView;

implementation

{$R *.dfm}

uses
  uLogin.View,
  uHlp,
  System.Threading,
  Winapi.ShellApi,
  uUserLogged,
  uNotificationView,
  uPerson.Index.View;

procedure TMainView.actBrandExecute(Sender: TObject);
begin
  LoadAndShowForm(TBrandIndexView, 'Marca');
end;

procedure TMainView.imgCloseTabSheetClick(Sender: TObject);
begin
  // Não permitir operação com Home
  if String(pgcActiveForms.Pages[btnCloseTabSheet.Tag].Caption).Trim.ToLower = 'home' then Exit;

  pgcActiveForms.Pages[btnCloseTabSheet.Tag].Free;
  pgcActiveForms.ActivePageIndex := Pred(btnCloseTabSheet.Tag);
  ShowTabCloseButtonOnHotTab;
end;

procedure TMainView.actPersonExecute(Sender: TObject);
begin
  LoadAndShowForm(TPersonIndexView, 'Pessoa');
end;

procedure TMainView.FormDestroy(Sender: TObject);
begin
  if Assigned(FBrandHandleLocateView) then FreeAndNil(FBrandHandleLocateView);
end;

procedure TMainView.FormShow(Sender: TObject);
var
  lLoginView: TLoginView;
begin
  // Preparar Tela
  pgcActiveForms.Align     := alClient;
  imgNetConnected.Width    := 0;
  imgNetDisconnected.Width := 0;
  FNetConnectedLog         := Shared<TStringList>.Make;
  tmrCheckInternet.Enabled := True;
  tmrCheckInternetTimer(tmrCheckInternet);

  // Efetuar Login
  lLoginView := TLoginView.Create(nil);
  try
    if not (lLoginView.ShowModal = mrOK) then
      Application.Terminate;
  finally
    lLoginView.Free;
  end;

  // Carregar dados do usuário logado
  LoadUserLoggedOnMainScreen;
end;

procedure TMainView.Image4Click(Sender: TObject);
var
  lTransparentBackground: TForm;
begin
  Try
    lTransparentBackground := TForm.Create(nil);
    THlp.createTransparentBackground(lTransparentBackground);

    // Instanciar
    if not Assigned(FBrandHandleLocateView) then
    begin
      FBrandHandleLocateView := TBrandIndexView.Create(nil);
      FBrandHandleLocateView.SetLayoutLocate(False);
    End;

    // Localizar Produto
    if not (FBrandHandleLocateView.ShowModal = mrOK) then Exit;
    ShowMessage(FBrandHandleLocateView.LocateResult.ToString);
  finally
    lTransparentBackground.Hide;
    if Assigned(lTransparentBackground) then FreeAndNil(lTransparentBackground);
  end;
end;

procedure TMainView.imgNetDisconnectedClick(Sender: TObject);
Var
  sArquivo: String;
begin
  if FNetConnectedLog.Text.Trim.IsEmpty then
  begin
    showmessage('Desconexões dessa instância do app não foram registradas.');
    Exit;
  end;

  sArquivo := ExtractFileDir(application.ExeName)+'\disconnectlog.txt';
  FNetConnectedLog.SaveToFile(sArquivo);
  ShellExecute(0,Nil,PChar(sArquivo),'', Nil, SW_SHOWNORMAL);
end;

function TMainView.LoadAndShowForm(const AFrmClass: TComponentClass; ACaption: String): TForm;
var
  lTabSheetShow: TTabSheet;
  lFormShow: TComponent;
  lI: Integer;
  lSourceStr, lTargetStr: String;
  lWindowWidth, lWindowHeight: Integer;
  lCloseMenu: Boolean;
  lJ: Integer;
begin
  Result := nil;

  lWindowWidth  := GetSystemMetrics(SM_CXSCREEN) - (GetSystemMetrics(SM_CXSCREEN) - GetSystemMetrics(SM_CXFULLSCREEN));
  lWindowHeight := GetSystemMetrics(SM_CYSCREEN) - (GetSystemMetrics(SM_CYSCREEN) - GetSystemMetrics(SM_CYFULLSCREEN)) + GetSystemMetrics(SM_CYCAPTION);
  lCloseMenu    := (lWindowWidth <= 1200) or (lWindowHeight <= 750);
  if lCloseMenu then
    SplitView1.Opened := False;

  // Se formulário já existir, apenas abre
  for lI := 0 to Pred(pgcActiveForms.PageCount) do
  Begin
    lSourceStr := String(pgcActiveForms.Pages[lI].Caption).Trim.ToLower;
    lTargetStr := ACaption.Trim.ToLower;

    if (lSourceStr = lTargetStr) then
    begin
      for lJ := 0 to Pred(pgcActiveForms.Pages[lI].ControlCount) do
      begin
        if (pgcActiveForms.Pages[lI].Controls[lJ] is TForm) then
        begin
          Result := TForm(pgcActiveForms.Pages[lI].Controls[lJ]);
          Break;
        end;
      end;
      pgcActiveForms.ActivePageIndex := lI;
      Exit;
    end;
  End;

  // Limite de abas abertas (10)
  if (pgcActiveForms.PageCount > 10) then
  begin
    NotificationView.Execute('Limite(10) de páginas foi atingido. Encerre alguma página e tente novamente.', tneError);
    Abort;
  end;

  // Se formulário não existir, cria aba para abrir
  lTabSheetShow             := TTabSheet.Create(pgcActiveForms);
  lTabSheetShow.Parent      := pgcActiveForms;
  lTabSheetShow.PageControl := pgcActiveForms;
  lTabSheetShow.Caption     := '     ' + ACaption + '     ';

  // Se formulário não existir, cria formulário e coloca na aba criada
  lFormShow := AFrmClass.Create(lTabSheetShow);
  TForm(lFormShow).Parent      := lTabSheetShow;
  TForm(lFormShow).Align       := alClient;
  TForm(lFormShow).BorderStyle := bsNone;
  TForm(lFormShow).Show;
  TForm(lFormShow).BringToFront;
  Result := TForm(lFormShow);
  pgcActiveForms.ActivePageIndex := Pred(pgcActiveForms.PageCount);
end;

procedure TMainView.LoadUserLoggedOnMainScreen;
begin
  lblCompanyAliasName.Caption := 'Nenhuma';
  lblCompanyEin.Caption       := '000.000.000-00';
  lblDate.Caption             := FormatDateTime('DD/MM', now);
  lblNameOfTheWeek.Caption    := Thlp.DayOfWeekStr(now);
  lblUserLoggedLogin.Caption  := Copy(UserLogged.Current.login,1,12);
  lblStationNumber.Caption    := '000';
  lblPcName.Caption           := Copy(THlp.getPcName,1,12);
end;

procedure TMainView.mniCloseAllTabsClick(Sender: TObject);
var
  lI: Integer;
begin
  Try
    // Evita bug de layoyt
    pgcActiveForms.Align  := alNone;
    pgcActiveForms.Height := 0;

    pgcActiveForms.Align  := alNone;
    for lI := Pred(pgcActiveForms.PageCount) downto 0 do
    begin
      // Não permitir operação com Home
      if String(pgcActiveForms.Pages[lI].Caption).Trim.ToLower <> 'home' then
        pgcActiveForms.Pages[lI].Free;
    end;
  Finally
    pgcActiveForms.Align  := alClient;
  End;
end;

procedure TMainView.mniCloseCurrentTabClick(Sender: TObject);
begin
  Try
    // Evita bug de layoyt
    pgcActiveForms.Align  := alNone;
    pgcActiveForms.Height := 0;

    // Não permitir operação com Home
    if String(pgcActiveForms.Pages[FTabSheetTag].Caption).Trim.ToLower = 'home' then Exit;

    pgcActiveForms.Pages[FTabSheetTag].Free;
    pgcActiveForms.ActivePageIndex := Pred(FTabSheetTag);
  Finally
    pgcActiveForms.Align  := alClient;
  End;
end;

procedure TMainView.mniCloseOthersTabClick(Sender: TObject);
var
  lI: Integer;
begin
  Try
    // Evita bug de layoyt
    pgcActiveForms.Align  := alNone;
    pgcActiveForms.Height := 0;

    for lI := Pred(pgcActiveForms.PageCount) downto 0 do
    begin
      if (FTabSheetTag <> lI) then
      Begin
        // Não permitir operação com Home
        if String(pgcActiveForms.Pages[lI].Caption).Trim.ToLower <> 'home' then
          pgcActiveForms.Pages[lI].Free;
      End;
    end;

    if (pgcActiveForms.PageCount > 0)        then pgcActiveForms.ActivePageIndex := 1;
    if (pgcActiveForms.ActivePageIndex = -1) then pgcActiveForms.ActivePageIndex := 0;
  Finally
    pgcActiveForms.Align  := alClient;
  End;
end;

procedure TMainView.pgcActiveFormsMouseEnter(Sender: TObject);
begin
  ShowTabCloseButtonOnHotTab;
end;

procedure TMainView.pgcActiveFormsMouseLeave(Sender: TObject);
begin
  if btnCloseTabSheet <> FindVCLWindow(Mouse.CursorPos) then
  begin
    btnCloseTabSheet.Hide;
    btnCloseTabSheet.Tag := -1;
  end;
end;

procedure TMainView.pgcActiveFormsMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
{$WRITEABLECONST ON}
const oldPos : integer = -2;
{$WRITEABLECONST OFF}
var
  iot : integer;
  ctrl : TWinControl;
begin
  inherited;

  iot := TPageControl(Sender).IndexOfTabAt(x,y);

  if (iot > -1) then
  begin
    if iot <> oldPos then
      ShowTabCloseButtonOnHotTab;
  end;

  oldPos := iot;
end;

procedure TMainView.PopupMenu1Popup(Sender: TObject);
begin
  if (btnCloseTabSheet.Tag < 0) then Abort;
  FTabSheetTag := btnCloseTabSheet.Tag;
end;

procedure TMainView.SetIsNetConnected(const Value: Boolean);
begin
  FIsNetConnected := Value;

  case FIsNetConnected of
    True: Begin
      imgNetConnected.Width    := 40;
      imgNetDisconnected.Width :=  0;
    end;
    False: begin
      imgNetConnected.Width    :=  0;
      imgNetDisconnected.Width := 40;

      FNetConnectedLog.Add(DateTimeToStr(now()) + ' - Internet desconectada.');
    end;
  end;
end;

procedure TMainView.ShowTabCloseButtonOnHotTab;
var
  iot : integer;
  cp : TPoint;
  rectOver: TRect;
begin
  cp  := pgcActiveForms.ScreenToClient(Mouse.CursorPos);
  iot := pgcActiveForms.IndexOfTabAt(cp.X, cp.Y);

  if iot > -1 then
  begin
    rectOver := pgcActiveForms.TabRect(iot);

    btnCloseTabSheet.Left := rectOver.Right - btnCloseTabSheet.Width;
    btnCloseTabSheet.Top  := rectOver.Top + ((rectOver.Height div 2) - (btnCloseTabSheet.Height div 2));

    btnCloseTabSheet.Tag := iot;
    btnCloseTabSheet.Show;
  end
  else
  begin
    btnCloseTabSheet.Tag := -1;
    btnCloseTabSheet.Hide;
  end;
end;

procedure TMainView.tmrCheckInternetTimer(Sender: TObject);
var
  lIsConnected: Boolean;
begin
  TTask.Run(procedure
  begin
    lIsConnected := THlp.InternetIsConnected;

    TThread.Synchronize(TThread.CurrentThread, procedure
    begin
      IsNetConnected := lIsConnected;
    end)
  end);
end;

procedure TMainView.xpBarClick(Sender: TObject);
var
  lI: Integer;
begin
  // Fechar Todos
  if not Assigned(Sender) then
  begin
    for lI := 0 to Pred(ComponentCount) do
    if (Components[lI] is TJvXPBar) then
      TJvXPBar(Components[lI]).Collapsed := True;
    Exit;
  end;

  // Abrir selecionado e fechar os outros
  if TJvXPBar(Sender).Collapsed then
  Begin
    TJvXPBar(Sender).Collapsed  := False;
    for lI := 0 to Pred(ComponentCount) do
    if (Components[lI] is TJvXPBar) then
    if TJvXPBar(Components[lI]).Name <> TJvXPBar(Sender).Name then
      TJvXPBar(Components[lI]).Collapsed := True;
  End else
    TJvXPBar(Sender).Collapsed := True;
end;

end.
