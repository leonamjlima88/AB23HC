unit uTaskScheduler;

interface

uses
  Quick.Commons,
  Quick.Console,
  Quick.Threads;

type
  TTaskScheduler = class
  private
    FScheduledTasks: TScheduledTasks;
    procedure SetUp;
    procedure SetTasks;
  public
    constructor Create;
    destructor Destroy; override;
  end;

var
  TaskScheduler: TTaskScheduler;

implementation

uses
  System.SysUtils,
  uAutomaticPingInConsole.Task;

{ TTaskScheduler }
constructor TTaskScheduler.Create;
begin
  FScheduledTasks                           := TScheduledTasks.Create;
  FScheduledTasks.RemoveTaskAfterExpiration := True;
  FScheduledTasks.FaultPolicy.MaxRetries    := 5;
  SetUp;
end;

destructor TTaskScheduler.Destroy;
begin
  FScheduledTasks.Free;
  inherited;
end;

procedure TTaskScheduler.SetTasks;
begin
  TAutomaticPingInConsoleTask.HangOn(FScheduledTasks);
end;

procedure TTaskScheduler.SetUp;
begin
  SetTasks;
  FScheduledTasks.Start;
end;

initialization
  TaskScheduler := TTaskScheduler.Create;

finalization
  FreeAndNil(TaskScheduler);
end.

