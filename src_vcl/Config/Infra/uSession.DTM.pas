unit uSession.DTM;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, Vcl.ImgList, Vcl.Controls,
  FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Stan.Intf, FireDAC.Comp.UI;

type
  TSessionDTM = class(TDataModule)
    imgListGrid: TImageList;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure ClearTempFolder;
  public
  end;

var
  SessionDTM: TSessionDTM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  System.IOUtils,
  uApplication.Types;

{$R *.dfm}

{ TSessionDTM }

procedure TSessionDTM.DataModuleCreate(Sender: TObject);
begin
  ClearTempFolder;
end;

procedure TSessionDTM.ClearTempFolder;
var
  lTempPath: String;
begin
  lTempPath := ExtractFilePath(ParamStr(0)) + TEMP_FOLDER;
  if TDirectory.Exists(lTempPath) then
    TDirectory.Delete(lTempPath, True);

  // Criar Diretorio se não existir
  if not TDirectory.Exists(lTempPath) then
    TDirectory.CreateDirectory(lTempPath);
end;

end.
