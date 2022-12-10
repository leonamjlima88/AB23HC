unit uQtdStr;

interface

type
  TQtdStr = class
  public
    class function Value(AValue: String): String; overload;
    class function Value(AValue: SmallInt): String; overload;
    class function Value(AValue: Integer): String; overload;
    class function Value(AValue: Int64): String; overload;
    class function Value(AValue: TDateTime): String; overload;
    class function Value(AValue: Boolean): String; overload;
    class function ValueNotNull(AValue: Int64): String; overload; // Retornar null se for <= 0
    class function ValueNotNull(AValue: TDateTime): String; overload; // Retornar null se for <= 0
    class function ValueDec(AValue: Double; ADecimalPlaces: SmallInt = 4): String;
  end;

implementation

uses
  System.SysUtils,
  System.Variants;

{ TQtdStr }

class function TQtdStr.Value(AValue: String): String;
begin
  Result := QuotedStr(AValue);
end;

class function TQtdStr.Value(AValue: Int64): String;
begin
  Result := QuotedStr(AValue.ToString);
end;

class function TQtdStr.Value(AValue: SmallInt): String;
begin
  Result := QuotedStr(AValue.ToString);
end;

class function TQtdStr.Value(AValue: Integer): String;
begin
  Result := QuotedStr(AValue.ToString);
end;

class function TQtdStr.Value(AValue: TDateTime): String;
begin
  Result := QuotedStr(FormatDateTime('YYYY-MM-DD HH:MM:SS', AValue));
end;

class function TQtdStr.ValueNotNull(AValue: TDateTime): String;
begin
  case (AValue <= 0) of
    True:  Result := 'Null';
    False: Result := TQtdStr.Value(AValue);
  end;
end;

class function TQtdStr.ValueNotNull(AValue: Int64): String;
begin
  case (AValue <= 0) of
    True:  Result := 'Null';
    False: Result := TQtdStr.Value(AValue);
  end;
end;

class function TQtdStr.ValueDec(AValue: Double; ADecimalPlaces: SmallInt): String;
var
  lFormatedValue: String;
begin
  lFormatedValue := FormatFloat('0.'+StringOfChar('0', ADecimalPlaces), AValue);
  Result := QuotedStr(StringReplace(lFormatedValue, FormatSettings.DecimalSeparator, '.', [rfReplaceAll,rfIgnoreCase]));
end;

class function TQtdStr.Value(AValue: Boolean): String;
begin
  case AValue of
    True:  Result := QuotedStr('1');
    False: Result := QuotedStr('0');
  end;
end;

end.
