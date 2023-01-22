unit uBusinessProposalItem.SQLBuilder.MySQL;

interface

uses
  uBusinessProposalItem.SQLBuilder,
  uBusinessProposalItem.SQLBuilder.Interfaces;

type
  TBusinessProposalItemSQLBuilderMySQL = class(TBusinessProposalItemSQLBuilder, IBusinessProposalItemSQLBuilder)
  public
    constructor Create;
    class function Make: IBusinessProposalItemSQLBuilder;
    function ScriptCreateTable: String; override;
  end;

implementation

uses
  cqlbr.interfaces;

{ TBusinessProposalItemSQLBuilderMySQL }

constructor TBusinessProposalItemSQLBuilderMySQL.Create;
begin
  inherited Create;
  FDBName := dbnMySQL;
end;

class function TBusinessProposalItemSQLBuilderMySQL.Make: IBusinessProposalItemSQLBuilder;
begin
  Result := Self.Create;
end;

function TBusinessProposalItemSQLBuilderMySQL.ScriptCreateTable: String;
begin
  Result := ' CREATE TABLE `business_proposal_item` ('+
            '   `id` bigint(20) NOT NULL AUTO_INCREMENT,'+
            '   `business_proposal_id` bigint(20) NOT NULL,'+
            '   `product_id` bigint(20) NOT NULL,'+
            '   `note` varchar(255) DEFAULT NULL,'+
            '   `quantity` decimal(18,4) DEFAULT NULL,'+
            '   `price` decimal(18,4) DEFAULT NULL,'+
            '   `unit_discount` decimal(18,4) DEFAULT NULL,'+
            '   PRIMARY KEY (`id`),'+
            '   KEY `business_proposal_item_fk_business_proposal_id` (`business_proposal_id`),'+
            '   KEY `business_proposal_item_fk_product_id` (`product_id`),'+
            '   CONSTRAINT `business_proposal_item_fk_business_proposal_id` FOREIGN KEY (`business_proposal_id`) REFERENCES `business_proposal` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,'+
            '   CONSTRAINT `business_proposal_item_fk_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)'+
            ' ) '
end;

end.
