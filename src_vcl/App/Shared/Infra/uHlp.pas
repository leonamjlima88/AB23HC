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
    class function  BollInt(AValue: Boolean): Integer;
    class function  IntBool(AValue: Integer): Boolean;
    class procedure RemoveEventsFromDataSet(ADataSet: TDataSet; ARemoveSet: Boolean = true; ARemoveGet: Boolean = True);
    class procedure FormatDataSet(ADataSet: TDataSet; ADecimalPlaces: Integer = 2); // Formata Campos do DataSet
    class function  RemoveDots(Str: String): String; // Remover Pontos da String
    class function  FormatPhone(pFone: String): String; // Formatar número de telefone
    class function  OnlyNumbers(fField : String): String; // Retornar apenas números de uma string
    class function  ValidateCpfCnpj(Dado: string): String; // Validar CNPJ/CNPJ
    class function  ValidateCnpj(Dado: string): Boolean; // Validar CNPJ
    class function  ValidateCpf(Dado: string): Boolean; // Validar CPF
    class procedure FillDataSetWithZero(ADataSet: TDataSet; AValueInteger: Boolean = true; AValueDouble: Boolean = true);
    class function  StrZero(Conteudo: String; Tamanho: Integer): String;
    class function  ExtractFromHeader(ATag: String; AHeader: TStrings): String;
    class function  InternetIsConnected: Boolean;
    class function  DayOfWeekStr(Data:TDateTime): string;
    class function  GetPcName: string; // Obter nome do computador
    class function  CreateTransparentBackground(AOwner: TForm; AlphaBlendValue: Integer = 200): TForm;
    class function  DBGridLoadConfig(DBGridPar: TDBGrid; FormName: String): Boolean; // carrega configuração do DBGrid
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

class function THlp.BollInt(AValue: Boolean): Integer;
begin
  case AValue of
    True:  Result := 1;
    False: Result := 0;
  end;
end;

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

class procedure THlp.DBGridDeleteConfig(DBGridPar: TDBGrid; FormName: String);
var
   Destino, GridConfig : string;
begin
  Try
    Destino := ExtractFilePath(Application.ExeName) + 'GridConfig\';

    // Criar Diretorio se não existir
    if not DirectoryExists(Destino) then
      ForceDirectories(Destino);

    // Nome do Form
    if (FormName = '') then
      FormName := DBGridPar.Owner.Name;

    // Salva Configurações do Grid
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

    // Criar Diretorio se não existir
    if not DirectoryExists(Destino) then
        ForceDirectories(Destino);

    // Nome do Form
    if (FormName = '') then
      FormName := DBGridPar.Owner.Name;

    // Carrega Configurações do Grid
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

    // Criar Diretorio se não existir
    if not DirectoryExists(Destino) then
      ForceDirectories(Destino);

    // Nome do Form
    if (FormName = '') then
      FormName := DBGridPar.Owner.Name;

    // Salva Configurações do Grid
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

class procedure THlp.FillDataSetWithZero(ADataSet: TDataSet; AValueInteger, AValueDouble: Boolean);
var
  lI: Integer;
begin
  for lI := 0 to Pred(ADataSet.Fields.Count) do
  begin
    if (AValueInteger and (ADataSet.Fields[lI].DataType in [ftSmallint, ftInteger])) then
      ADataSet.Fields[lI].AsInteger := 0;

    if (AValueDouble and (ADataSet.Fields[lI].DataType in [ftFloat, ftCurrency, ftBCD])) then
      ADataSet.Fields[lI].AsFloat := 0;
  end;
end;

class procedure THlp.FormatDataSet(ADataSet: TDataSet; ADecimalPlaces: Integer);
Var
  lI: Integer;
  lDecimalPlacesMask: String;
begin
  lDecimalPlacesMask := '';
  case ADecimalPlaces of
    1: lDecimalPlacesMask := '#,###,##0.0';
    2: lDecimalPlacesMask := '#,###,##0.00';
    3: lDecimalPlacesMask := '#,###,##0.000';
    4: lDecimalPlacesMask := '#,###,##0.0000';
  end;

  // Evitar erro
  if (lDecimalPlacesMask = '') then
    lDecimalPlacesMask := '#,###,##0.00';

  // Formatar campos
  for lI := 0 to ADataSet.Fields.Count-1 do
  Begin
    ADataSet.Fields[lI].Alignment := taLeftJustify;
    if ADataSet.Fields[lI].DataType in [ftFloat, ftCurrency, ftBCD, ftFMTBcd] Then
    Begin
      TBCDField(ADataSet.Fields[lI]).DisplayFormat := '#,###,##0.00';
      ADataSet.Fields[lI].Alignment := taRightJustify;
    End;
  End;
end;


class function THlp.FormatPhone(pFone: String): String;
begin
  pFone  := RemoveDots(pFone);
  Result := pFone;

  case Length(pFone) of
     8: Result := FormatMaskText('\(00\) 0000\-0000;0;', '00' + pFone);
     9: Result := FormatMaskText('\(00\) 0 0000\-0000;0;', '00' + pFone);
    10: Result := FormatMaskText('\(00\) 0000\-0000;0;', pFone);
    11: Result := FormatMaskText('\(00\) 0 0000\-0000;0;', pFone);
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


class function THlp.IntBool(AValue: Integer): Boolean;
begin
  Result := AValue = 1;
end;

class function THlp.InternetIsConnected: Boolean;
begin
  Result := InternetCheckConnection('http://www.google.com.br/', 1, 0);
end;

class function THlp.OnlyNumbers(fField: String): String;
var
  I : Byte;
begin
  Result := '';

  if (fField = '') then EXIT;
  for I := 0 To Length(fField) do
    if fField [I] In ['0'..'9'] Then
      Result := Result + fField [I];
end;


class function THlp.RemoveAccentedChars(AValue: String): String;
const
  lWithAccentedChars = 'áàâäãéèêëíìîïóòôöõúùûüçÁÀÂÄÃÉÈÊËÍÌÎÏÓÒÔÖÕÚÙÛÜÇºª‡”‰šƒ“';
  lWithoutAccentedChars = 'aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC        ';
var
   x: Integer;
begin;
  for x := 1 to Length(AValue) do
  if Pos(AValue[x],lWithAccentedChars) <> 0 then
    AValue[x] := lWithoutAccentedChars[Pos(AValue[x], lWithAccentedChars)];
  Result := AValue;
end;

class function THlp.RemoveDots(Str: String): String;
var
  i: Integer;
  xStr: String;
begin
  xStr := '';
  for I := 1 to Length(Trim(Str)) do
    if (Pos(Copy(str,i,1),'/-.)(,|')=0) then xStr := xStr + str[i];

  xStr := StringReplace(xStr, ' ','',[rfReplaceAll]);

  Result := xStr.Trim;
end;

class procedure THlp.RemoveEventsFromDataSet(ADataSet: TDataSet; ARemoveSet, ARemoveGet: Boolean);
var
  lField: TField;
begin
  for lField in ADataSet.Fields do
  begin
    if ARemoveSet then lField.OnSetText := nil;
    if ARemoveGet then lField.OnGetText := nil;
  end;
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

class function THlp.ValidateCnpj(Dado: string): Boolean;
var
  D1: array[1..12] of byte;
  I, iAux, DF1, DF2, DF3, DF4, DF5, DF6, Resto1, Resto2, PrimeiroDigito,
  SegundoDigito: integer;
begin
  Result := true;

  // Evitar erro de validação entre Android e Windows
  {$IFDEF ANDROID}
    iAux := 1;
  {$ELSE}
    iAux := 0;
  {$ENDIF}

  if Length(Dado) = 14 then
  begin
    for I := 1 to 12 do
      D1[I] := StrToInt(Dado[I-iAux]);

    if Result then
    begin
      DF1 := 0;
      DF2 := 0;
      DF3 := 0;
      DF4 := 0;
      DF5 := 0;
      DF6 := 0;
      Resto1 := 0;
      Resto2 := 0;
      PrimeiroDigito := 0;
      SegundoDigito := 0;
      DF1 := 5*D1[1] + 4*D1[2] + 3*D1[3] + 2*D1[4] + 9*D1[5] + 8*D1[6] +
             7*D1[7] + 6*D1[8] + 5*D1[9] + 4*D1[10] + 3*D1[11] + 2*D1[12];
      DF2 := DF1 div 11;
      DF3 := DF2 * 11;
      Resto1 := DF1 - DF3;
      if (Resto1 = 0) or (Resto1 = 1) then
        PrimeiroDigito := 0
      else
        PrimeiroDigito := 11 - Resto1;

      DF4 := 6*D1[1] + 5*D1[2] + 4*D1[3] + 3*D1[4] + 2*D1[5] + 9*D1[6] +
             8*D1[7] + 7*D1[8] + 6*D1[9] + 5*D1[10] + 4*D1[11] + 3*D1[12] + 2*PrimeiroDigito;
      DF5 := DF4 div 11;
      DF6 := DF5 * 11;
      Resto2 := DF4 - DF6;
      if (Resto2 = 0) or (Resto2 = 1) then
        SegundoDigito := 0
      else
        SegundoDigito := 11 - Resto2;

      if (PrimeiroDigito <> StrToInt(Dado[13-iAux])) or
         (SegundoDigito <> StrToInt(Dado[14-iAux])) then
        Result := false;
    end;
  end else
    if Length(Dado) <> 0 then
      Result := false;
end;

class function THlp.ValidateCpf(Dado: string): Boolean;
var
  D1: array[1..9] of byte;
  I, iAux, DF1, DF2, DF3, DF4, DF5, DF6, Resto1, Resto2, PrimeiroDigito,
  SegundoDigito: integer;
begin
  Result := true;

  // Evitar erro de validação entre Android e Windows
  {$IFDEF ANDROID}
    iAux := 1;
  {$ELSE}
    iAux := 0;
  {$ENDIF}

  Dado := OnlyNumbers(Dado);
  if Length(Dado) = 11 then
  begin
    for I := 1 to 9 do
      D1[I] := StrToInt(Dado[I-iAux]);

    if Result then
    begin
      DF1 := 0;
      DF2 := 0;
      DF3 := 0;
      DF4 := 0;
      DF5 := 0;
      DF6 := 0;
      Resto1 := 0;
      Resto2 := 0;
      PrimeiroDigito := 0;
      SegundoDigito := 0;
      DF1 := 10*D1[1] + 9*D1[2] + 8*D1[3] + 7*D1[4] + 6*D1[5] + 5*D1[6] +
             4*D1[7] + 3*D1[8] + 2*D1[9];
      DF2 := DF1 div 11;
      DF3 := DF2 * 11;
      Resto1 := DF1 - DF3;
      if (Resto1 = 0) or (Resto1 = 1) then
        PrimeiroDigito := 0
      else
        PrimeiroDigito := 11 - Resto1;

      DF4 := 11*D1[1] + 10*D1[2] + 9*D1[3] + 8*D1[4] + 7*D1[5] + 6*D1[6] +
             5*D1[7] + 4*D1[8] + 3*D1[9] + 2*PrimeiroDigito;
      DF5 := DF4 div 11;
      DF6 := DF5 * 11;
      Resto2 := DF4 - DF6;

      if (Resto2 = 0) or (Resto2 = 1) then
        SegundoDigito := 0
      else
        SegundoDigito := 11 - Resto2;

      if (PrimeiroDigito <> StrToInt(Dado[10-iAux])) or
         (SegundoDigito <> StrToInt(Dado[11-iAux])) then
        Result := false;
    end;
  end else
    if Length(Dado) <> 0 then
      Result := false;
End;

class function THlp.ValidateCpfCnpj(Dado: string): String;
begin
  Result := '';

  // Validar quantidade de caracteres e CPF/CNPJ
  Dado := onlyNumbers(Dado);
  if ((length(Dado) <> 11) and (length(Dado) <> 14))then EXIT;

  // Validar CNPJ
  if (length(Dado) = 14) then
  begin
    if validateCnpj(Dado) then
    begin
      insert('-',Dado,13);
      insert('/',Dado,9);
      insert('.',Dado,6);
      insert('.',Dado,3);
    end else EXIT;
  end;

  // Validar CPF
  if (length(Dado) = 11) then
  begin
    if validateCpf(Dado) then
    begin
      insert('-',Dado,10);
      insert('.',Dado,7);
      insert('.',Dado,4);
    end else EXIT;
  End;

  Result := Dado;
end;

end.

