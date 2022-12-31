unit uBank.Mapper;

interface

uses
  uMapper.Interfaces,
  uBank,
  uBank.DTO,
  uBank.Show.DTO;

type
  TBankMapper = class(TInterfacedObject, IMapper)
  public
    class function BankDtoToEntity(ABankDTO: TBankDTO): TBank;
    class function EntityToBankShowDto(ABank: TBank): TBankShowDTO;
  end;

implementation

uses
  XSuperObject,
  System.SysUtils,
  uApplication.Types;

{ TBankMapper }

class function TBankMapper.EntityToBankShowDto(ABank: TBank): TBankShowDTO;
var
  lBankShowDTO: TBankShowDTO;
begin
  if not Assigned(ABank) then
    raise Exception.Create(RECORD_NOT_FOUND);

  // Mapear campos por JSON
  lBankShowDTO := TBankShowDTO.FromJSON(ABank.AsJSON);

  // Tratar campos específicos
  lBankShowDTO.created_by_acl_user_name := ABank.created_by_acl_user.name;
  lBankShowDTO.updated_by_acl_user_name := ABank.updated_by_acl_user.name;

  Result := lBankShowDTO;
end;

class function TBankMapper.BankDtoToEntity(ABankDTO: TBankDTO): TBank;
var
  lBank: TBank;
begin
  // Mapear campos por JSON
  lBank := TBank.FromJSON(ABankDTO.AsJSON);

  // Tratar campos específicos
  // ...

  Result := lBank;
end;

end.
