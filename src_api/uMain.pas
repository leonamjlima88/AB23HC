unit uMain;

interface

Type
  TMain = class
    class procedure Start;
    class procedure InitializeSwagger;
    class procedure RunMigrations;
    class procedure RunServer;
    class procedure SetMiddlewares;
    class procedure SetReportMemoryLeak;
    class procedure SetRoutes;
    class procedure ClearTempFolder;
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
//  Horse.Exception.Logger,
  Horse.Etag,
  Horse.GBSwagger,
  Horse.OctetStream,
  GBSwagger.Model.Types,
  uResponse.DTO,
  System.DateUtils,
  System.IOUtils;

var
  LLogFileConfig: Shared<THorseLoggerConsoleConfig>;
const
  SERVER_PORT = 9123;
  SKIP_ROUTES_ON_AUTHENTICATION: TArray<String> = [
    '/ping',
    '/auth/login',
    '/swagger/doc/html',
    '/swagger/doc/json'
  ];

{ TMain }

class procedure TMain.Start;
begin
  SetReportMemoryLeak;
  InitializeSwagger;
  SetMiddlewares;
  RunMigrations;
  SetRoutes;
  ClearTempFolder;
  RunServer;
end;

class procedure TMain.ClearTempFolder;
var
  lTempPath: String;
begin
  lTempPath := ExtractFilePath(ParamStr(0)) + 'Temp\';
  if TDirectory.Exists(lTempPath) then
    TDirectory.Delete(lTempPath, True);
end;

class procedure TMain.InitializeSwagger;
begin
  Swagger
    .Info
      .Title('ab23hc')
      .Description('API AB23HC')
    .&End
    .Register
      .SchemaOnError(TResponseDTO)
    .&End
    .AddProtocol(TGBSwaggerProtocol.gbHttp)
    .AddProtocol(TGBSwaggerProtocol.gbHttps);
//    .AddBearerSecurity
//      .&Type(TGBSwaggerSecurityType.gbOAuth2)
//      .AddCallback(HorseJWT(
//      JWT_KEY,
//      THorseJWTConfig.New
//        .SessionClass(TMyClaims)
//        .SkipRoutes(SKIP_ROUTES_ON_AUTHENTICATION)
//    ));
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
  THorse.Listen(SERVER_PORT, procedure(Horse: THorse)
  begin
    Writeln(Format('Server is running on port: %d', [Horse.Port]));
    Readln;
  end);
end;

class procedure TMain.SetMiddlewares;
begin
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition    := TCaseNameDefinition.cndLower;
  TDataSetSerializeConfig.GetInstance.DateTimeIsISO8601     := False;
  TDataSetSerializeConfig.GetInstance.Export.FormatDateTime := 'yyyy-mm-dd"T"hh":"mm":"ss.000';
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
    .Use(Jhonson)
    .Use(ExceptionHandler)
    .Use(THorseLoggerManager.HorseCallback)
    .Use(THorseRateLimit.New())
    .Use(HorseJWT(
      JWT_KEY,
      THorseJWTConfig.New
        .SessionClass(TMyClaims)
        .SkipRoutes(SKIP_ROUTES_ON_AUTHENTICATION)
    ))
//    .Use(THorseExceptionLogger.New())
    .Use(Compression(0))
    .Use(HorseSwagger)
    .Use(eTag)
    .Use(Cors)
    .Use(HorseSwagger)
    .Use(OctetStream);
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
