unit uBusinessProposal.Report;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBase.Report, RLReport,
  Vcl.Imaging.pngimage, Data.DB, RLFilters, RLPDFFilter, RLPreviewForm, RLXLSXFilter,
  RLXLSFilter, RLHTMLFilter, RLRichFilter, RLDraftFilter, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.StorageBin,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uZLMemTable.Interfaces,

  uOutPutFileStream,
  uTenant;

type
  TBusinessProposalReport = class(TBaseReport)
    dtsBusinessProposal: TDataSource;
    dtsBusinessProposalItem: TDataSource;
    RLBand1: TRLBand;
    RLBand2: TRLBand;
    RLPanel1: TRLPanel;
    RLPanel2: TRLPanel;
    RLPanel3: TRLPanel;
    lblData: TRLLabel;
    memPersonInfo: TRLMemo;
    RLLabel5: TRLLabel;
    memPersonContact: TRLMemo;
    lblReportTitle: TRLLabel;
    RLLabel4: TRLLabel;
    RLBand3: TRLBand;
    RLPanel4: TRLPanel;
    RLLabel2: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel9: TRLLabel;
    RLBand4: TRLBand;
    RLBand5: TRLBand;
    RLPanel5: TRLPanel;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel15: TRLLabel;
    RLLabel16: TRLLabel;
    RLLabel17: TRLLabel;
    RLBand6: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    RLDBText10: TRLDBText;
    RLDBText11: TRLDBText;
    RLDBText12: TRLDBText;
    RLDBMemo1: TRLDBMemo;
    RLBand7: TRLBand;
    RLPanel7: TRLPanel;
    RLLabel1: TRLLabel;
    RLBand8: TRLBand;
    bndPaymentTermNote: TRLBand;
    RLPanel15: TRLPanel;
    RLLabel8: TRLLabel;
    RLDBMemo2: TRLDBMemo;
    bndNote: TRLBand;
    RLPanel16: TRLPanel;
    RLLabel10: TRLLabel;
    RLDBMemo3: TRLDBMemo;
    RLBand11: TRLBand;
    bndProductNote: TRLBand;
    RLDBMemo4: TRLDBMemo;
    RLPanel6: TRLPanel;
    RLLabel14: TRLLabel;
    RLDBText7: TRLDBText;
    procedure RLBand6AfterPrint(Sender: TObject);
  private
    { Private declarations }
    FTenant: TTenant;
    FBusinessProposal: IZLMemTable;
    FBusinessProposalItem: IZLMemTable;
  public
    { Public declarations }
    class function Execute(ATenant: TTenant; ABusinessProposal, ABusinessProposalItem: IZLMemTable): IOutPutFileStream;
    function Prepare(ABusinessProposal, ABusinessProposalItem: IZLMemTable): TBusinessProposalReport;
  end;

var
  BusinessProposalReport: TBusinessProposalReport;

implementation

uses
  uHlp,
  RLPrinters,
  System.IOUtils;

{$R *.dfm}

class function TBusinessProposalReport.Execute(ATenant: TTenant; ABusinessProposal, ABusinessProposalItem: IZLMemTable): IOutPutFileStream;
var
  lView: TBusinessProposalReport;
  lPathFile: String;
  lTitle: String;
begin
  lView := TBusinessProposalReport.Create(nil);
  try
    lView.LoadTenant(ATenant);
    lView.Prepare(ABusinessProposal, ABusinessProposalItem);

    // Gerar PDF
    lTitle    := Format('Proposta Comercial %s %s', [FormatDateTime('dd-mm-yyyy', now), THlp.createGuid]);
    lPathFile := lView.FPath + lTitle + '.pdf';
    lView.RLReport1.SaveToFile(lPathFile);

    Result := TOutPutFileStream.Make(lPathFile);
  finally
    if Assigned(lView) then FreeAndNil(lView);
  end;
end;

function TBusinessProposalReport.Prepare(ABusinessProposal, ABusinessProposalItem: IZLMemTable): TBusinessProposalReport;
var
  lDocs: String;
  lCityInfo: String;
  lI: Integer;
begin
  FBusinessProposal     := ABusinessProposal;
  FBusinessProposalItem := ABusinessProposalItem;

  // Formatar e Ligar DataSets
  THlp.formatDataSet(FBusinessProposal.DataSet);
  THlp.formatDataSet(FBusinessProposalItem.DataSet);
  dtsBusinessProposal.DataSet     := FBusinessProposal.DataSet;
  dtsBusinessProposalItem.DataSet := FBusinessProposalItem.DataSet;

  With dtsBusinessProposal.DataSet do
  begin
    // Título do Relatório
    lblReportTitle.Caption := 'PROPOSTA COMERCIAL Nº ' + Thlp.strZero(FieldByName('id').AsString,5);

    // Dados do Header
    lDocs := 'Nenhum documento informado.';
    if not FieldByName('person_legal_entity_number').AsString.Trim.IsEmpty then
    begin
      case THlp.IsJuridicaDoc(FieldByName('person_legal_entity_number').AsString) of
        True:  lDocs := 'CNPJ: ' + THlp.validateCpfCnpj(FieldByName('person_legal_entity_number').AsString) + ' IE: ' + FieldByName('person_state_registration').AsString;
        False: lDocs := 'CPF: '  + THlp.validateCpfCnpj(FieldByName('person_legal_entity_number').AsString) + ' RG: ' + FieldByName('person_state_registration').AsString;
      end;
    end;

    // Fantasia e Endereço do Cliente
    memPersonInfo.Lines.Clear;
    memPersonInfo.Lines.Add(lDocs);
    memPersonInfo.Lines.Add('');
    memPersonInfo.Lines.Add(FieldByName('person_alias_name').AsString.Trim);
    memPersonInfo.Lines.Add(
      FieldByName('person_address').AsString + ' | ' +
      FieldByName('person_address_number').AsString + ' | ' +
      FieldByName('person_complement').AsString + ' | ' +
      FieldByName('person_district').AsString
    );
    lCityInfo := FieldByName('city_name').AsString + ' | ' + FieldByName('city_state').AsString;
    if not FieldByName('person_zipcode').AsString.Trim.IsEmpty then
      lCityInfo := lCityInfo + ' | Cep: ' + THlp.formatZipCode(FieldByName('person_zipcode').AsString);
    memPersonInfo.Lines.Add(lCityInfo);

    // Contatos do Cliente
    memPersonContact.Lines.Clear;
    if not FieldByName('person_phone_1').AsString.Trim.IsEmpty then
      memPersonContact.Lines.Add(THlp.formatPhone(FieldByName('person_phone_1').AsString));

    if not FieldByName('person_phone_2').AsString.Trim.IsEmpty then
      memPersonContact.Lines.Add(THlp.formatPhone(FieldByName('person_phone_2').AsString));

    if not FieldByName('person_phone_3').AsString.Trim.IsEmpty then
      memPersonContact.Lines.Add(THlp.formatPhone(FieldByName('person_phone_3').AsString));

    if (memPersonContact.Lines.Count > 0) then
      memPersonContact.Lines.Add('');

    if not FieldByName('person_company_email').AsString.Trim.IsEmpty then
      memPersonContact.Lines.Add(FieldByName('person_company_email').AsString);

    if not FieldByName('person_financial_email').AsString.Trim.IsEmpty then
      memPersonContact.Lines.Add(FieldByName('person_financial_email').AsString);

    // Exibir Informações
    bndNote.Visible            := not FieldByName('note').AsString.Trim.IsEmpty;
    bndPaymentTermNote.Visible := not FieldByName('payment_term_note').AsString.Trim.IsEmpty;

    // Limpar pontos se não existirem dados
    for lI := 0 to Pred(memPersonInfo.Lines.Count) do
    begin
      if (THlp.removeDots(memPersonInfo.Lines[lI]) = EmptyStr) then
        memPersonInfo.Lines[lI] := EmptyStr;
    end;
  end;
end;

procedure TBusinessProposalReport.RLBand6AfterPrint(Sender: TObject);
begin
  inherited;

  bndProductNote.Visible := not dtsBusinessProposalItem.DataSet.FieldByName('note').AsString.Trim.IsEmpty;
end;

end.
