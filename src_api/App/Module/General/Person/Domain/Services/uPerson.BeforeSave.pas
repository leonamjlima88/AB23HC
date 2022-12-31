unit uPerson.BeforeSave;

interface

uses
  uPerson,
  uApplication.Types,
  uPersonContact;

type
  IPersonBeforeSave = Interface
    ['{E64A2020-4DFC-43A6-BBA9-6AF226E52466}']
    function Execute: IPersonBeforeSave;
  end;

  TPersonBeforeSave = class(TInterfacedObject, IPersonBeforeSave)
  private
    FEntity: TPerson;
    FState: TEntityState;
    constructor Create(AEntity: TPerson; AStateEnum: TEntityState);
    function HandleAttributes: IPersonBeforeSave;
    function HandlePerson: IPersonBeforeSave;
    function HandlePersonContact(AEntity: TPersonContact): IPersonBeforeSave;
    function HandlePersonContactList: IPersonBeforeSave;
  public
    class function Make(AEntity: TPerson; AStateEnum: TEntityState): IPersonBeforeSave;
    function Execute: IPersonBeforeSave;
  end;

implementation

uses
  uHlp,
  System.SysUtils;

{ TPersonBeforeSave }

constructor TPersonBeforeSave.Create(AEntity: TPerson; AStateEnum: TEntityState);
begin
  inherited Create;
  FEntity := AEntity;
  FState  := AStateEnum;
end;

function TPersonBeforeSave.Execute: IPersonBeforeSave;
begin
  Result := Self;
  HandleAttributes;
end;

function TPersonBeforeSave.HandleAttributes: IPersonBeforeSave;
begin
  Result := Self;
  HandlePerson;
  HandlePersonContactList;
end;

function TPersonBeforeSave.HandlePerson: IPersonBeforeSave;
var
  lIsJuridica: Boolean;
begin
  if FEntity.alias_name.Trim.IsEmpty then
    FEntity.alias_name := FEntity.name;

  FEntity.zipcode := THlp.RemoveDots(FEntity.zipcode);
  FEntity.phone_1 := THlp.RemoveDots(FEntity.phone_1);
  FEntity.phone_2 := THlp.RemoveDots(FEntity.phone_2);
  FEntity.phone_3 := THlp.RemoveDots(FEntity.phone_3);

  // Contribuinte de ICMS
  lIsJuridica := (FEntity.legal_entity_number.Value.Length = 14);
  case lIsJuridica of
    True: Begin
      case (FEntity.state_registration.Trim > EmptyStr) of
        True:  FEntity.icms_taxpayer := 1;
        False: FEntity.icms_taxpayer := 2;
      end;
    end;
    False: Begin
      case (FEntity.state_registration.Trim > EmptyStr) of
        True:  FEntity.icms_taxpayer := 1;
        False: FEntity.icms_taxpayer := 0;
      end;
    end;
  end;
  FEntity.icms_taxpayer := 0;
end;

function TPersonBeforeSave.HandlePersonContact(AEntity: TPersonContact): IPersonBeforeSave;
begin
  AEntity.phone := THlp.RemoveDots(AEntity.phone);
end;

function TPersonBeforeSave.HandlePersonContactList: IPersonBeforeSave;
var
  lPersonContact: TPersonContact;
begin
  for lPersonContact in FEntity.person_contact_list do
    HandlePersonContact(lPersonContact);
end;

class function TPersonBeforeSave.Make(AEntity: TPerson; AStateEnum: TEntityState): IPersonBeforeSave;
begin
  Result := Self.Create(AEntity, AStateEnum);
end;

end.

