unit uAclUser.Show.DTO;

interface

uses
  GBSwagger.Model.Attributes,
  uResponse.DTO,
  System.Generics.Collections,
  uAclUser.Base.DTO;

type
  TAclUserShowDTO = class(TAclUserBaseDTO)
  end;

  {$REGION 'Swagger DOC'}
  TAclUserShowResponseDTO = class(TResponseDTO)
  private
    Fdata: TAclUserShowDTO;
  public
    property data: TAclUserShowDTO read Fdata write Fdata;
  end;

  TAclUserIndexDataResponseDTO = class
  private
    Fmeta: TResponseMetaDTO;
    Fresult: TObjectList<TAclUserShowDTO>;
  public
    property result: TObjectList<TAclUserShowDTO> read Fresult write Fresult;
    property meta: TResponseMetaDTO read Fmeta write Fmeta;
  end;

  TAclUserIndexResponseDTO = class(TResponseDTO)
  private
    Fdata: TAclUserIndexDataResponseDTO;
  public
    property data: TAclUserIndexDataResponseDTO read Fdata write Fdata;
  end;
  {$ENDREGION}

implementation

end.
