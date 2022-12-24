unit uMainView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids,

  RESTRequest4D,
  DataSet.Serialize,
  XSuperObject;

type
  TMainView = class(TForm)
    Button1: TButton;
    DBGrid1: TDBGrid;
    FDMemTable1: TFDMemTable;
    DataSource1: TDataSource;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainView: TMainView;

implementation

{$R *.dfm}

procedure TMainView.Button1Click(Sender: TObject);
var
  LResponse: IResponse;
  lToken: String;
  lSObj: ISuperObject;
begin
  lToken := 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJuYW1lIjoiYWRtIiwibG9naW4iOiJhZG0iLCJhY2xfcm9sZV9pZCI6IjEiLCJpc19zdXBlcnVzZXIiOiIwIiwiZXhwIjoxNjcwNjgxNzU2fQ.UIcnK67n2zWEFcUlaR9Ojr1wzIVJ2C1wiiSj-050Hfk';

  LResponse := TRequest.New.BaseURL('http://localhost:9123/brand')
    .AddHeader('Accept', 'application/json')
    .AddHeader('Content-Type', 'application/json')
    .AddHeader('If-None-Match-Type', 'etag')
    .Accept('application/json')
    .TokenBearer(lToken)
//    .DataSetAdapter(FDMemTable1)
    .Get;

  if not (LResponse.StatusCode = 200) then
    Exit;


  lSObj := SO(LResponse.Content);
  FDMemTable1.LoadFromJSON(lSObj.O['data'].A['result'].AsJSON(true));
end;

end.
