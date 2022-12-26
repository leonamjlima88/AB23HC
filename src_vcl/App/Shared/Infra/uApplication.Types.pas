unit uApplication.Types;

interface

type
  TEntityState = (esNone, esStore, esUpdate, esView);

const
  HTTP_OK = 200; // Sucesso e retorna conteudo
  HTTP_CREATED = 201; // Incluiu Novo Registro
  HTTP_NO_CONTENT = 204; // Sucesso e não retorna conteúdo
  HTTP_NOT_MODIFIED = 304; // Não houve alteração desde a ultima requisição (Uso do ETAG)
  HTTP_BAD_REQUEST = 400; // Erro rastreável
  HTTP_NOT_FOUND = 404; // Não encontrado HTTP_NOT_FOUND
  HTTP_INTERNAL_SERVER_ERROR = 500; // Erro não rastreável
  IF_NONE_MATCH = 'If-None-Match';
  OOPS_MESSAGE = 'Oops. Algum erro aconteceu!';
  SUCCESS_MESSAGE = 'Operação realizada com sucesso.';
  VALIDATION_ERROR = 'Falha na validação dos dados';
  YOUR_APP_HAS_BEEN_MINIMIZED = 'Sua aplicação foi minimizada!';
  DELETED_RECORD = 'Registro deletado com sucesso!';
  RECORD_DELETION_FAILED = 'Exclusão de registro falhou!';
  DO_YOU_WANT_TO_DELETE_SELECTED_RECORD = 'Deseja apagar registro selecionado?';
  EXCLUSION = 'Exclusão';

implementation

end.

