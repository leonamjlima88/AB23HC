unit uBase.Entity;

interface

uses
  uObservable;

type
  TBaseEntity = class abstract(TObservable)
  public
    function Validate: String; virtual; abstract;
  end;

implementation

end.
