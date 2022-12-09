unit uConnection.Interfaces;

interface

uses
  uQry.Interfaces,
  uScript.Interfaces,
  System.Classes,
  uConnection.Types;

type
  IConnection = interface
    ['{264DE292-C1C2-471D-93C7-81C2582F29CE}']

    function ConnectionType: TConnLibType;
    function DriverDB: TDriverDB;
    function DataBaseName: String;
    function IsConnected: Boolean;
    function Connect: IConnection;
    function Disconnect: IConnection;
    function MakeQry: IQry;
    function MakeScript: IScript;
    function Instance: TComponent;
    function InTransaction: Boolean;
    function StartTransaction: IConnection;
    function CommitTransaction: IConnection;
    function RollBackTransaction: IConnection;
  end;

implementation

end.
