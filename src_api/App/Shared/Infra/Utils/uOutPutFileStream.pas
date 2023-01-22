unit uOutPutFileStream;

interface

uses
  System.Classes;

type
  IOutPutFileStream = Interface
    ['{8D787C12-A148-4CE0-AEF1-5086A0F52C80}']
    function Stream: TFileStream;
    function FileName: String;
    function ContentType: String;
  end;

  TOutPutFileStream = class(TInterfacedObject, IOutPutFileStream)
  private
    FStream: TFileStream;
    FFileName: String;
    constructor Create(APathFile: String);
  public
    destructor Destroy; override;
    class function Make(APathFile: String): IOutPutFileStream;

    function Stream: TFileStream;
    function FileName: String;
    function ContentType: String;
  end;

implementation

uses
  System.SysUtils;

{ TOutPutFileStream }

function TOutPutFileStream.ContentType: String;
var
  lExt: String;
begin
  lExt := ExtractFileExt(FFileName);
  if (lExt = '.pdf') then Result := 'application/pdf';
end;

constructor TOutPutFileStream.Create(APathFile: String);
begin
  inherited Create;
  FStream   := TFileStream.Create(APathFile, fmOpenRead);
  FFileName := APathFile;
end;

destructor TOutPutFileStream.Destroy;
begin
  if Assigned(FStream) then FStream.Free;

  inherited;
end;

function TOutPutFileStream.FileName: String;
begin
  Result := FFileName;
end;

class function TOutPutFileStream.Make(APathFile: String): IOutPutFileStream;
begin
  Result := Self.Create(APathFile);
end;

function TOutPutFileStream.Stream: TFileStream;
begin
  Result := FStream;
end;

end.
