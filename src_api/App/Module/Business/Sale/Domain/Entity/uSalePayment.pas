unit uSalePayment;

interface

uses
  uBase.Entity,
  uBankAccount,
  uDocument;

type
  TSalePayment = class(TBaseEntity)
  private
    Fbank_account_id: Int64;
    Fdocument_id: Int64;
    Fid: Int64;
    Fnote: String;
    Famount: Double;
    Fexpiration_date: TDate;
    Fsale_id: Int64;

    // OneToOne
    Fbank_account: TBankAccount;
    Fdocument: TDocument;

    procedure Initialize;
  public
    constructor Create; overload;
    destructor Destroy; override;

    property id: Int64 read Fid write Fid;
    property sale_id: Int64 read Fsale_id write Fsale_id;
    property bank_account_id: Int64 read Fbank_account_id write Fbank_account_id;
    property document_id: Int64 read Fdocument_id write Fdocument_id;
    property expiration_date: TDate read Fexpiration_date write Fexpiration_date;
    property amount: Double read Famount write Famount;
    property note: String read Fnote write Fnote;

    // OneToOne
    property bank_account: TBankAccount read Fbank_account write Fbank_account;
    property document: TDocument read Fdocument write Fdocument;

    procedure Validate; override;
  end;

implementation

uses
  System.SysUtils,
  uHlp,
  uApplication.Types;

{ TSalePayment }

constructor TSalePayment.Create;
begin
  inherited Create;
  Initialize;
end;

destructor TSalePayment.Destroy;
begin
  if Assigned(Fbank_account) then Fbank_account.Free;
  if Assigned(Fdocument)     then Fdocument.Free;
  inherited;
end;

procedure TSalePayment.Initialize;
begin
  Fbank_account := TBankAccount.Create;
  Fdocument     := TDocument.Create;
end;

procedure TSalePayment.Validate;
begin
  if (Fbank_account_id <= 0) then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['sale_item.bank_account_id']));

  if (Fdocument_id <= 0) then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['sale_item.document_id']));

  if (Fexpiration_date <= 0) then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['sale_item.expiration_date']));
end;

end.
