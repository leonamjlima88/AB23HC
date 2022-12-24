program vcl;

uses
  Vcl.Forms,
  System.UITypes,
  uAclUser in 'App\Module\AclUser\Domain\Entity\uAclUser.pas',
  uAclRole in 'App\Module\AclRole\Domain\Entity\uAclRole.pas',
  uBase.Entity in 'App\Shared\Domain\Entity\uBase.Entity.pas',
  uSession.DTM in 'Config\Infra\uSession.DTM.pas' {SessionDTM: TDataModule},
  uMain.View in 'uMain.View.pas' {MainView},
  uLogin.View in 'App\Module\AclUser\Presentation\uLogin.View.pas' {LoginView},
  uUserLogged in 'uUserLogged.pas',
  uEnv in 'uEnv.pas',
  uHlp in 'uHlp.pas',
  uBase.CreateUpdate.View in 'uBase.CreateUpdate.View.pas' {BaseCreateUpdateView},
  uBase.Index.View in 'uBase.Index.View.pas' {BaseIndexView},
  uNotificationView in 'uNotificationView.pas' {NotificationView},
  uBrand.Index.View in 'uBrand.Index.View.pas' {BrandIndexView},
  uMemTable.Factory in 'uMemTable.Factory.pas',
  uTest.View in 'uTest.View.pas' {TestView},
  uBrand in 'uBrand.pas',
  uHandle.Exception in 'uHandle.Exception.pas',
  uBrand.Service in 'uBrand.Service.pas',
  uReq in 'uReq.pas',
  uEither in 'uEither.pas',
  uObservable in 'uObservable.pas',
  uObserver in 'uObserver.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TSessionDTM, SessionDTM);
  Application.CreateForm(TMainView, MainView);
  Application.CreateForm(TNotificationView, NotificationView);
  Application.Run;
end.
