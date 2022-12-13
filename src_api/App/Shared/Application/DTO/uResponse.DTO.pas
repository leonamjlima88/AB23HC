unit uResponse.DTO;

interface

uses
  GBSwagger.Model.Attributes;

type
  TResponseDTO = class
  private
    Fcode: SmallInt;
    Fmessage: String;
    Ferror: Boolean;
    Fdata: TObject;
  public
    [SwagClass]
    [SwagProp('data', 'Dados do retorno')]
    property data: TObject read Fdata write Fdata;

    [SwagNumber]
    [SwagProp('code', 'Status de retorno')]
    property code: SmallInt read Fcode write Fcode;

    [SwagPositive]
    [SwagProp('error', 'Sinalizador de erro [True, False]')]
    property error: Boolean read Ferror write Ferror;

    [SwagString]
    [SwagProp('message', 'Mensagem referente ao retorno')]
    property &message: String read Fmessage write Fmessage;
  end;

  TResponseMetaDTO = class
  private
    Fnav_last: Boolean;
    Fall_pages_record_count: SmallInt;
    Fnav_prior: Boolean;
    Flimit_per_page: SmallInt;
    Fcurrent_page: SmallInt;
    Fnav_first: Boolean;
    Fcurrent_page_record_count: SmallInt;
    Fnav_next: Boolean;
    Flast_page_number: SmallInt;
  public
    [SwagNumber]
    [SwagProp('current_page', 'Página solicitada')]
    property current_page: SmallInt read Fcurrent_page write Fcurrent_page;

    [SwagNumber]
    [SwagProp('current_page_record_count', 'Total de registros da Página solicitada')]
    property current_page_record_count: SmallInt read Fcurrent_page_record_count write Fcurrent_page_record_count;

    [SwagNumber]
    [SwagProp('last_page_number', 'Número da última página')]
		property last_page_number: SmallInt read Flast_page_number write Flast_page_number;

    [SwagNumber]
    [SwagProp('all_pages_record_count', 'Total de registros de todas as páginas')]
		property all_pages_record_count: SmallInt read Fall_pages_record_count write Fall_pages_record_count;

    [SwagNumber]
    [SwagProp('limit_per_page', 'Limite de registros por página')]
    property limit_per_page: SmallInt read Flimit_per_page write Flimit_per_page;

    [SwagPositive]
    [SwagProp('nav_prior', 'Ir para a página anterior')]
    property nav_prior: Boolean read Fnav_prior write Fnav_prior;

    [SwagPositive]
    [SwagProp('nav_next', 'Ir para a próxima página')]
    property nav_next: Boolean read Fnav_next write Fnav_next;

    [SwagPositive]
    [SwagProp('nav_first', 'Ir para a primeira página')]
    property nav_first: Boolean read Fnav_first write Fnav_first;

    [SwagPositive]
    [SwagProp('nav_last', 'Ir para a última página')]
    property nav_last: Boolean read Fnav_last write Fnav_last;
  end;

  TRequestPageDTO = class
  private
    Fcurrent: SmallInt;
    Flimit: SmallInt;
    Fcolumns: String;
  public
    [SwagNumber]
    [SwagProp('limit', 'Limite de registros por página')]
    property limit: SmallInt read Flimit write Flimit;

    [SwagNumber]
    [SwagProp('current', 'Página setada/atual')]
    property current: SmallInt read Fcurrent write Fcurrent;

    [SwagString]
    [SwagProp('columns', 'Colunas a serem exibidas no retorno. Exemplo: "table.id, table.name"')]
    property columns: String read Fcolumns write Fcolumns;
  end;

  TOperatorValues = (None, Equal, Greater, Less, GreaterOrEqual, LessOrEqual, Different, LikeInitial, LikeFinal, LikeAnywhere, LikeEqual);
  TRequestFilterWhereDTO = class
  private
    Ffield_name: string;
    Foperator: TOperatorValues;
    Ffield_value: string;
  public
    [SwagString]
    [SwagProp('field_name', 'Nome do campo. Exemplo: "tablename.name"')]
    property field_name: string read Ffield_name write Ffield_name;
    [SwagString]
    [SwagProp('operator', 'Operador de condição. Exemplo: "LikeAnywhere"')]
    property &operator: TOperatorValues read Foperator write Foperator;
    [SwagString]
    [SwagProp('field_value', 'Conteúdo do campo para filtragem')]
    property field_value: string read Ffield_value write Ffield_value;
  end;

  TRequestFilterDTO = class
  private
    Fwhere: TRequestFilterWhereDTO;
    Forder_by: string;
    For_where: TRequestFilterWhereDTO;
  public
    [SwagString]
    [SwagProp('order_by', 'Ordenar resultado. Exemplo: "tablename.name asc"')]
    property order_by: string read Forder_by write Forder_by;
    [SwagProp('where', 'Condições de filtragem em modo "where"')]
    property where: TRequestFilterWhereDTO read Fwhere write Fwhere;
    [SwagProp('or_where', 'Condições de filtragem em modo "or where"')]
    property or_where: TRequestFilterWhereDTO read For_where write For_where;
  end;

  TRequestPageFilterDTO = class
  private
    Ffilter: TRequestFilterDTO;
    Fpage: TRequestPageDTO;
  public
    property page: TRequestPageDTO read Fpage write Fpage;
    property filter: TRequestFilterDTO read Ffilter write Ffilter;
  end;


implementation

end.
