unit uPersonContact.DTO;

interface

uses
  GBSwagger.Model.Attributes;

type
  TPersonContactDTO = class
  private
    Fname: string;
    Femail: string;
    Fphone: string;
    Fnote: string;
    Fein: string;
    Ftype: string;
  public
    [SwagString(100)]
    [SwagProp('name', 'Nome do contato', true)]
    property name: string read Fname write Fname;

    [SwagString(20)]
    [SwagProp('ein', 'CPF/CNPJ', false)]
    property ein: string read Fein write Fein;

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
