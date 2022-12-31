unit uChartOfAccount.Mapper;

interface

uses
  uMapper.Interfaces,
  uChartOfAccount,
  uChartOfAccount.DTO,
  uChartOfAccount.Show.DTO;

type
  TChartOfAccountMapper = class(TInterfacedObject, IMapper)
  public
    class function ChartOfAccountDtoToEntity(AChartOfAccountDTO: TChartOfAccountDTO): TChartOfAccount;
    class function EntityToChartOfAccountShowDto(AChartOfAccount: TChartOfAccount): TChartOfAccountShowDTO;
  end;

implementation

uses
  XSuperObject,
  System.SysUtils,
  uApplication.Types;

{ TChartOfAccountMapper }

class function TChartOfAccountMapper.EntityToChartOfAccountShowDto(AChartOfAccount: TChartOfAccount): TChartOfAccountShowDTO;
var
  lChartOfAccountShowDTO: TChartOfAccountShowDTO;
begin
  if not Assigned(AChartOfAccount) then
    raise Exception.Create(RECORD_NOT_FOUND);

  // Mapear campos por JSON
  lChartOfAccountShowDTO := TChartOfAccountShowDTO.FromJSON(AChartOfAccount.AsJSON);

  // Tratar campos específicos
  lChartOfAccountShowDTO.created_by_acl_user_name := AChartOfAccount.created_by_acl_user.name;
  lChartOfAccountShowDTO.updated_by_acl_user_name := AChartOfAccount.updated_by_acl_user.name;

  Result := lChartOfAccountShowDTO;
end;

class function TChartOfAccountMapper.ChartOfAccountDtoToEntity(AChartOfAccountDTO: TChartOfAccountDTO): TChartOfAccount;
var
  lChartOfAccount: TChartOfAccount;
begin
  // Mapear campos por JSON
  lChartOfAccount := TChartOfAccount.FromJSON(AChartOfAccountDTO.AsJSON);

  // Tratar campos específicos
  // ...

  Result := lChartOfAccount;
end;

end.
