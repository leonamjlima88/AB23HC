unit uSelectWithFilter;

interface

uses
  uPageFilter,
  uZLConnection.Types;

type
  TOutPutSelectAllFilter = record
    SQL: String;
    SQLWithoutPaginate: String;
  end;

  TSelectWithFilter = class
  private
  public
    class function SelectAllWithFilter(APageFilter: IPageFilter; ASelectAll: String; APK: String; ADriverDB: TZLDriverDB = ddMySql): TOutPutSelectAllFilter;
    class function FormatCondOperatorAndFieldValue(AcondOperator: TcondOperator; AfieldValue: String): string;
  end;

implementation

uses
  System.SysUtils,
  uHlp;

{ TSelectWithFilter }

class function TSelectWithFilter.SelectAllWithFilter(APageFilter: IPageFilter; ASelectAll: String; APK: String; ADriverDB: TZLDriverDB): TOutPutSelectAllFilter;
var
  lSQL: String;
  lColumns, lLimitPerPage, lSkipRecords: String;
  lCurrentPage: Integer;
  lConditionWhere, lConditionOrWhere: String;
  lSQLWithoutPaginate: String;
  lI: Integer;
  lGoFilter: Boolean;
  lWhereOrAnd: String;
begin
  lSQL := ASelectAll.ToLower;
  if not Assigned(APageFilter) then
  begin
    Result.SQL := lSQL;
    Result.SQLWithoutPaginate := lSQL;
    Exit;
  end;

  lColumns      := APageFilter.Columns.Trim.ToLower;
  lLimitPerPage := APageFilter.LimitPerPage.ToString;
  lCurrentPage  := THlp.iif((APageFilter.CurrentPage <= 0), 1, APageFilter.CurrentPage);
  lSkipRecords  := ((lCurrentPage - 1) * APageFilter.LimitPerPage).ToString;

  // Evitar erros
  if (lLimitPerPage = '0') then lLimitPerPage := '50';
  if (lCurrentPage = 0)    then lCurrentPage  := 1;

  // Colunas a serem exibidas
  if not lColumns.Trim.IsEmpty then
    lSQL := 'select ' + lColumns + ' ' + copy(lSQL, Pos('from', lSQL));

  // Where
  lConditionWhere := EmptyStr;
  for lI := 0 to pred(APageFilter.where.count) do
  begin
    case (lI = 0) of
      True:  lWhereOrAnd := ' where ';
      False: lWhereOrAnd := ' and ';
    end;
    // Verificar se deve filtrar
    lGoFilter := true;
    if (APageFilter.where[lI].fieldValue.Trim.IsEmpty) and APageFilter.where[lI].ifDiffEmpty then
      lGoFilter := false;

    // Filtrar
    if lGoFilter then
    begin
      lConditionWhere := lConditionWhere + lWhereOrAnd + THlp.iif((lConditionWhere.IsEmpty), ' ( ', '') +
        APageFilter.where[lI].fieldName +
        formatCondOperatorAndFieldValue(
          APageFilter.where[lI].condOperator,
          APageFilter.where[lI].fieldValue
        );
    end;
  end;
  lConditionWhere := THlp.iif(lConditionWhere.Trim.IsEmpty, '', lConditionWhere + ' ) ');

  // orWhere
  for lI := 0 to pred(APageFilter.orWhere.count) do
  begin
    case (lI = 0) and lConditionWhere.Trim.IsEmpty of
      True:  lWhereOrAnd := ' where ';
      False: lWhereOrAnd := ' and ';
    end;

    // Verificar se deve filtrar
    lGoFilter := true;
    if (APageFilter.orWhere[lI].fieldValue.Trim.IsEmpty) and APageFilter.orWhere[lI].ifDiffEmpty then
      lGoFilter := false;

    // Filtrar
    if lGoFilter then
    begin
      lConditionOrWhere :=  lConditionOrWhere + THlp.iif((lConditionOrWhere.IsEmpty), lWhereOrAnd + ' (', ' or ') +
        APageFilter.orWhere[lI].fieldName +
        formatCondOperatorAndFieldValue(
          APageFilter.orWhere[lI].condOperator,
          APageFilter.orWhere[lI].fieldValue
        );
    end;
  end;
  lConditionOrWhere := THlp.iif(lConditionOrWhere.Trim.IsEmpty, '', lConditionOrWhere + ' ) ');

  // Adicionar Condições
  lSQL := lSQL + lConditionWhere + lConditionOrWhere;

  // Adicionar Ordenação
  lSQL := lSQL + ' order by ' + THlp.iif(
    APageFilter.orderBy.Trim.IsEmpty,
    APK,
    APageFilter.orderBy.Trim
  );

  // Limit e Skip
  lSQLWithoutPaginate := lSQL;
  lSQL := lSQL + ' limit '+lLimitPerPage+' offset '+lSkipRecords+' ';
//  lSQL := StringReplace(
//    lSQL,
//    'select',
//    AnsiLowerCase('select first ' + lLimitPerPage + ' skip ' + lSkipRecords), [rfReplaceAll]
//  );

  Result.SQL := lSQL;
  Result.SQLWithoutPaginate := lSQLWithoutPaginate;
end;

class function TSelectWithFilter.FormatCondOperatorAndFieldValue(AcondOperator: TcondOperator; AfieldValue: String): string;
begin
  case AcondOperator of
    coEqual:          Result := ' = '    + QuotedStr(AfieldValue);
    coGreater:        Result := ' > '    + QuotedStr(AfieldValue);
    coLess:           Result := ' < '    + QuotedStr(AfieldValue);
    coGreaterOrEqual: Result := ' >= '   + QuotedStr(AfieldValue);
    coLessOrEqual:    Result := ' <= '   + QuotedStr(AfieldValue);
    coDifferent:      Result := ' <> '   + QuotedStr(AfieldValue);
    coLikeInitial:    Result := ' like ' + QuotedStr(AfieldValue+'%');
    coLikeFinal:      Result := ' like ' + QuotedStr('%'+AfieldValue);
    coLikeAnywhere:   Result := ' like ' + QuotedStr('%'+AfieldValue+'%');
    coLikeEqual:      Result := ' = '    + QuotedStr(AfieldValue);
  end;
end;

end.
