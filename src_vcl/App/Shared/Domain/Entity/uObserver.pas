unit uObserver;

interface

uses
  System.SysUtils,
  System.Classes;

type
  TObserverCallBack = reference to procedure(AInfo: String; AObject: TObject);

  TObserver = class
  private
    FEvent: String;
    FCallBack: TObserverCallBack;
    constructor Create(const AEvent: String; const ACallBack: TObserverCallBack);
  public
    class function Make(const AEvent: String; const ACallBack: TObserverCallBack): TObserver;

    function  Event: String;
    procedure Dispatch(AInfo: String; AObject: TObject);
  end;

implementation

{ TObserver }

constructor TObserver.Create(const AEvent: String; const ACallBack: TObserverCallBack);
begin
  inherited Create;
  FEvent    := AEvent;
  FCallBack := ACallBack;
end;

function TObserver.Event: String;
begin
  Result := FEvent;
end;

class function TObserver.Make(const AEvent: String; const ACallBack: TObserverCallBack): TObserver;
begin
  Result := Self.Create(AEvent, ACallBack);
end;

procedure TObserver.Dispatch(AInfo: String; AObject: TObject);
begin
  FCallBack(AInfo, AObject);
end;

end.
