program vcl;

uses
  Vcl.Forms,
  System.UITypes,
  uNotificationView in 'App\Shared\Presentation\uNotificationView.pas' {NotificationView},
  uYesOrNo.View in 'App\Shared\Presentation\uYesOrNo.View.pas' {YesOrNoView},
  uAlert.View in 'App\Shared\Presentation\uAlert.View.pas' {AlertView},
  uBrand.CreateUpdate.View in 'App\Module\Brand\Presentation\uBrand.CreateUpdate.View.pas',
  uBrand.Index.View in 'App\Module\Brand\Presentation\uBrand.Index.View.pas',
  uMain.View in 'App\Shared\Presentation\uMain.View.pas' {MainView},
  uBase.CreateUpdate.View in 'App\Shared\Presentation\uBase.CreateUpdate.View.pas' {BaseCreateUpdateView},
  uBase.Index.View in 'App\Shared\Presentation\uBase.Index.View.pas' {BaseIndexView},
  uBrand.Service in 'App\Module\Brand\Domain\Service\uBrand.Service.pas',
  uApplication.Types in 'App\Shared\Infra\uApplication.Types.pas',
  uLogin.View in 'App\Module\AclUser\Presentation\uLogin.View.pas' {LoginView},
  uBase.Entity in 'App\Shared\Domain\Entity\uBase.Entity.pas',
  uIndexResult in 'App\Shared\Infra\uIndexResult.pas',
  uHandle.Exception in 'App\Shared\Infra\uHandle.Exception.pas',
  uSession.DTM in 'Config\Infra\uSession.DTM.pas' {SessionDTM: TDataModule},
  uPageFilter in 'App\Shared\Infra\uPageFilter.pas',
  uReq in 'App\Shared\Infra\uReq.pas',
  uHlp in 'App\Shared\Infra\uHlp.pas',
  uObservable in 'App\Shared\Domain\Entity\uObservable.pas',
  uObserver in 'App\Shared\Domain\Entity\uObserver.pas',
  uMemTable.Factory in 'App\Shared\Infra\uMemTable.Factory.pas',
  uEnv in 'App\Shared\Infra\uEnv.pas',
  uUserLogged in 'App\Module\AclUser\Domain\Entity\uUserLogged.pas',
  uAclUser in 'App\Module\AclUser\Domain\Entity\uAclUser.pas',
  uAclRole in 'App\Module\AclRole\Domain\Entity\uAclRole.pas',
  uEither in 'App\Shared\Infra\uEither.pas',
  uSearchColumns in 'App\Shared\Infra\uSearchColumns.pas',
  uBrand.DataSet in 'App\Module\Brand\Domain\Entity\uBrand.DataSet.pas',
  uPerson.Index.View in 'App\Module\Person\Presentation\uPerson.Index.View.pas' {PersonIndexView},
  uPerson.Service in 'App\Module\Person\Domain\Service\uPerson.Service.pas',
  uPerson.CreateUpdate.View in 'App\Module\Person\Presentation\uPerson.CreateUpdate.View.pas' {PersonCreateUpdateView},
  uPerson.MemTable in 'App\Module\Person\Domain\Entity\uPerson.MemTable.pas',
  uPersonContact.CreateUpdate.View in 'App\Module\Person\Presentation\uPersonContact.CreateUpdate.View.pas' {PersonContactCreateUpdateView},
  uEntity.MemTable.Interfaces in 'App\Shared\Domain\Entity\uEntity.MemTable.Interfaces.pas';

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
