unit uHlp;

interface

uses
  Data.DB,
  System.Classes,
  Winapi.Windows,
  Winapi.WinInet,
  Vcl.Forms,
  Vcl.DBGrids;

type
  THlp = class
  public
    class function  StrZero(Conteudo: String; Tamanho: Integer): String;
    class function  ExtractFromHeader(ATag: String; AHeader: TStrings): String;
    class function  InternetIsConnected: Boolean;
    class function  DayOfWeekStr(Data:TDateTime): string;
    class function  GetPcName: string; // Obter nome do computador
    class function  CreateTransparentBackground(AOwner: TForm; AlphaBlendValue: Integer = 200): TForm;
    class function  DBGridLoadConfig(DBGridPar: TDBGrid; FormName: String): Boolean; // carrega configuraÁ„o do DBGrid
    class procedure DBGridDeleteConfig(DBGridPar: TDBGrid; FormName: String); // deleta configuracao do DBGrid
    class procedure DBGridSaveConfig(DBGridPar: TDBGrid; FormName: String);
    class function  RemoveAccentedChars(AValue: String): String; // Remover caracteres acentuados
    class function  StrInt(AValue: String; ADefaultValue: Integer = 0): Integer;
    class function  StrFloat(AValue: String; ADefaultValue: Double = 0): Double;
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
    3: Result := 'TerÁa';
    4: Result := 'Quarta';
    5: Result := 'Quinta';
    6: Result := 'Sexta';
    7: Result := 'S·bado';
  end;
end;

class procedure THlp.DBGridDeleteConfig(DBGridPar: TDBGrid; FormName: String);
var
   Destino, GridConfig : string;
begin
  Try
    Destino := ExtractFilePath(Application.ExeName) + 'GridConfig\';

    // Criar Diretorio se n„o existir
    if not DirectoryExists(Destino) then
      ForceDirectories(Destino);

    // Nome do Form
    if (FormName = '') then
      FormName := DBGridPar.Owner.Name;

    // Salva ConfiguraÁıes do Grid
    GridConfig := Destino + FormName + '-' + DBGridPar.Name + '.cfg';
    System.SysUtils.DeleteFile(GridConfig);
  Except
    on E: Exception do
    Begin
      raise Exception.Create(
      'Falha ao excluir grade.' + #13 +
        E.ClassName +
        ' Erro gerado, com mensagem: ' +
        E.Message
      );
    End;
  end;
end;

class function THlp.DBGridLoadConfig(DBGridPar: TDBGrid; FormName: String): Boolean;
var
  Destino, GridConfig: string;
begin
  Result := False;
  Try
    Destino := ExtractFilePath(Application.ExeName) + 'GridConfig\';

    // Criar Diretorio se n„o existir
    if not DirectoryExists(Destino) then
        ForceDirectories(Destino);

    // Nome do Form
    if (FormName = '') then
      FormName := DBGridPar.Owner.Name;

    // Carrega ConfiguraÁıes do Grid
    GridConfig := Destino + FormName + '-' + DBGridPar.Name + '.cfg';
    if FileExists(GridConfig) then
    Begin
      DBGridPar.Columns.LoadFromFile(GridConfig);
      Result := True;
    End;
  Except
  end;
end;


class procedure THlp.DBGridSaveConfig(DBGridPar: TDBGrid; FormName: String);
var
   Destino, GridConfig : string;
begin
  Try
    Destino := ExtractFilePath(Application.ExeName) + 'GridConfig\';

    // Criar Diretorio se n„o existir
    if not DirectoryExists(Destino) then
      ForceDirectories(Destino);

    // Nome do Form
    if (FormName = '') then
      FormName := DBGridPar.Owner.Name;

    // Salva ConfiguraÁıes do Grid
    GridConfig := Destino + FormName + '-' + DBGridPar.Name + '.cfg';
    DBGridPar.Columns.SaveToFile(GridConfig);
  Except
    on E: Exception do
    Begin
      raise Exception.Create(
        'Falha ao salvar grade.' + #13 +
        E.ClassName +
        ' Erro gerado, com mensagem: ' +
        E.Message
      );
    End;
  end;
end;

class function THlp.ExtractFromHeader(ATag: String; AHeader: TStrings): String;
var
  lCurrent: String;
begin
  Result := EmptyStr;
  for lCurrent in AHeader do
  begin
    If (Copy(lCurrent, 1, 4).ToLower = ATag.Trim.ToLower) then
    begin
      Result := Copy(lCurrent, ATag.Length+2);
      Break;
    end;
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
         Result := 'N„o foi possÌvel obter o nome deste computador!';
   finally
      FreeMem(pNome, len);
   end;
end;


class function THlp.InternetIsConnected: Boolean;
begin
  Result := InternetCheckConnection('http://www.google.com.br/', 1, 0);
end;

class function THlp.RemoveAccentedChars(AValue: String): String;
const
  lWithAccentedChars = '·‡‚‰„ÈËÍÎÌÏÓÔÛÚÙˆı˙˘˚¸Á¡¿¬ƒ√…» ÀÕÃŒœ”“‘÷’⁄Ÿ€‹«∫™áîâöÉì';
  lWithoutAccentedChars = 'aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC        ';
var
   x: Integer;
begin;
  for x := 1 to Length(AValue) do
  if Pos(AValue[x],lWithAccentedChars) <> 0 then
    AValue[x] := lWithoutAccentedChars[Pos(AValue[x], lWithAccentedChars)];
  Result := AValue;
end;

class function THlp.StrFloat(AValue: String; ADefaultValue: Double): Double;
begin
  // Tratar campo Price
  AValue := StringReplace(AValue, '.', '', [rfReplaceAll]);
  Result := StrToFloatDef(AValue, ADefaultValue);
end;

class function THlp.StrInt(AValue: String; ADefaultValue: Integer): Integer;
begin
  Result := StrToIntDef(AValue, ADefaultValue);
end;

class function THlp.StrZero(Conteudo: String; Tamanho: Integer): String;
begin
  while Length(Conteudo) < Tamanho do
    Insert('0', COnteudo,1);
  Result := Conteudo;
end;

end.

