unit uBrand.Request.Old;

interface

uses
  Horse.Request,
  Horse,
  XSuperObject,
  uBrand;

type
  IBrandRequest = interface
    ['{B56DD61F-D966-41CB-B662-30E47D896096}']
    function Validate: TBrand;
  end;

  TBrandRequest = class(TInterfacedObject, IBrandRequest)
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FSObj: ISuperObject;
    FErrors: String;
    constructor Create(const AReq: THorseRequest; const ARes: THorseResponse);
    function HandleAttributes: IBrandRequest;
    function HandleBrand: IBrandRequest;
  public
    class function Make(const AReq: THorseRequest; const ARes: THorseResponse): IBrandRequest;
    function Validate: TBrand;
  end;

implementation

uses
  uValidateSuperObject,
  System.SysUtils,
  uRes,
  uApplication.Types,
  uHlp,
  uMyClaims;

{ TBrandRequest }

constructor TBrandRequest.Create(const AReq: THorseRequest; const ARes: THorseResponse);
begin
  inherited Create;
  FReq  := AReq;
  FRes  := ARes;
  FSObj := SO(FReq.Body);
end;

function TBrandRequest.HandleAttributes: IBrandRequest;
begin
  Result := Self;
  HandleBrand;
end;

function TBrandRequest.HandleBrand: IBrandRequest;
begin
  Result := Self;

  // Validar Brand
  FErrors := FErrors + TValidateSuperObject.Make(FSObj)
    .AddRule('name', 'required|string|max:100')
    .Execute;
end;

class function TBrandRequest.Make(const AReq: THorseRequest; const ARes: THorseResponse): IBrandRequest;
begin
  Result := Self.Create(AReq, ARes);
end;

function TBrandRequest.Validate: TBrand;
begin
  HandleAttributes;

  case FErrors.Trim.IsEmpty of
    True:  Result := TBrand.FromJSON(FReq.Body);
    False: Begin
      TRes.Error(FRes, VALIDATION_ERROR, FErrors);
      Exit;
    End;
  end;

  case (THlp.StrInt(FReq.Params['id']) = 0) of
    True:  Result.created_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
    False: Result.updated_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  end;
end;

end.

