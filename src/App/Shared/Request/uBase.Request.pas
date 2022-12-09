unit uBase.Request;

interface

uses
  Horse.Response,
  Horse.Request,
  XSuperObject,
  uValidateSuperObject;

type
  IBaseRequest = Interface
    ['{54DB7A2E-5A94-49CE-8805-DE2A6BCF1B8B}']
    function AddRule(AFieldName: String; ARule: String): IBaseRequest;
    function ExecuteRules: IBaseRequest;
  end;

  TBaseRequest = class(TInterfacedObject, IBaseRequest)
  private
    FValidateSuperObject: IValidateSuperObject;
    FReq: THorseRequest;
    FRes: THorseResponse;
    FSObj: ISuperObject;
    FErrors: String;
  public
    property Errors: String read FErrors write FErrors;
    constructor Create(const AReq: THorseRequest; const ARes: THorseResponse); virtual;

    function Validate: String;
    procedure HandleAttributes; virtual; abstract;
    function Req: THorseRequest;
    function Res: THorseResponse;
    function AddRule(AFieldName: String; ARule: String): IBaseRequest;
    function ExecuteRules: IBaseRequest;
    function Body: String;
  end;

implementation

uses
  System.SysUtils;

{ TBaseRequest }

function TBaseRequest.AddRule(AFieldName, ARule: String): IBaseRequest;
begin
  Result := Self;
  FValidateSuperObject.AddRule(AFieldName, ARule);
end;

function TBaseRequest.Body: String;
begin
  Result := FReq.Body;
end;

constructor TBaseRequest.Create(const AReq: THorseRequest; const ARes: THorseResponse);
begin
  inherited Create;
  FReq                 := AReq;
  FRes                 := ARes;
  FSObj                := SO(FReq.Body);
  FValidateSuperObject := TValidateSuperObject.Make(FSObj);
end;

function TBaseRequest.ExecuteRules: IBaseRequest;
begin
  Result := Self;
  FErrors := FErrors + FValidateSuperObject.Execute;
end;

function TBaseRequest.Req: THorseRequest;
begin
  Result := FReq;
end;

function TBaseRequest.Res: THorseResponse;
begin
  Result := FRes;
end;

function TBaseRequest.Validate: String;
begin
  FErrors := EmptyStr;

  HandleAttributes;
  Result := FErrors.Trim;
end;

end.
