unit uTenant.Show.DTO;

interface

uses
  GBSwagger.Model.Attributes,
  uResponse.DTO,
  uApplication.Types,
  System.Generics.Collections,
  uTenant.Base.DTO;

type
  TTenantShowDTO = class(TTenantBaseDTO)
  private
    Fupdated_at: TDateTime;
    Fcreated_at: TDateTime;
    Fcity_ibge_code: String;
    Fcity_name: String;
    Fid: Int64;
    Fcity_state: String;
  public
    [SwagNumber]
    [SwagProp('id', 'ID', true)]
    property id: Int64 read Fid write Fid;

    [SwagString(100)] {virtual}
    [SwagProp('city_name', 'Cidade', false)]
    property city_name: String read Fcity_name write Fcity_name;

    [SwagString(100)] {virtual}
    [SwagProp('city_state', 'Estado', false)]
    property city_state: String read Fcity_state write Fcity_state;

    [SwagString(100)] {virtual}
    [SwagProp('city_ibge_code', 'Código IBGE da Cidade', false)]
    property city_ibge_code: String read Fcity_ibge_code write Fcity_ibge_code;

    [SwagDate(DATETIME_DISPLAY_FORMAT)]
    [SwagProp('created_at', CREATED_AT_DISPLAY, true)]
    property created_at: TDateTime read Fcreated_at write Fcreated_at;

    [SwagDate(DATETIME_DISPLAY_FORMAT)]
    [SwagProp('updated_at', UPDATED_AT_DISPLAY)]
    property updated_at: TDateTime read Fupdated_at write Fupdated_at;
  end;

  {$REGION 'Swagger DOC'}
  TTenantShowResponseDTO = class(TResponseDTO)
  private
    Fdata: TTenantShowDTO;
  public
    property data: TTenantShowDTO read Fdata write Fdata;
  end;

  TTenantIndexDataResponseDTO = class
  private
    Fmeta: TResponseMetaDTO;
    Fresult: TObjectList<TTenantShowDTO>;
  public
    property result: TObjectList<TTenantShowDTO> read Fresult write Fresult;
    property meta: TResponseMetaDTO read Fmeta write Fmeta;
  end;

  TTenantIndexResponseDTO = class(TResponseDTO)
  private
    Fdata: TTenantIndexDataResponseDTO;
  public
    property data: TTenantIndexDataResponseDTO read Fdata write Fdata;
  end;
  {$ENDREGION}

implementation

end.
