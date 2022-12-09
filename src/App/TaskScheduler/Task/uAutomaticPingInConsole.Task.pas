unit uAutomaticPingInConsole.Task;

interface

uses
  Quick.Threads;

type
  TAutomaticPingInConsoleTask = class
  public
    class procedure HangOn(const AScheduledTasks: TScheduledTasks);
  end;

implementation

uses
  System.SysUtils,
  System.DateUtils,
  Quick.Commons,
  Quick.Console;

const
  TASK_NAME                 = 'Automatic ping in console';
  MAX_RETRY                 = 10;
  WAIT_TIME_BETWEEN_RETRIES = 100;
  REPEAT_INTERVAL           = 30;
  REPEAT_TIME_MEASURE       = TTimeMeasure.tmMinutes;

{ TUpdateConsoleCommand }

class procedure TAutomaticPingInConsoleTask.HangOn(const AScheduledTasks: TScheduledTasks);
var
  lStartAt: TDateTime;
begin
  lStartAt := IncMinute(Now, 1);

  AScheduledTasks.AddTask(TASK_NAME, [], True, procedure(task : ITask)
    begin
      cout('Task: "%s" started', [TASK_NAME], etDebug);
    end)
    .WaitAndRetry(MAX_RETRY, WAIT_TIME_BETWEEN_RETRIES)
    .OnException(procedure(task: ITask; aException: Exception)
    begin
      cout('Task: "%s" failed (%s)',[TASK_NAME, aException.Message], etError);
    end)
    .OnRetry(procedure(task : ITask; aException : Exception;  var vStopRetries : Boolean)
    begin
      if not aException.Message.Contains('Division by zero') then vStopRetries := True
        else cout('Task: "%s" retried %d/%d (%s)',[TASK_NAME, task.NumRetries, task.MaxRetries, aException.Message], etWarning);
    end)
    .OnTerminated(procedure(task: ITask)
    begin
      //Task: "Automatic ping in console" at 2022-12-08 as 16:36:00 finished
      cout('Task: "%s" at %s finished', [TASK_NAME, DateTimeToStr(Now)], etDebug);
    end)
    .OnExpired(procedure(task: ITask)
    begin
      cout('Task: "%s" expired', [TASK_NAME], etWarning);
    end)
    .StartAt(lStartAt)
    .RepeatEvery(REPEAT_INTERVAL, REPEAT_TIME_MEASURE);
end;

end.
