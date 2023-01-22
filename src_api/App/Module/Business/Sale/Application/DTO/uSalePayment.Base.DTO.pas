unit uSalePayment.Base.DTO;

interface

uses
  GBSwagger.Model.Attributes,
  uApplication.Types;

type
  TSalePaymentBaseDTO = class
  private
    Fbank_account_id: Int64;
    Fdocument_id: Int64;
    Fid: Int64;
    Fnote: String;
    Famount: Double;
    Fexpiration_date: TDate;
    Fsale_id: Int64;
    Fdocument_name: String;
    Fbank_account_name: String;
  public
    [SwagNumber]
    [SwagProp('id', 'ID', false)]
    property id: Int64 read Fid write Fid;

    [SwagNumber]
    [SwagProp('bank_account_id', 'ID da Conta Bancária', true)]
    property bank_account_id: Int64 read Fbank_account_id write Fbank_account_id;

    [SwagNumber]
    [SwagProp('document_id', 'ID do Documento', true)]
    property document_id: Int64 read Fdocument_id write Fdocument_id;

    [SwagDate(DATETIME_DISPLAY_FORMAT)]
    [SwagProp('expiration_date', 'ID do Documento', true)]
    property expiration_date: TDate read Fexpiration_date write Fexpiration_date;

    [SwagNumber]
    [SwagProp('amount', 'Valor', false)]
    property amount: Double read Famount write Famount;

    [SwagString]
    [SwagProp('note', 'Observação', false)]
    property note: String read Fnote write Fnote;

    [SwagString(255)] {virtual}
    [SwagProp('bank_account_name', 'Nome da Conta Bancária', false)]
    property bank_account_name: String read Fbank_account_name write Fbank_account_name;

    [SwagString(255)] {virtual}
    [SwagProp('document_name', 'Nome do Documento', false)]
    property document_name: String read Fdocument_name write Fdocument_name;
  end;

implementation

end.
