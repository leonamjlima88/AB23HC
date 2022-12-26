unit uApplication.Types;

interface

type
  TEntityState = (esNone, esStore, esUpdate, esView);

const
  HTTP_OK = 200; // Sucesso e retorna conteudo
  HTTP_CREATED = 201; // Incluiu Novo Registro
  HTTP_NO_CONTENT = 204; // Sucesso e n�o retorna conte�do
  HTTP_NOT_MODIFIED = 304; // N�o houve altera��o desde a ultima requisi��o (Uso do ETAG)
  HTTP_BAD_REQUEST = 400; // Erro rastre�vel
  HTTP_NOT_FOUND = 404; // N�o encontrado HTTP_NOT_FOUND
  HTTP_INTERNAL_SERVER_ERROR = 500; // Erro n�o rastre�vel
  IF_NONE_MATCH = 'If-None-Match';
  OOPS_MESSAGE = 'Oops. Algum erro aconteceu!';
  SUCCESS_MESSAGE = 'Opera��o realizada com sucesso.';
  VALIDATION_ERROR = 'Falha na valida��o dos dados';
  YOUR_APP_HAS_BEEN_MINIMIZED = 'Sua aplica��o foi minimizada!';
  DELETED_RECORD = 'Registro deletado com sucesso!';
  RECORD_DELETION_FAILED = 'Exclus�o de registro falhou!';
  DO_YOU_WANT_TO_DELETE_SELECTED_RECORD = 'Deseja apagar registro selecionado?';
  EXCLUSION = 'Exclus�o';

implementation

end.

