unit uDocument.Mapper;

interface

uses
  uMapper.Interfaces,
  uDocument,
  uDocument.DTO,
  uDocument.Show.DTO;

type
  TDocumentMapper = class(TInterfacedObject, IMapper)
  public
    class function DocumentDtoToEntity(ADocumentDTO: TDocumentDTO): TDocument;
    class function EntityToDocumentShowDto(ADocument: TDocument): TDocumentShowDTO;
  end;

implementation

uses
  XSuperObject,
  System.SysUtils,
  uApplication.Types;

{ TDocumentMapper }

class function TDocumentMapper.EntityToDocumentShowDto(ADocument: TDocument): TDocumentShowDTO;
var
  lDocumentShowDTO: TDocumentShowDTO;
begin
  if not Assigned(ADocument) then
    raise Exception.Create(RECORD_NOT_FOUND);

  // Mapear campos por JSON
  lDocumentShowDTO := TDocumentShowDTO.FromJSON(ADocument.AsJSON);

  // Tratar campos específicos
  lDocumentShowDTO.created_by_acl_user_name := ADocument.created_by_acl_user.name;
  lDocumentShowDTO.updated_by_acl_user_name := ADocument.updated_by_acl_user.name;

  Result := lDocumentShowDTO;
end;

class function TDocumentMapper.DocumentDtoToEntity(ADocumentDTO: TDocumentDTO): TDocument;
var
  lDocument: TDocument;
begin
  // Mapear campos por JSON
  lDocument := TDocument.FromJSON(ADocumentDTO.AsJSON);

  // Tratar campos específicos
  // ...

  Result := lDocument;
end;

end.
