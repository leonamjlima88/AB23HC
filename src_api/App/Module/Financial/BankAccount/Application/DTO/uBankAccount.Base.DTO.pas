unit uBankAccount.Base.DTO;

interface

uses
  GBSwagger.Model.Attributes;

type
  TBankAccountBaseDTO = class
  private
    Fname: string;
    Fnote: string;
    Fbank_id: Int64;
  public
    [SwagString(100)]
    [SwagProp('name', 'Nome', true)]
    property name: string read Fname write Fname;

    [SwagNumber]
    [SwagProp('bank_id', 'ID do banco', true)]
    property bank_id: Int64 read Fbank_id write Fbank_id;

    [SwagString]
    [SwagProp('note', 'Observação', false)]
    property note: string read Fnote write Fnote;
  end;

implementation

end.
