unit uTest.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,

  uBrand.Service;

type
  TTestView = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    edtStoreName: TEdit;
    Button2: TButton;
    edtShowId: TEdit;
    Button3: TButton;
    edtUpdateId: TEdit;
    edtUpdateName: TEdit;
    Button4: TButton;
    edtDeleteId: TEdit;
    Button5: TButton;
    FDMemTable1: TFDMemTable;
    FDMemTable1id: TLargeintField;
    FDMemTable1name: TStringField;
    FDMemTable1created_at: TDateTimeField;
    FDMemTable1updated_at: TDateTimeField;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FService: IBrandService;
  public
    { Public declarations }
  end;

var
  TestView: TTestView;

implementation

uses
  uSmartPointer,
  uBrand,
  uEither,
  uObserver;

{$R *.dfm}

procedure TTestView.Button1Click(Sender: TObject);
var
  lBrandToStore: Shared<TBrand>;
  lBrandStored: Shared<TBrand>;
  lStoreResult: Either<String, TBrand>;
begin
  lBrandToStore := TBrand.Create;
  lBrandToStore.Value.name := edtStoreName.Text;

  lStoreResult := FService.Store(lBrandToStore);
  if not lStoreResult.Match then
  Begin
    Memo1.Clear;
    Memo1.Lines.Add('Não foi possível incluir registro.');
    Memo1.Lines.Add(lStoreResult.Left);
    Abort;
  end;
  lBrandStored := lStoreResult.Right;

  Memo1.Clear;
  Memo1.Lines.Add(lBrandStored.Value.id.ToString);
  Memo1.Lines.Add(lBrandStored.Value.name);
end;

procedure TTestView.Button2Click(Sender: TObject);
var
  lBrandFound: Shared<TBrand>;
begin
  lBrandFound := FService.Show(StrToIntDef(edtShowId.Text,0));
  if not Assigned(lBrandFound.Value) then
  begin
    Memo1.Clear;
    Memo1.Lines.Add('Registro não encontrado.');
    Exit;
  end;

  Memo1.Clear;
  Memo1.Lines.Add('id: '                     + lBrandFound.Value.id.ToString);
  Memo1.Lines.Add('name: '                   + lBrandFound.Value.name);
  Memo1.Lines.Add('created_at: '             + DateTimeToStr(lBrandFound.Value.created_at));
  Memo1.Lines.Add('updated_at: '             + DateTimeToStr(lBrandFound.Value.updated_at));
  Memo1.Lines.Add('created_by_acl_user_id: ' + lBrandFound.Value.created_by_acl_user_id.ToString);
  Memo1.Lines.Add('updated_by_acl_user_id: ' + lBrandFound.Value.updated_by_acl_user_id.ToString);
end;

procedure TTestView.Button3Click(Sender: TObject);
var
  lBrandToUpdate: Shared<TBrand>;
  lBrandUpdated: Shared<TBrand>;
  lUpdateResult: Either<String, TBrand>;
begin
  lBrandToUpdate := TBrand.Create;
  lBrandToUpdate.Value.name := edtUpdateName.Text;

  // Atualizar
  lUpdateResult := FService.Update(lBrandToUpdate, StrToIntDef(edtUpdateId.Text,0));
  if not lUpdateResult.Match then
  begin
    Memo1.Clear;
    Memo1.Lines.Add('Não foi possível atualizar registro.');
    Memo1.Lines.Add(lUpdateResult.Left);
    Abort;
  end;
  lBrandUpdated := lUpdateResult.Right;

  Memo1.Clear;
  Memo1.Lines.Add(lBrandUpdated.Value.id.ToString);
  Memo1.Lines.Add(lBrandUpdated.Value.name);
end;

procedure TTestView.Button4Click(Sender: TObject);
begin
  FService.Delete(StrToIntDef(edtDeleteId.Text,0));

  Memo1.Clear;
  Memo1.Lines.Add('Apagou');
end;

procedure TTestView.Button5Click(Sender: TObject);
begin
  Memo1.Clear;
  With FService.Index.DataSet do
  begin
    First;
    while not Eof do
    begin
      Memo1.Lines.Add(
        FieldByName('id').AsString + ' | ' +
        FieldByName('name').AsString + ' | ' +
        FieldByName('created_at').AsString + ' | ' +
        FieldByName('updated_at').AsString
      );

      Next;
    end;
  end;
end;

procedure TTestView.FormCreate(Sender: TObject);
begin
  FService := TBrandService.Make;
end;

end.
