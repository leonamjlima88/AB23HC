unit uMigration.Base;

interface

uses
  uMigration.Interfaces,
  uZLConnection.Interfaces,
  uZLQry.Interfaces,
  uZLScript.Interfaces;

type
  TMigrationBase = class(TInterfacedObject, IMigration)
  protected
    FConn: IZLConnection;
    FQry: IZLQry;
    FScript: IZLScript;
    FInformation: IMigrationInfo;
  public
    constructor Create(AConn: IZLConnection);
    destructor Destroy; override;

    function Execute: IMigration; virtual; abstract;
    function Information: IMigrationInfo;
  end;

implementation

uses
  uMigration.Info,
  System.SysUtils;

{ T01CreateGroupTable }

constructor TMigrationBase.Create(AConn: IZLConnection);
begin
  FConn        := AConn;
  FQry         := AConn.MakeQry;
  FScript      := AConn.MakeScript;
  FInformation := TMigrationInfo.Make;

  // Informações da Migration
  FInformation.Description(Self.ClassName);
end;

destructor TMigrationBase.Destroy;
begin
  inherited;
end;

function TMigrationBase.Information: IMigrationInfo;
begin
  Result := FInformation;
end;

end.
