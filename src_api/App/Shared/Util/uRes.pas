unit uRes;

interface

uses
  Horse.Response,
  XSuperObject,
  uApplication.Types;

type
  TRes = class
  private
    class procedure Send(const ARes: THorseResponse; ASObj: ISuperObject; AStatusCode: SmallInt; AContentType: String = 'application/json');
  public
    class procedure Success(const ARes: THorseResponse; const AData: ISuperObject = nil; AHttpCode: SmallInt = HTTP_OK; AMessage: String = SUCCESS_MESSAGE); overload;
    class procedure Success(const ARes: THorseResponse; const AData: String; AHttpCode: SmallInt = HTTP_OK; AMessage: String = SUCCESS_MESSAGE); overload;
    class procedure Error(const ARes: THorseResponse; AMessage: String = OOPS_MESSAGE; AData: String = ''; AHttpCode: SmallInt = HTTP_BAD_REQUEST);
  end;

implementation

uses
  uSmartPointer,
  System.Classes,
  System.SysUtils,
  uHlp, System.JSON;

{ TRes }

class procedure TRes.Error(const ARes: THorseResponse; AMessage, AData: String; AHttpCode: SmallInt);
var
  lReturn, lData: ISuperObject;
  lDataStrList: IShared<TStringList>;
  lI: SmallInt;
begin
  lReturn := SO;
  lReturn.I['code']    := AHttpCode;
  lReturn.B['error']   := true;
  lReturn.S['message'] := AMessage;

  // Tratamento do campo de retorno Data
  case AData.Trim.IsEmpty of
    True: lReturn.Null['data'] := jNull;
    False: Begin
      lDataStrList := Shared<TStringList>.Make;
      THlp.parseDelimited(lDataStrList, AData, DELIMITED_CHAR);
      for lI := 0 to Pred(lDataStrList.Count) do
        if not lDataStrList[lI].Trim.IsEmpty then
          lReturn.A['data'].Add(lDataStrList[lI]);
    end;
  end;

  //  Envio do erro
  Send(ARes, lReturn, AHttpCode);
end;

class procedure TRes.Send(const ARes: THorseResponse; ASObj: ISuperObject; AStatusCode: SmallInt; AContentType: String);
begin
  ARes
    .ContentType(AContentType)
    .Send<TJSONObject>(TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(ASObj.AsJSON), 0) as TJSONObject)
    .Status(AStatusCode);
end;

class procedure TRes.Success(const ARes: THorseResponse; const AData: String; AHttpCode: SmallInt; AMessage: String);
var
  lReturn: ISuperObject;
begin
  lReturn := SO;
  lReturn.I['code']    := AHttpCode;
  lReturn.B['error']   := false;
  lReturn.S['message'] := AMessage;
  lReturn.S['data']    := AData;

  // Envio de sucesso
  Send(ARes, lReturn, AHttpCode);
end;

class procedure TRes.Success(const ARes: THorseResponse; const AData: ISuperObject; AHttpCode: SmallInt; AMessage: String);
var
  lReturn: ISuperObject;
begin
  lReturn := SO;
  lReturn.I['code']    := AHttpCode;
  lReturn.B['error']   := false;
  lReturn.S['message'] := AMessage;

  // Tratamento do campo de retorno Data
  case Assigned(AData) of
    True:  lReturn.O['data']    := AData;
    False: lReturn.Null['data'] := jNull;
  end;

  // Envio de sucesso
  Send(ARes, lReturn, AHttpCode);
end;

end.
