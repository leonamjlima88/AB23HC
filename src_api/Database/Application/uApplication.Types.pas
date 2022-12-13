unit uApplication.Types;

interface

type
  TConnectionType =        (ctDefault, ctFireDAC, ctZEOS, ctUnidac, ctOthers);
  TRepositoryType =        (rtDefault, rtSQL, rtMemory, rtORMBr, rtDORM, rtAurelius, rtDac, rtOthers);
  TDriverDB =              (ddDefault, ddMySql, ddFirebird, ddPG, ddMsql, ddOthers);
  TState =                 (esNone, esStore, esUpdate);
  TReportExecutionStatus = (resNone, resPreview, resGeneratePdf, resPrintOut);
  TPageCode =              (pcNone, pc437, pc850, pc852, pc860, pcUTF8, pc1252);


implementation

end.
