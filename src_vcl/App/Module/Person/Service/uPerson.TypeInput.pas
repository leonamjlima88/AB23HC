unit uPerson.TypeInput;

interface

type
  IPersonTypeInput = Interface
    ['{7CB05F34-C746-470E-B1BE-F96450CF816D}']
    function id: Int64; overload;
    function id(AValue: Int64): IPersonTypeInput; overload;

    function is_customer: Boolean; overload;
    function is_customer(AValue: Boolean): IPersonTypeInput; overload;

    function is_seller: Boolean; overload;
    function is_seller(AValue: Boolean): IPersonTypeInput; overload;

    function is_supplier: Boolean; overload;
    function is_supplier(AValue: Boolean): IPersonTypeInput; overload;

    function is_carrier: Boolean; overload;
    function is_carrier(AValue: Boolean): IPersonTypeInput; overload;

    function is_technician: Boolean; overload;
    function is_technician(AValue: Boolean): IPersonTypeInput; overload;

    function is_employee: Boolean; overload;
    function is_employee(AValue: Boolean): IPersonTypeInput; overload;

    function is_other: Boolean; overload;
    function is_other(AValue: Boolean): IPersonTypeInput; overload;

    function ToJsonString: String;
  end;

  TPersonTypeInput = class(TInterfacedObject, IPersonTypeInput)
  private
    Fid: Int64;
    Fis_customer: Boolean;
    Fis_seller: Boolean;
    Fis_supplier: Boolean;
    Fis_carrier: Boolean;
    Fis_technician: Boolean;
    Fis_employee: Boolean;
    Fis_other: Boolean;
  public
    function id: Int64; overload;
    function id(AValue: Int64): IPersonTypeInput; overload;

    function is_customer: Boolean; overload;
    function is_customer(AValue: Boolean): IPersonTypeInput; overload;

    function is_seller: Boolean; overload;
    function is_seller(AValue: Boolean): IPersonTypeInput; overload;

    function is_supplier: Boolean; overload;
    function is_supplier(AValue: Boolean): IPersonTypeInput; overload;

    function is_carrier: Boolean; overload;
    function is_carrier(AValue: Boolean): IPersonTypeInput; overload;

    function is_technician: Boolean; overload;
    function is_technician(AValue: Boolean): IPersonTypeInput; overload;

    function is_employee: Boolean; overload;
    function is_employee(AValue: Boolean): IPersonTypeInput; overload;

    function is_other: Boolean; overload;
    function is_other(AValue: Boolean): IPersonTypeInput; overload;

    class function Make: TPersonTypeInput;
    function ToJsonString: String;
  end;

implementation

{ TPersonTypeInput }

uses
  XSuperObject, uHlp;

function TPersonTypeInput.id: Int64;
begin
  Result := Fid;
end;

function TPersonTypeInput.id(AValue: Int64): IPersonTypeInput;
begin
  Result := Self;
  Fid := AValue;
end;

function TPersonTypeInput.is_carrier(AValue: Boolean): IPersonTypeInput;
begin
  Result := Self;
  Fis_carrier := AValue;
end;

function TPersonTypeInput.is_carrier: Boolean;
begin
  Result := Fis_carrier;
end;

function TPersonTypeInput.is_customer: Boolean;
begin
  Result := Fis_customer;
end;

function TPersonTypeInput.is_customer(AValue: Boolean): IPersonTypeInput;
begin
  Result := Self;
  Fis_customer := AValue;
end;

function TPersonTypeInput.is_employee: Boolean;
begin
  Result := Fis_employee;
end;

function TPersonTypeInput.is_employee(AValue: Boolean): IPersonTypeInput;
begin
  Result := Self;
  Fis_employee := AValue;
end;

function TPersonTypeInput.is_other: Boolean;
begin
  Result := Fis_other;
end;

function TPersonTypeInput.is_other(AValue: Boolean): IPersonTypeInput;
begin
  Result := Self;
  Fis_other := AValue;
end;

function TPersonTypeInput.is_seller(AValue: Boolean): IPersonTypeInput;
begin
  Result := Self;
  Fis_seller := AValue;
end;

function TPersonTypeInput.is_seller: Boolean;
begin
  Result := Fis_seller;
end;

function TPersonTypeInput.is_supplier(AValue: Boolean): IPersonTypeInput;
begin
  Result := Self;
  Fis_supplier := AValue;
end;

function TPersonTypeInput.is_supplier: Boolean;
begin
  Result := Fis_supplier;
end;

function TPersonTypeInput.is_technician(AValue: Boolean): IPersonTypeInput;
begin
  Result := Self;
  Fis_technician := AValue;
end;

function TPersonTypeInput.is_technician: Boolean;
begin
  Result := Fis_technician;
end;

class function TPersonTypeInput.Make: TPersonTypeInput;
begin
  Result := Self.Create;
end;

function TPersonTypeInput.ToJsonString: String;
var
  lSObj: ISuperObject;
begin
  lSObj := SO;
  lSObj.I['id']            := Fid;
  lSObj.I['is_customer']   := THlp.BollInt(Fis_customer);
  lSObj.I['is_seller']     := THlp.BollInt(Fis_seller);
  lSObj.I['is_supplier']   := THlp.BollInt(Fis_supplier);
  lSObj.I['is_carrier']    := THlp.BollInt(Fis_carrier);
  lSObj.I['is_technician'] := THlp.BollInt(Fis_technician);
  lSObj.I['is_employee']   := THlp.BollInt(Fis_employee);
  lSObj.I['is_other']      := THlp.BollInt(Fis_other);

  Result := lSObj.AsJSON;
end;

end.
