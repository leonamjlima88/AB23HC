unit uMain;

interface

Type
  TMain = class
    class procedure Start;
    class procedure RunMigrations;
    class procedure RunServer;
    class procedure SetMiddlewares;
    class procedure SetReportMemoryLeak;
    class procedure SetRoutes;
  end;

implementation

uses
  System.Classes,
  System.SysUtils,
  uSmartPointer,
  uMigration.Manager,
  uConnection.Factory,
  DataSet.Serialize,
  uApplication.Types,
  uMyClaims,
  uExceptionHandler,
  uRouteApi,
  Horse,
  Horse.RateLimit,
  Horse.JWT,
  Horse.Compression,
  Horse.Jhonson,
  Horse.Cors,
  Horse.Logger,
  Horse.Logger.Provider.Console,
  Horse.Logger.Manager,
  Horse.Exception.Logger,
  Horse.Etag;

var
  LLogFileConfig: Shared<THorseLoggerConsoleConfig>;
  lSkipRoutes: TArray<String>;
const
  SKIP_ROUTES_ON_AUTHENTICATION: TArray<String> = ['/ping', '/auth/login'];

{ TMain }

class procedure TMain.Start;
begin
  SetReportMemoryLeak;
  SetMiddlewares;
  RunMigrations;
  SetRoutes;
  RunServer;
end;

class procedure TMain.RunMigrations;
var
  lStrList: IShared<TStringList>;
begin
  try
    TMigrationManager.Make(TConnectionFactory.Make).Execute;
  except on E: Exception do
    Begin
      // Exibir mensagem para o usuário
      lStrList := Shared<TStringList>.Make;
      lStrList.Add('Oops... Ocorreu um erro!');
      lStrList.Add('Falha na execução das migrações.');
      lStrList.Add(EmptyStr);
      lStrList.Add('Mensagem Técnica: ' + E.Message + ' - ' + E.ClassName);
      lStrList.Add(EmptyStr);
      lStrList.Add('Se não souber como proceder, entre em contato com o administrador do sistema.');
      Writeln(lStrList.Text);
      Readln;

      // Encerrar Aplicação
      System.Halt;
      Exit;
    end;
  end;
end;

class procedure TMain.RunServer;
begin
  // Executar Servidor
  THorse.Listen(9123, procedure(Horse: THorse)
  begin
    Writeln(Format('Server is running on port: %d', [Horse.Port]));
    Readln;
  end);
end;

class procedure TMain.SetMiddlewares;
begin
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := TCaseNameDefinition.cndLower;
  LLogFileConfig := THorseLoggerConsoleConfig.New.SetLogFormat('${request_clientip} [${time}] ${response_status}');
  THorseLoggerManager.RegisterProvider(THorseLoggerProviderConsole.New());

  // Configuração do CORS
  HorseCORS
    .AllowedOrigin('*')
    .AllowedCredentials(true)
    .AllowedHeaders('*')
    .AllowedMethods('*')
    .ExposedHeaders('*');

  THorse
    .Use(THorseLoggerManager.HorseCallback)
    .Use(THorseRateLimit.New())
    .AddCallback(HorseJWT(JWT_KEY, THorseJWTConfig.New.SessionClass(TMyClaims).SkipRoutes(SKIP_ROUTES_ON_AUTHENTICATION)))
    .Use(HorseJWT(JWT_KEY, THorseJWTConfig.New.SkipRoutes(SKIP_ROUTES_ON_AUTHENTICATION)))
    .Use(Compression(0))
    .Use(Jhonson)
    .Use(eTag)
    .Use(Cors)
    .Use(ExceptionHandler)
    .Use(THorseExceptionLogger.New());
end;

class procedure TMain.SetReportMemoryLeak;
begin
  // Reportar MemoryLeak, necessário digitar STOP no console para ver memoryLeaks
  if (DebugHook <> 0) then
  begin
    IsConsole := False;
    ReportMemoryLeaksOnShutdown := true;
  end;
end;

class procedure TMain.SetRoutes;
begin
  TRouteApi.Registry;
end;

end.
