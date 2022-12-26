unit uSession.DTM;

interface

uses
  System.SysUtils,
  System.Classes, System.ImageList, Vcl.ImgList, Vcl.Controls;

type
  TSessionDTM = class(TDataModule)
    imgListGrid: TImageList;
  public
  end;

var
  SessionDTM: TSessionDTM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TSessionDTM }

end.
