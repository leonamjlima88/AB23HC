unit uHlp;

interface

uses
  Data.DB,
  System.Classes,
  Winapi.Windows,
  Winapi.WinInet,
  Vcl.Forms;

type
  THlp = class
  public
    class function  InternetIsConnected: Boolean;
    class function  DayOfWeekStr(Data:TDateTime): string;
    class function  GetPcName: string; // Obter nome do computador
    class function  CreateTransparentBackground(AOwner: TForm; AlphaBlendValue: Integer = 200): TForm;
  end;

implementation

uses
  System.SysUtils,
  System.Dateutils,
  System.MaskUtils,
  System.Variants,
  Vcl.Graphics;

{ THlp }

class function THlp.CreateTransparentBackground(AOwner: TForm; AlphaBlendValue: Integer): TForm;
begin
  // Configurar Fundo Transparente
  Result := TForm.Create(AOwner);
  Result.AlphaBlend      := True;
  Result.AlphaBlendValue := AlphaBlendValue;
  Result.Color           := clBlack;
  Result.BorderStyle     := bsNone;
  Result.Enabled         := False;
  Result.Top             := 0;
  Result.Left            := 0;
  Result.Width           := GetSystemMetrics(SM_CXSCREEN) - (GetSystemMetrics(SM_CXSCREEN) - GetSystemMetrics(SM_CXFULLSCREEN)) + 1;
  Result.Height          := GetSystemMetrics(SM_CYSCREEN) - (GetSystemMetrics(SM_CYSCREEN) - GetSystemMetrics(SM_CYFULLSCREEN)) + GetSystemMetrics(SM_CYCAPTION) + 1;
  Result.Show;

  // Trazer form para frente - Evitar Erro
  Result.BringToFront;
  AOwner.BringToFront;
  Application.ProcessMessages;
end;

class function THlp.DayOfWeekStr(Data: TDateTime): string;
begin
  case DayOfWeek(Data) of
    1: Result := 'Domingo';
    2: Result := 'Segunda';
    3: Result := 'Terça';
    4: Result := 'Quarta';
    5: Result := 'Quinta';
    6: Result := 'Sexta';
    7: Result := 'Sábado';
  end;
end;

class function THlp.GetPcName: string;
const
   MAX_COMPUTER_LENGTH = 30;
var
   pNome : PChar;
   len : DWord;
begin
   try
      len := MAX_COMPUTER_LENGTH + 1;
      GetMem(pNome, len);
      if GetComputerName(pNome, len) then
         Result := pNome
      else
         Result := 'Não foi possível obter o nome deste computador!';
   finally
      FreeMem(pNome, len);
   end;
end;


class function THlp.InternetIsConnected: Boolean;
begin
  Result := InternetCheckConnection('http://www.google.com.br/', 1, 0);
end;

end.

