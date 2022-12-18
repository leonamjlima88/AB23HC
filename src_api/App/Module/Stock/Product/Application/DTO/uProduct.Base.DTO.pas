unit uProduct.Base.DTO;

interface

uses
  GBSwagger.Model.Attributes;

type
  TProductBaseDTO = class
  private
    Fname: string;
    Fgross_weight: Double;
    Fcost: Double;
    Fgenre: SmallInt;
    Funit_id: Int64;
    Fpacking_weight: Double;
    Fprice: Double;
    Fcurrent_quantity: Double;
    Fmarketup: Double;
    Fis_to_move_the_stock: SmallInt;
    Fstorage_location_id: Int64;
    Fmanufacturing_code: String;
    Fsku_code: String;
    Fmaximum_quantity: Double;
    Fis_product_for_scales: SmallInt;
    Fean_code: String;
    Ftype: SmallInt;
    Fcomplement_note: String;
    Fnet_weight: Double;
    Fcategory_id: Int64;
    Fsize_id: Int64;
    Fbrand_id: Int64;
    Fsimplified_name: String;
    Fminimum_quantity: Double;
    Fis_discontinued: SmallInt;
    Finternal_note: String;
    Fidentification_code: String;
  public
    [SwagString(100)]
    [SwagProp('name', 'Nome', true)]
    property name: string read Fname write Fname;

    [SwagString(30)]
    [SwagProp('simplified_name', 'Nome simplificado', true)]
    property simplified_name: String read Fsimplified_name write Fsimplified_name;

    [SwagNumber]
    [SwagProp('type', 'Tipo [0=Produto, 1=Serviço]')]
    property &type: SmallInt read Ftype write Ftype;

    [SwagString(45)]
    [SwagProp('sku_code', 'Código de referência')]
    property sku_code: String read Fsku_code write Fsku_code;

    [SwagString(45)]
    [SwagProp('ean_code', 'Código de barras')]
    property ean_code: String read Fean_code write Fean_code;

    [SwagString(45)]
    [SwagProp('manufacturing_code', 'Código de fábricação')]
    property manufacturing_code: String read Fmanufacturing_code write Fmanufacturing_code;

    [SwagString(45)]
    [SwagProp('identification_code', 'Código de identificação')]
    property identification_code: String read Fidentification_code write Fidentification_code;

    [SwagNumber]
    [SwagProp('cost', 'Preço de custo')]
    property cost: Double read Fcost write Fcost;

    [SwagNumber]
    [SwagProp('price', 'Preço de venda')]
    property price: Double read Fprice write Fprice;

    [SwagNumber]
    [SwagProp('current_quantity', 'Quantidade em estoque')]
    property current_quantity: Double read Fcurrent_quantity write Fcurrent_quantity;

    [SwagNumber]
    [SwagProp('minimum_quantity', 'Quantidade mínima')]
    property minimum_quantity: Double read Fminimum_quantity write Fminimum_quantity;

    [SwagNumber]
    [SwagProp('maximum_quantity', 'Quantidade máxima')]
    property maximum_quantity: Double read Fmaximum_quantity write Fmaximum_quantity;

    [SwagNumber]
    [SwagProp('gross_weight', 'Peso bruto')]
    property gross_weight: Double read Fgross_weight write Fgross_weight;

    [SwagNumber]
    [SwagProp('net_weight', 'Peso líquido')]
    property net_weight: Double read Fnet_weight write Fnet_weight;

    [SwagNumber]
    [SwagProp('packing_weight', 'Peso da embalagem')]
    property packing_weight: Double read Fpacking_weight write Fpacking_weight;

    [SwagNumber]
    [SwagProp('is_to_move_the_stock', 'Movimentar estoque. [0=False, 1=True]')]
    property is_to_move_the_stock: SmallInt read Fis_to_move_the_stock write Fis_to_move_the_stock;

    [SwagNumber]
    [SwagProp('is_product_for_scales', 'Produto para pesar em balanças. [0=False, 1=True]')]
    property is_product_for_scales: SmallInt read Fis_product_for_scales write Fis_product_for_scales;

    [SwagString]
    [SwagProp('internal_note', 'Observação interna')]
    property internal_note: String read Finternal_note write Finternal_note;

    [SwagString]
    [SwagProp('complement_note', 'Observação complementar')]
    property complement_note: String read Fcomplement_note write Fcomplement_note;

    [SwagNumber]
    [SwagProp('is_discontinued', 'Produto descontinuado. [0=False, 1=True]')]
    property is_discontinued: SmallInt read Fis_discontinued write Fis_discontinued;

    [SwagNumber]
    [SwagProp('unit_id', 'ID da Unidade', true)]
    property unit_id: Int64 read Funit_id write Funit_id;

    [SwagNumber]
    [SwagProp('category_id', 'ID da Categoria')]
    property category_id: Int64 read Fcategory_id write Fcategory_id;

    [SwagNumber]
    [SwagProp('brand_id', 'ID da Marca')]
    property brand_id: Int64 read Fbrand_id write Fbrand_id;

    [SwagNumber]
    [SwagProp('size_id', 'ID do Tamanho')]
    property size_id: Int64 read Fsize_id write Fsize_id;

    [SwagNumber]
    [SwagProp('storage_location_id', 'ID do Local de Armazenamento')]
    property storage_location_id: Int64 read Fstorage_location_id write Fstorage_location_id;

    [SwagNumber]
    [SwagProp('genre', 'Gênero. [0=Nenhum, 1=Masculino, 2=Feminino, 3=Unisex]')]
    property genre: SmallInt read Fgenre write Fgenre;
  end;

implementation

end.
