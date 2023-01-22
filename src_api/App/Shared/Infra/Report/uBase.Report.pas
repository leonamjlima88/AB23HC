unit uBase.Report;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage, RLFilters, RLPDFFilter, RLPreviewForm, RLXLSXFilter,
  RLXLSFilter, RLHTMLFilter, RLRichFilter, RLDraftFilter,

  uTenant;

type
  TBaseReport = class(TForm)
    RLReport1: TRLReport;
    bndHeader: TRLBand;
    memCompanyMoreInfo: TRLMemo;
    pnlLogo: TRLPanel;
    imgLogo: TRLImage;
    memCompanyAliasName: TRLMemo;
    bndFooter: TRLBand;
    RLSystemInfo1PageNumber: TRLSystemInfo;
    pnlDivisor2: TRLPanel;
    bndTopHeader: TRLBand;
    pnlDivisor: TRLPanel;
    bndSpacer1: TRLBand;
    RLSystemInfo4PageCount: TRLSystemInfo;
    lblSoftwareHouse: TRLLabel;
    lblCompanyEin: TRLLabel;
    RLSystemInfo1FullDate: TRLSystemInfo;
    memCompanyContacts: TRLMemo;
    RLPDFFilter1: TRLPDFFilter;
    RLDraftFilter1: TRLDraftFilter;
    RLRichFilter1: TRLRichFilter;
    RLHTMLFilter1: TRLHTMLFilter;
    RLXLSFilter1: TRLXLSFilter;
    RLXLSXFilter1: TRLXLSXFilter;
    RLPreviewSetup1: TRLPreviewSetup;
    procedure FormCreate(Sender: TObject);
    procedure RLPreviewSetup1Send(Sender: TObject);
  private
  public
    FPath: String;
    procedure LoadTenant(ATenant: TTenant);
  end;

var
  BaseReport: TBaseReport;

implementation

uses
  uHlp;

{$R *.dfm}

procedure TBaseReport.FormCreate(Sender: TObject);
begin
  // Criar diretório se não existir
  FPath := ExtractFilePath(ParamStr(0)) + 'Temp\';
  if not DirectoryExists(FPath) then ForceDirectories(FPath);
end;

procedure TBaseReport.LoadTenant(ATenant: TTenant);
var
  lAux: String;
begin
  // Fantasia, CNPJ e Razão
  memCompanyAliasName.Lines.Text := ATenant.alias_name.ToUpper;
  lblCompanyEin.Caption          := ATenant.legal_entity_number.FormatedValue;
  memCompanyMoreInfo.Lines.Add(ATenant.name.ToUpper);

  // Endereço
  memCompanyMoreInfo.Lines.Clear;
  lAux := EmptyStr;
  if not ATenant.address.Trim.IsEmpty        then lAux := lAux + ATenant.address + ', ';
  if not ATenant.address_number.Trim.IsEmpty then lAux := lAux + ATenant.address_number + ', ';
  if not ATenant.complement.Trim.IsEmpty     then lAux := lAux + ATenant.complement + ' | ';
  if not ATenant.district.Trim.IsEmpty       then lAux := lAux + ATenant.district;
  if not lAux.Trim.IsEmpty then
    memCompanyMoreInfo.Lines.Add(lAux);

  lAux := EmptyStr;
  if not ATenant.city.name.Trim.IsEmpty  then lAux := lAux + ATenant.city.name + ' - ';
  if not ATenant.city.state.Trim.IsEmpty then lAux := lAux + ATenant.city.state + ', Cep: ';
  if not ATenant.zipcode.Trim.IsEmpty    then lAux := lAux + THlp.formatZipCode(ATenant.zipcode);
  if not lAux.Trim.IsEmpty then
    memCompanyMoreInfo.Lines.Add(lAux);

  // Contatos
  lAux := EmptyStr;
  if not ATenant.phone_1.Trim.IsEmpty       then lAux := lAux + THlp.formatPhone(ATenant.phone_2) + ' | ';
  if not ATenant.phone_2.Trim.IsEmpty       then lAux := lAux + THlp.formatPhone(ATenant.phone_2) + ' | ';
  if not ATenant.company_email.Trim.IsEmpty then lAux := lAux + ATenant.company_email + ' | ';
  memCompanyContacts.Lines.Clear;
  if not lAux.Trim.IsEmpty then
    memCompanyContacts.Lines.Add(lAux);

  // Logo
  // ...
end;

procedure TBaseReport.RLPreviewSetup1Send(Sender: TObject);
//var
//  Filt: TRLCustomSaveFilter;
//  Prev: TRLPreview;
begin
//  Prev := TRLPreviewForm(Sender).Preview;
//  Filt := TRLCustomSaveFilter(SelectedFilter);
//  Filt := SaveFilterByFileName('C:\Temp\TESTE.PDF');
//  Filt.FileName := 'C:\Temp\TESTE.PDF';
//  Filt.FilterPages(Prev.Pages, 1, Prev.Pages.PageCount, '', PrintOddAndEvenPages);
//
//  ShellExecute(0,Nil,PChar('C:\Temp\TESTE.PDF'),'', Nil, SW_SHOWNORMAL);

//  emailEntity.loadfromfile('C:\XXX\TESTE.PDF');
//  emailEntity.send.
end;

end.
