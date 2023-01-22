unit uSaleItem.SQLBuilder.MySQL;

interface

uses
  uSaleItem.SQLBuilder,
  uSaleItem.SQLBuilder.Interfaces;

type
  TSaleItemSQLBuilderMySQL = class(TSaleItemSQLBuilder, ISaleItemSQLBuilder)
  public
    constructor Create;
    class function Make: ISaleItemSQLBuilder;
    function ScriptCreateTable: String; override;
  end;

implementation

uses
  cqlbr.interfaces;

{ TSaleItemSQLBuilderMySQL }

constructor TSaleItemSQLBuilderMySQL.Create;
begin
  inherited Create;
  FDBName := dbnMySQL;
end;

class function TSaleItemSQLBuilderMySQL.Make: ISaleItemSQLBuilder;
begin
  Result := Self.Create;
end;

function TSaleItemSQLBuilderMySQL.ScriptCreateTable: String;
begin
  Result := ' CREATE TABLE `sale_item` ( '+
            ' `id` bigint(20) NOT NULL AUTO_INCREMENT, '+
            ' `sale_id` bigint(20) NOT NULL, '+
            ' `product_id` bigint(20) NOT NULL, '+
            ' `note` varchar(255) DEFAULT NULL, '+
            ' `quantity` decimal(18,4) DEFAULT NULL, '+
            ' `price` decimal(18,4) DEFAULT NULL, '+
            ' `unit_discount` decimal(18,4) DEFAULT NULL, '+
            ' PRIMARY KEY (`id`), '+
            ' KEY `sale_item_fk_sale_id` (`sale_id`), '+
            ' KEY `sale_item_fk_product_id` (`product_id`), '+
            ' CONSTRAINT `sale_item_fk_sale_id` FOREIGN KEY (`sale_id`) REFERENCES `sale` (`id`) ON DELETE CASCADE ON UPDATE CASCADE, '+
            ' CONSTRAINT `sale_item_fk_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) '+
            ' ) ';
end;

end.
