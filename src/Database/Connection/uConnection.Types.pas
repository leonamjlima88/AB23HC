unit uConnection.Types;

interface

type
  TConnLibType    = (ctDefault, ctFireDAC, ctZEOS, ctUnidac, ctOthers);
  TRepositoryType = (rtDefault, rtSQL, rtMemory, rtDORM, rtAurelius, rtDac, rtOthers);
  TDriverDB =       (ddDefault, ddMySql, ddFirebird, ddPG, ddMsql, ddOthers);

implementation

end.
