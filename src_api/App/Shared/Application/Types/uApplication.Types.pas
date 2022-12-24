unit uApplication.Types;

interface

type
  TEntityState = (esNone, esStore, esUpdate);

const
  // Nunca alterar essas chaves a menos que seja muito necessário.
  // Se for alterar, precisa gerar novamente todos os campos que são criptografados no banco de dados com a nova chave.
  {TODO -oOwner -cGeneral :Mover essas chaves para arquivo privado.}
  ENCRYPTATION_KEY       = '{A676CF7D-4755-400D-8E83-0753D4CEA08F}';
  LOGIN_PASSWORD_DEFAULT = '123Mudar@';
  JWT_KEY                = '{D2011AB9-7D15-4068-B7CB-014954657F9E}';

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
  FIELD_WAS_NOT_INFORMED = 'O campo %s não foi informado.';
  FIELD_WITH_VALUE_IS_INVALID = 'O campo %s com o conteúdo %s é inválido.';
  FIELD_WITH_VALUE_IS_IN_USE = 'O campo %s com o valor %s já está em uso.';
  FIELD_VALUE_MUST_CONTAIN_A_MAXIMUM_OF_CHARACTERS = 'O campo %s deve conter no máximo %d caractere(s).';
  FIELD_VALUE_MUST_CONTAIN_EXACTLY_CHARACTERS = 'O campo %s deve conter %d caractere(s).';
  DATETIME_DISPLAY_FORMAT = 'YYYY-MM-DDTHH:MM:SS.sTZ';
  CREATED_AT_DISPLAY = 'Data e hora de criação';
  CREATED_BY_ACL_USER_ID = 'Criado por usuário (id)';
  CREATED_BY_ACL_USER_NAME = 'Criado por usuário (nome)';
  UPDATED_AT_DISPLAY = 'Data e hora de alteração';
  UPDATED_BY_ACL_USER_ID = 'Alterado por usuário (id)';
  UPDATED_BY_ACL_USER_NAME = 'Alterado por usuário (nome)';

implementation

end.
