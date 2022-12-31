unit uAppParam.Show.DTO;

interface

uses
  GBSwagger.Model.Attributes,
  uResponse.DTO,
  uApplication.Types,
  System.Generics.Collections,
  uAppParam.Base.DTO;

type
  TAppParamShowDTO = class(TAppParamBaseDTO)
  private
  public
  end;

  {$REGION 'Swagger DOC'}
  TAppParamShowResponseDTO = class(TResponseDTO)
  private
    Fdata: TAppParamShowDTO;
  public
    property data: TAppParamShowDTO read Fdata write Fdata;
  end;

  TAppParamIndexDataResponseDTO = class
  private
    Fmeta: TResponseMetaDTO;
    Fresult: TObjectList<TAppParamShowDTO>;
  public
    property result: TObjectList<TAppParamShowDTO> read Fresult write Fresult;
    property meta: TResponseMetaDTO read Fmeta write Fmeta;
  end;

  TAppParamIndexResponseDTO = class(TResponseDTO)
  private
    Fdata: TAppParamIndexDataResponseDTO;
  public
    property data: TAppParamIndexDataResponseDTO read Fdata write Fdata;
  end;
  {$ENDREGION}

implementation

end.
