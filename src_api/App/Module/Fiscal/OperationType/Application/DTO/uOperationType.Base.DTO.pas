unit uOperationType.Base.DTO;

interface

uses
  GBSwagger.Model.Attributes;

type
  TOperationTypeBaseDTO = class
  private
    Fname: string;
    Fissue_purpose: SmallInt;
    Fdocument_type: SmallInt;
    Foperation_nature_description: String;
  public
    [SwagString(100)]
    [SwagProp('name', 'Nome', true)]
    property name: string read Fname write Fname;

    [SwagNumber]
    [SwagProp('document_type', 'Tipo de documento', false)]
    property document_type: SmallInt read Fdocument_type write Fdocument_type;

    [SwagNumber]
    [SwagProp('issue_purpose', 'Propósito de emissão', false)]
    property issue_purpose: SmallInt read Fissue_purpose write Fissue_purpose;

    [SwagNumber]
    [SwagProp('operation_nature_description', 'Descrição da natureza de operação', true)]
    property operation_nature_description: String read Foperation_nature_description write Foperation_nature_description;
  end;

implementation

end.
