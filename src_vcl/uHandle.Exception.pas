unit uHandle.Exception;

interface

uses
  System.SysUtils,
  System.Classes;

type
  THandleException = class
  private
    FSender: TObject;
    FException: Exception;
    FHandleMessage: TStringList;
    function GetWindowsUser: string;
    function GetWindowsVersion: string;
    function WriteLog: THandleException;
    function ShowMessageForUser: THandleException;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Execute(Sender: TObject; E: Exception);
    function  HandleMessage: THandleException;

    class function TranslateToLayMessage(ATechnicalMessage: String): String;
  end;

implementation

uses
  Vcl.Forms,
  Vcl.Dialogs,
  System.Types,
  Winapi.Windows;

CONST
  SERVER_HAS_GONE_AWAY = 'server has gone away';
  UNKNOWN_MYSQL_SERVER_HOST = 'unknown mysql server host';
  ERROR_IN_SQL_SYNTAX = 'you have an error in your sql syntax';
  ERROR_IN_SQL_FK_FAILS = 'cannot delete or update a parent row: a foreign key constraint fails';
  ERROR_IN_SQL_FK_NOT_EXISTS = 'cannot add or update a child row: a foreign key constraint fails';

{ TExecuteException }

constructor THandleException.Create;
begin
  FHandleMessage := TStringList.Create;
  Application.OnException := Execute;
end;

destructor THandleException.Destroy;
begin
  if Assigned(FHandleMessage) then
    FreeAndNil(FHandleMessage);

  inherited;
end;

procedure THandleException.Execute(Sender: TObject; E: Exception);
begin
  FSender := Sender;
  FException := E;

  HandleMessage;
  WriteLog;
  ShowMessageForUser;
end;

function THandleException.ShowMessageForUser: THandleException;
var
  lStrList: TStringList;
begin
  Result := Self;

  // Exibir mensagem para o usuário
  lStrList := TStringList.Create;
  try
    lStrList.Add('Oops... Ocorreu um erro!');
    lStrList.AddStrings(FHandleMessage);
    lStrList.Add(EmptyStr);
    lStrList.Add('Se não souber como proceder, entre em contato com o administrador do sistema.');

    MessageDlg(lStrList.Text, mtWarning, [mbOK], 0);
  finally
    lStrList.Free;
  end;
end;

class function THandleException.TranslateToLayMessage(ATechnicalMessage: String): String;
begin
  Result := EmptyStr;
  ATechnicalMessage := ATechnicalMessage.ToLower.Trim;

  if (Pos(SERVER_HAS_GONE_AWAY, ATechnicalMessage) > 0) or (Pos(UNKNOWN_MYSQL_SERVER_HOST, ATechnicalMessage) > 0) then
    Result := 'A conexão de rede falhou. Verifique as configurações de rede e internet.';

  if (Pos(ERROR_IN_SQL_SYNTAX, ATechnicalMessage) > 0) Then
    Result := 'Erro de sintaxe SQL.';

  if (Pos(ERROR_IN_SQL_FK_FAILS, ATechnicalMessage) > 0) Then
    Result := 'Você não pode deletar um registro que está em uso em outras tabelas do sistema.';

  if (Pos(ERROR_IN_SQL_FK_NOT_EXISTS, ATechnicalMessage) > 0) Then
    Result := 'Você não pode vincular uma chave que não existe na tabela do banco de dados.';

  // Order sql por coluna não encontrada
  if (Pos('unknown column', ATechnicalMessage) > 0) and (Pos('order clause', ATechnicalMessage) > 0) then
    Result := 'Não é possível ordenar por esta coluna.';

  // Coluna não pode ser nula
  if (Pos('column', ATechnicalMessage) > 0) and (Pos('cannot be null', ATechnicalMessage) > 0) then
    Result := 'Coluna não pode ser nula.';
end;

function THandleException.WriteLog: THandleException;
var
  lPathLogFile: string;
  lLogFile: TextFile;
begin
  Result := Self;

  // Inicializar arquivo
  lPathLogFile := GetCurrentDir + '\error_log_'+FormatDateTime('YYYY_mm', now)+'.txt';
  AssignFile(lLogFile, lPathLogFile);
  case FileExists(lPathLogFile) of
    True:  Append(lLogFile);
    False: ReWrite(lLogFile);
  end;

  // Escreve os dados no arquivo
  WriteLn(lLogFile, 'Date/Time.........: ' + DateTimeToStr(Now));
  WriteLn(lLogFile, 'Message...........: ' + FHandleMessage.Text);
  WriteLn(lLogFile, 'Classe Exception..: ' + FException.ClassName);
  WriteLn(lLogFile, 'Form..............: ' + Screen.ActiveForm.Name);
  WriteLn(lLogFile, 'Unit..............: ' + FSender.UnitName);
  WriteLn(lLogFile, 'Visual Control....: ' + Screen.ActiveControl.Name);
  WriteLn(lLogFile, 'Windows User......: ' + GetWindowsUser);
  WriteLn(lLogFile, 'Windows Version...: ' + GetWindowsVersion);
  WriteLn(lLogFile, StringOfChar('-', 70));

  // Fecha o arquivo
  CloseFile(lLogFile);
end;

function THandleException.GetWindowsUser: string;
var
  Size: DWord;
begin
  // retorna o login do usuário do sistema operacional
  Size := 1024;
  SetLength(result, Size);
  GetUserName(PChar(result), Size);
  SetLength(result, Size - 1);
end;

function THandleException.GetWindowsVersion: string;
begin
  case System.SysUtils.Win32MajorVersion of
    5:
      case System.SysUtils.Win32MinorVersion of
        1: result := 'Windows XP';
      end;
    6:
      case System.SysUtils.Win32MinorVersion of
        0: result := 'Windows Vista';
        1: result := 'Windows 7';
        2: result := 'Windows 8';
        3: result := 'Windows 8.1';
      end;
    10:
      case System.SysUtils.Win32MinorVersion of
        0: result := 'Windows 10';
      end;
  end;
end;

function THandleException.HandleMessage: THandleException;
var
  lLayMessage: String;
begin
  Result := Self;
  FHandleMessage.Clear;

  // Mesagem Leiga
  lLayMessage := TranslateToLayMessage(FException.Message.Trim.ToLower);
  if not lLayMessage.IsEmpty then
    FHandleMessage.Add(lLayMessage);

  // Mesagem Técnica
  FHandleMessage.Add('');
  FHandleMessage.Add('Mensagem técnica:');
  FHandleMessage.Add(FException.Message + '['+FException.ClassName+']');
end;

var
  AppException: THandleException;

initialization
  AppException := THandleException.Create;

finalization
  AppException.Free;

end.
