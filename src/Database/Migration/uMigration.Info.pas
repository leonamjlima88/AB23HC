unit uMigration.Info;

interface

uses
  uMigration.Interfaces;

type
  TMigrationInfo = class(TInterfacedObject, IMigrationInfo)
  private
    FExecuted: Boolean;
    FDescription: string;
    FCreatedAtByDev: TDateTime;
    FDuration: Double;
  public
    class function Make: IMigrationInfo;

    function Executed: boolean; overload;
    function Executed(AValue: boolean): IMigrationInfo; overload;

    function Description: string; overload;
    function Description(AValue: String): IMigrationInfo; overload;

    function CreatedAtByDev: TDateTime; overload;
    function CreatedAtByDev(AValue: TDateTime): IMigrationInfo; overload;

    function Duration: Double; overload;
    function Duration(AValue: Double): IMigrationInfo; overload;
  end;

implementation

{ TMigrationInfo }

function TMigrationInfo.CreatedAtByDev: TDateTime;
begin
  Result := FCreatedAtByDev;
end;

function TMigrationInfo.Description: string;
begin
  Result := FDescription;
end;

function TMigrationInfo.Description(AValue: String): IMigrationInfo;
begin
  Result := Self;
  FDescription := AValue;
end;

class function TMigrationInfo.Make: IMigrationInfo;
begin
  Result := Self.Create;
end;

function TMigrationInfo.Duration(AValue: Double): IMigrationInfo;
begin
  Result := Self;
  FDuration := AValue;
end;

function TMigrationInfo.Duration: Double;
begin
  Result := FDuration;
end;

function TMigrationInfo.CreatedAtByDev(AValue: TDateTime): IMigrationInfo;
begin
  Result := Self;
  FCreatedAtByDev := AValue;
end;

function TMigrationInfo.Executed(AValue: boolean): IMigrationInfo;
begin
  Result := Self;
  FExecuted := AValue;
end;

function TMigrationInfo.Executed: boolean;
begin
  Result := FExecuted;
end;

end.
