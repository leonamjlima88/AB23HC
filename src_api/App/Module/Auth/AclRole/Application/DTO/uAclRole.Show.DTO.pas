unit uAclRole.Show.DTO;

interface

uses
  GBSwagger.Model.Attributes,
  uResponse.DTO,
  uApplication.Types,
  System.Generics.Collections;

type
  TAclRoleShowDTO = class
  private
    Fid: Int64;
    Fname: String;
  public
    [SwagNumber]
    [SwagProp('id', 'ID', true)]
    property id: Int64 read Fid write Fid;

    [SwagString]
    [SwagProp('name', 'Nome', true)]
    property name: String read Fname write Fname;
  end;

  {$REGION 'Swagger DOC'}
  TAclRoleShowResponseDTO = class(TResponseDTO)
  private
    Fdata: TAclRoleShowDTO;
  public
    property data: TAclRoleShowDTO read Fdata write Fdata;
  end;

  TAclRoleIndexDataResponseDTO = class
  private
    Fmeta: TResponseMetaDTO;
    Fresult: TObjectList<TAclRoleShowDTO>;
  public
    property result: TObjectList<TAclRoleShowDTO> read Fresult write Fresult;
    property meta: TResponseMetaDTO read Fmeta write Fmeta;
  end;

  TAclRoleIndexResponseDTO = class(TResponseDTO)
  private
    Fdata: TAclRoleIndexDataResponseDTO;
  public
    property data: TAclRoleIndexDataResponseDTO read Fdata write Fdata;
  end;
  {$ENDREGION}

implementation

end.
