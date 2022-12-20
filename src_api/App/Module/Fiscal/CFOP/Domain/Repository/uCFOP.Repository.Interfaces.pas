unit uCFOP.Repository.Interfaces;

interface

uses
  uBase.Repository.Interfaces,
  uCFOP;

type
  ICFOPRepository = interface(IBaseRepository)
    ['{5F60781D-F039-4FAC-9CD1-0D4A60B0EF27}']
    function Show(AId: Int64): TCFOP;
  end;

implementation

end.


