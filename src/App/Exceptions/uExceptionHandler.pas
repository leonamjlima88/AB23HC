unit uExceptionHandler;

{$IF DEFINED(FPC)}
{$MODE DELPHI}{$H+}
{$ENDIF}

interface

uses
  {$IF DEFINED(FPC)}
  SysUtils,
  {$ELSE}
  System.SysUtils,
  {$ENDIF}
  Horse, Horse.Commons;

CONST
  SERVER_HAS_GONE_AWAY = 'server has gone away';
  UNKNOWN_MYSQL_SERVER_HOST = 'unknown mysql server host';
  ERROR_IN_SQL_SYNTAX = 'you have an error in your sql syntax';
  ERROR_IN_SQL_FK_FAILS = 'cannot delete or update a parent row: a foreign key constraint fails';
  ERROR_IN_SQL_FK_NOT_EXISTS = 'cannot add or update a child row: a foreign key constraint fails';
  ERROR_IN_SQL_UNIQUE_FAILS = 'duplicate entry';

procedure ExceptionHandler(Req: THorseRequest; Res: THorseResponse; Next: {$IF DEFINED(FPC)}TNextProc{$ELSE}TProc{$ENDIF});

implementation

uses
  {$IF DEFINED(FPC)}
  fpjson, TypInfo;
  {$ELSE}
  System.JSON, System.TypInfo, uRes, uApplication.Types;
  {$ENDIF}

procedure SendError(ARes:THorseResponse; AJson: TJSONObject; AStatus: Integer);
begin
  ARes.Send<TJSONObject>(AJson).Status(AStatus);
end;

procedure ExceptionHandler(Req: THorseRequest; Res: THorseResponse; Next: {$IF DEFINED(FPC)}TNextProc{$ELSE}TProc{$ENDIF});
var
  LJSON: TJSONObject;
  lEMessage: String;
begin
  try
    Next();
  except
    on E: EHorseCallbackInterrupted do
      raise;
    on E: EHorseException do
    begin
      LJSON := TJSONObject.Create;
      LJSON.{$IF DEFINED(FPC)}Add{$ELSE}AddPair{$ENDIF}('error', E.Error);
      if not E.Title.Trim.IsEmpty then
      begin
        LJSON.{$IF DEFINED(FPC)}Add{$ELSE}AddPair{$ENDIF}('title', E.Title);
      end;
      if not E.&Unit.Trim.IsEmpty then
      begin
        LJSON.{$IF DEFINED(FPC)}Add{$ELSE}AddPair{$ENDIF}('unit', E.&Unit);
      end;
      if E.Code <> 0 then
      begin
        LJSON.{$IF DEFINED(FPC)}Add{$ELSE}AddPair{$ENDIF}('code', {$IF DEFINED(FPC)}TJSONIntegerNumber{$ELSE}TJSONNumber{$ENDIF}.Create(E.Code));
      end;
      if E.&Type <> TMessageType.Default then
      begin
        LJSON.{$IF DEFINED(FPC)}Add{$ELSE}AddPair{$ENDIF}('type', GetEnumName(TypeInfo(TMessageType), Integer(E.&Type)));
      end;
      SendError(Res, LJSON, E.Code);
    end;
    on E: Exception do
    begin
      lEMessage := E.Message;
      if (Pos(SERVER_HAS_GONE_AWAY, lEMessage.ToLower) > 0) or (Pos(UNKNOWN_MYSQL_SERVER_HOST, lEMessage.ToLower) > 0) then
        lEMessage := 'A conexão de rede falhou. Verifique as configurações de rede e internet.';

      if (Pos(ERROR_IN_SQL_SYNTAX, lEMessage.ToLower) > 0) Then
        lEMessage := 'Erro de sintaxe SQL.';

      if (Pos(ERROR_IN_SQL_FK_FAILS, lEMessage.ToLower) > 0) Then
        lEMessage := 'Você não pode deletar um registro que está sendo utilizado em outras tabelas do sistema.';

      if (Pos(ERROR_IN_SQL_FK_NOT_EXISTS, lEMessage.ToLower) > 0) Then
        lEMessage := 'Você não pode vincular uma chave que não existe na tabela do banco de dados.';

      if (Pos(ERROR_IN_SQL_UNIQUE_FAILS, lEMessage.ToLower) > 0) Then
        lEMessage := 'Entrada duplicada. Valor não pode repetir na tabela do banco de dados. Mensagem Técnica: ' + lEMessage + '.';

      TRes.Error(Res, Format('%s %s[%s]', [lEMessage, E.ClassName, UNCATEGORIZED_EXCEPTION]), EmptyStr, HTTP_INTERNAL_SERVER_ERROR);
    end;
  end;
end;

end.
