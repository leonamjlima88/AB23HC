unit uPerson.Mapper;

interface

uses
  uMapper.Interfaces,
  uPerson,
  uPerson.DTO,
  uPerson.Show.DTO;

type
  TPersonMapper = class(TInterfacedObject, IMapper)
  public
    class function PersonDtoToEntity(APersonDTO: TPersonDTO): TPerson;
    class function EntityToPersonShowDto(APerson: TPerson): TPersonShowDTO;
  end;

implementation

uses
  uPersonContact,
  XSuperObject,
  uLegalEntityNumber.VO;

{ TPersonMapper }

class function TPersonMapper.EntityToPersonShowDto(APerson: TPerson): TPersonShowDTO;
var
  lPersonShowDTO: TPersonShowDTO;
  lI: Integer;
begin
  // Mapear campos por JSON
  lPersonShowDTO := TPersonShowDTO.FromJSON(APerson.AsJSON);

  // Tratar campos específicos
  lPersonShowDTO.legal_entity_number      := APerson.legal_entity_number.Value;
  lPersonShowDTO.city_name                := APerson.city.name;
  lPersonShowDTO.city_state               := APerson.city.state;
  lPersonShowDTO.city_ibge_code           := APerson.city.ibge_code;
  lPersonShowDTO.created_by_acl_user_name := APerson.created_by_acl_user.name;
  lPersonShowDTO.updated_by_acl_user_name := APerson.updated_by_acl_user.name;

  for lI := 0 to Pred(lPersonShowDTO.person_contact_list.Count) do
    lPersonShowDTO.person_contact_list.Items[lI].legal_entity_number := APerson.person_contact_list.Items[lI].legal_entity_number.Value;

  Result := lPersonShowDTO;
end;

class function TPersonMapper.PersonDtoToEntity(APersonDTO: TPersonDTO): TPerson;
var
  lPerson: TPerson;
  lI: Integer;
begin
  // Mapear campos por JSON
  lPerson := TPerson.FromJSON(APersonDTO.AsJSON);

  // Tratar campos específicos
  lPerson.legal_entity_number := TLegalEntityNumberVO.Make(APersonDTO.legal_entity_number);
  for lI := 0 to Pred(lPerson.person_contact_list.Count) do
    lPerson.person_contact_list.Items[lI].legal_entity_number := TLegalEntityNumberVO.Make(APersonDTO.person_contact_list.Items[lI].legal_entity_number);

  Result := lPerson;
end;

end.
