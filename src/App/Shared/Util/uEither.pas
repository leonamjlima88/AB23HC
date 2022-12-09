unit uEither;

interface

uses
  System.SysUtils;

const
  IsLeft = False;
  IsRight = True;

type
  Either<TLeft,TRight> = record
  private
    fMatch: Boolean;
    fRight: TRight;
    fLeft: TLeft;
    function GetRight: TRight; inline;
    function GetLeft: TLeft; inline;
  public
    constructor FromLeft(const value: TLeft);
    constructor FromRight(const value: TRight);

    procedure Fold(const right: TProc<TRight>; const left: TProc<TLeft>); overload;
    function  Fold<TResult>(const right: TFunc<TRight,TResult>; const left: TFunc<TLeft,TResult>): TResult; overload;

    property Match: Boolean read fMatch;
    property Right: TRight read GetRight;
    property Left: TLeft read GetLeft;

    class operator Implicit(const value: TRight): Either<TLeft,TRight>;
    class operator Implicit(const value: TLeft): Either<TLeft,TRight>;
  end;

implementation

constructor Either<TLeft, TRight>.FromRight(const value: TRight);
begin
  fRight := value;
  fLeft  := Default(TLeft);
  fMatch := IsRight;
end;

constructor Either<TLeft, TRight>.FromLeft(const value: TLeft);
begin
  fLeft  := value;
  fRight := Default(TRight);
  fMatch := IsLeft;
end;

procedure Either<TLeft, TRight>.Fold(const right: TProc<TRight>; const left: TProc<TLeft>);
begin
  case Match of
    IsRight: right(fRight);
    IsLeft:  left(fLeft);
  end;
end;

function Either<TLeft, TRight>.Fold<TResult>(const right: TFunc<TRight, TResult>; const left: TFunc<TLeft, TResult>): TResult;
begin
  case Match of
    IsRight: Result := right(fRight);
    IsLeft:  Result := left(fLeft);
  end;
end;

function Either<TLeft, TRight>.GetRight: TRight;
begin
  case fMatch of
    IsRight: Result := fRight;
    IsLeft: raise EInvalidOpException.Create('Either type has no right value.');
  end;
end;

function Either<TLeft, TRight>.GetLeft: TLeft;
begin
  case fMatch of
    IsRight: raise EInvalidOpException.Create('Either type has no left value.');
    IsLeft: Result := fLeft;
  end;
end;

class operator Either<TLeft, TRight>.Implicit(const value: TRight): Either<TLeft, TRight>;
begin
  Result.fRight := value;
  Result.fLeft  := Default(TLeft);
  Result.fMatch := IsRight;
end;

class operator Either<TLeft, TRight>.Implicit(const value: TLeft): Either<TLeft, TRight>;
begin
  Result.fLeft  := value;
  Result.fRight := Default(TRight);
  Result.fMatch := IsLeft;
end;

end.
