unit uApplication.Types;

interface

type
  TEntityState = (esNone, esStore, esUpdate);

const
  // Nunca alterar essas chaves a menos que seja muito necessário.
  // Se for alterar, precisa gerar novamente todos os campos que são criptografados no banco de dados com a nova chave.
  ENCRYPTATION_KEY = '{A676CF7D-4755-400D-8E83-0753D4CEA08F}';
  JWT_KEY          = '{D2011AB9-7D15-4068-B7CB-014954657F9E}';

  HTTP_OK = 200; // Sucesso e retorna conteudo
  HTTP_CREATED = 201; // Incluiu Novo Registro
  HTTP_NO_CONTENT = 204; // Sucesso e não retorna conteúdo
  HTTP_BAD_REQUEST = 400; // Erro rastreável
  HTTP_NOT_FOUND = 404; // Não encontrado HTTP_NOT_FOUND
  HTTP_INTERNAL_SERVER_ERROR = 500; // Erro não rastreável
  OOPS_MESSAGE = 'Oops. Algum erro aconteceu!';
  SUCCESS_MESSAGE = 'Operação realizada com sucesso.';
  VALIDATION_ERROR = 'Falha na validação dos dados';
  RECORD_NOT_FOUND_WITH_ID = 'Registro não encontrado com ID: %d';
  DELIMITED_CHAR = ';';
  UNCATEGORIZED_EXCEPTION = 'Uncategorized Exception';
  SELECT_LAST_INSERT_ID_MYSQL = 'SELECT last_insert_id() as id';

implementation

end.
