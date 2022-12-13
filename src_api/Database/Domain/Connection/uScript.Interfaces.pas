unit uScript.Interfaces;

interface

type
  IScript = interface
    ['{801CA8B3-2077-4635-A8A1-E34696612AEE}']

    function SQLScriptsClear: IScript;
    function SQLScriptsAdd(AValue: String): IScript;
    function ValidateAll: Boolean;
    function ExecuteAll: Boolean;
  end;

implementation

end.
