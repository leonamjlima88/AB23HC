unit uObservable;

interface

uses
  System.Generics.Collections,
  uObserver;

type
  TObservable = class
  private
    FObserverList: TObjectList<TObserver>;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    class function Make: TObservable;

    procedure &Register(AObserver: TObserver);
    procedure Notify(const AEvent: String; AInfo: String = ''; AObject: TObject = nil);
  end;

implementation

uses
  System.SysUtils,
  System.Classes;

{ TObservable }

constructor TObservable.Create;
begin
  inherited Create;
  FObserverList := TObjectList<TObserver>.Create;
end;

destructor TObservable.Destroy;
begin
  FObserverList.Free;
  inherited;
end;

class function TObservable.Make: TObservable;
begin
  Result := Self.Create;
end;

procedure TObservable.Notify(const AEvent: String; AInfo: String; AObject: TObject);
var
  lObserver: TObserver;
begin
  for lObserver in FObserverList do
  begin
    if (lObserver.Event.Trim.ToLower = AEvent.Trim.ToLower) then
      lObserver.Dispatch(AInfo, AObject);
  end;
end;

procedure TObservable.Register(AObserver: TObserver);
begin
  FObserverList.Add(AObserver);
end;

end.
