unit uPaymentTerm.Base.DTO;

interface

uses
  GBSwagger.Model.Attributes;

type
  TPaymentTermBaseDTO = class
  private
    Fname: string;
    Finterval_between_installments: Int64;
    Fnumber_of_installments: Int64;
    Fbank_account_id: Int64;
    Ffirst_installment_in: Int64;
    Fdocument_id: Int64;
  public
    [SwagString(100)]
    [SwagProp('name', 'Nome', true)]
    property name: string read Fname write Fname;

    [SwagNumber]
    [SwagProp('number_of_installments', 'Quantidade de parcelas', false)]
    property number_of_installments: Int64 read Fnumber_of_installments write Fnumber_of_installments;

    [SwagNumber]
    [SwagProp('first_installment_in', 'Primeira parcela em (Dias)', false)]
    property first_installment_in: Int64 read Ffirst_installment_in write Ffirst_installment_in;

    [SwagNumber]
    [SwagProp('interval_between_installments', 'Intervalo entre as parcelas (Dias)', false)]
    property interval_between_installments: Int64 read Finterval_between_installments write Finterval_between_installments;

    [SwagNumber]
    [SwagProp('bank_account_id', 'ID da conta bancária', true)]
    property bank_account_id: Int64 read Fbank_account_id write Fbank_account_id;

    [SwagNumber]
    [SwagProp('document_id', 'ID do Documento', true)]
    property document_id: Int64 read Fdocument_id write Fdocument_id;
  end;

implementation

end.
