unit uDocument.Repository.Interfaces;

interface

uses
  uBase.Repository.Interfaces,
  uDocument;

type
  IDocumentRepository = interface(IBaseRepository)
    ['{36F5F5B2-1DAD-4285-B832-AD9D430C6AF2}']
    function Show(AId: Int64): TDocument;
  end;

implementation

end.


