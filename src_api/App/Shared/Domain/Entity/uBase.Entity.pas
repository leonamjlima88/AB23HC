unit uBase.Entity;

interface

uses
  uValidation.Interfaces;

type
  TBaseEntity = class abstract(TInterfacedObject, IValidation)
  public
    procedure Validate; virtual; abstract;
  end;

implementation

end.
