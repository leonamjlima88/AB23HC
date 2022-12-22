unit uPaymentTerm.Mapper;

interface

uses
  uMapper.Interfaces,
  uPaymentTerm,
  uPaymentTerm.DTO,
  uPaymentTerm.Show.DTO;

type
  TPaymentTermMapper = class(TInterfacedObject, IMapper)
  public
    class function PaymentTermDtoToEntity(APaymentTermDTO: TPaymentTermDTO): TPaymentTerm;
    class function EntityToPaymentTermShowDto(APaymentTerm: TPaymentTerm): TPaymentTermShowDTO;
  end;

implementation

uses
  XSuperObject;

{ TPaymentTermMapper }

class function TPaymentTermMapper.EntityToPaymentTermShowDto(APaymentTerm: TPaymentTerm): TPaymentTermShowDTO;
var
  lPaymentTermShowDTO: TPaymentTermShowDTO;
begin
  // Mapear campos por JSON
  lPaymentTermShowDTO := TPaymentTermShowDTO.FromJSON(APaymentTerm.AsJSON);

  // Tratar campos específicos
  lPaymentTermShowDTO.bank_account_name        := APaymentTerm.bank_account.name;
  lPaymentTermShowDTO.document_name            := APaymentTerm.document.name;
  lPaymentTermShowDTO.created_by_acl_user_name := APaymentTerm.created_by_acl_user.name;
  lPaymentTermShowDTO.updated_by_acl_user_name := APaymentTerm.updated_by_acl_user.name;

  Result := lPaymentTermShowDTO;
end;

class function TPaymentTermMapper.PaymentTermDtoToEntity(APaymentTermDTO: TPaymentTermDTO): TPaymentTerm;
var
  lPaymentTerm: TPaymentTerm;
begin
  // Mapear campos por JSON
  lPaymentTerm := TPaymentTerm.FromJSON(APaymentTermDTO.AsJSON);

  // Tratar campos específicos
  // ...

  Result := lPaymentTerm;
end;

end.
