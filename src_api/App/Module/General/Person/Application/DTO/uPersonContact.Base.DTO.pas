unit uPersonContact.Base.DTO;

interface

uses
  GBSwagger.Model.Attributes;

type
  TPersonContactBaseDTO = class
  private
    Fname: string;
    Femail: string;
    Fphone: string;
    Fnote: string;
    Flegal_entity_number: string;
    Ftype: string;
    Fid: Int64;
  public
    [SwagNumber]
    [SwagProp('id', 'ID', false)]
    property id: Int64 read Fid write Fid;

    [SwagString(100)]
    [SwagProp('name', 'Nome do contato', true)]
    property name: string read Fname write Fname;

    [SwagString(20)]
    [SwagProp('legal_entity_number', 'CPF/CNPJ', false)]
    property legal_entity_number: string read Flegal_entity_number write Flegal_entity_number;

    [SwagString(100)]
    [SwagProp('type', 'Tipo de Contato', false)]
    property &type: string read Ftype write Ftype;

    [SwagString]
    [SwagProp('note', 'Observação', false)]
    property note: string read Fnote write Fnote;

    [SwagString(40)]
    [SwagProp('phone', 'Telefone', false)]
    property phone: string read Fphone write Fphone;

    [SwagString(255)]
    [SwagProp('email', 'E-mail', false)]
    property email: string read Femail write Femail;
  end;

implementation

end.
