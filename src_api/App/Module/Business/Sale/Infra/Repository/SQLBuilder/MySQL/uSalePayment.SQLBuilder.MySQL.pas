unit uSalePayment.SQLBuilder.MySQL;

interface

uses
  uSalePayment.SQLBuilder,
  uSalePayment.SQLBuilder.Interfaces;

type
  TSalePaymentSQLBuilderMySQL = class(TSalePaymentSQLBuilder, ISalePaymentSQLBuilder)
  public
    constructor Create;
    class function Make: ISalePaymentSQLBuilder;
    function ScriptCreateTable: String; override;
  end;

implementation

uses
  cqlbr.interfaces;

{ TSalePaymentSQLBuilderMySQL }

constructor TSalePaymentSQLBuilderMySQL.Create;
begin
  inherited Create;
  FDBName := dbnMySQL;
end;

class function TSalePaymentSQLBuilderMySQL.Make: ISalePaymentSQLBuilder;
begin
  Result := Self.Create;
end;

function TSalePaymentSQLBuilderMySQL.ScriptCreateTable: String;
begin
  Result := ' CREATE TABLE `sale_payment` ( '+
            ' `id` bigint(20) NOT NULL AUTO_INCREMENT, '+
            ' `sale_id` bigint(20) NOT NULL, '+
            ' `bank_account_id` bigint(20) NOT NULL, '+
            ' `document_id` bigint(20) NOT NULL, '+
            ' `expiration_date` date NOT NULL, '+
            ' `amount` decimal(18,4) DEFAULT NULL, '+
            ' `note` varchar(255) DEFAULT NULL, '+
            ' PRIMARY KEY (`id`), '+
            ' KEY `sale_payment_idx_expiration_date` (`expiration_date`), '+
            ' KEY `sale_payment_fk_sale_id` (`sale_id`), '+
            ' KEY `sale_payment_fk_bank_account_id` (`bank_account_id`), '+
            ' KEY `sale_payment_fk_document_id` (`document_id`), '+
            ' CONSTRAINT `sale_payment_fk_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `bank_account` (`id`), '+
            ' CONSTRAINT `sale_payment_fk_document_id` FOREIGN KEY (`document_id`) REFERENCES `document` (`id`), '+
            ' CONSTRAINT `sale_payment_fk_sale_id` FOREIGN KEY (`sale_id`) REFERENCES `sale` (`id`) ON DELETE CASCADE ON UPDATE CASCADE '+
            ' ) ';
end;

end.
