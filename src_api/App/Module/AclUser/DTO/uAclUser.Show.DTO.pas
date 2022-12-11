unit uAclUser.Show.DTO;

interface

uses
  GBSwagger.Model.Attributes,
  uResponse.DTO,
  System.Generics.Collections,
  uAclUser;

type
  /// <summary>
  ///   DTO para Criar/Atualizar registro
  /// </summary>
  TAclUserShowDTO = class
  private
    Fname: string;
    Flogin: string;
    Facl_role_id: Int64;
    Fis_superuser: SmallInt;
  public
    [SwagString(100)]
    [SwagProp('name', 'Nome', true)]
    property name: string read Fname write Fname;

    [SwagString(100)]
    [SwagProp('login', 'Login', true)]
    property login: string read Flogin write Flogin;

    [SwagNumber]
    [SwagProp('acl_role_id', 'Perfil ID', true)]
    property acl_role_id: Int64 read Facl_role_id write Facl_role_id;

    [SwagNumber]
    [SwagProp('is_superuser', 'Super usuário. [0=Falso,1=Verdadeiro]')]
    property is_superuser: SmallInt read Fis_superuser write Fis_superuser;

    class function FromEntity(AAclUser: TAclUser): TAclUserShowDTO;
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

uses
  XSuperObject;

{ TAclUserShowDTO }

class function TAclUserShowDTO.FromEntity(AAclUser: TAclUser): TAclUserShowDTO;
begin
  Result := TAclUserShowDTO.FromJSON(AAclUser.AsJSON);
end;

end.
