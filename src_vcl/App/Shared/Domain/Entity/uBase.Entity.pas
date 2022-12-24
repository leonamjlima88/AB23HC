unit uBase.Entity;

interface

type
  TBaseEntity = class abstract
  public
    function Validate: String; virtual; abstract;
  end;

implementation

end.
