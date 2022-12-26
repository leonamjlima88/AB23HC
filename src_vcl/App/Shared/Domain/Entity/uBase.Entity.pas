unit uBase.Entity;

interface

uses
  uObservable;

type
  TBaseEntity = class abstract(TObservable)
  public
    function  Validate: String; virtual; abstract;
    procedure Initialize; virtual; abstract;
  end;

implementation

end.
