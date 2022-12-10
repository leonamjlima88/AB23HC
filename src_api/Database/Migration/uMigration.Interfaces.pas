unit uMigration.Interfaces;

interface

type
  IMigrationManager = interface;
  IMigration = interface;
  IMigrationInfo = interface;

  IMigrationManager = interface
    ['{8AE8C89D-D349-4BED-8E7E-6E6C7D95ACB2}']

    function Execute: IMigrationManager;
  end;

  IMigration = interface
    ['{3CB20015-DCBE-4196-BFCC-6B372B3E3526}']
    function Execute: IMigration;
    function Information: IMigrationInfo;
  end;

  IMigrationInfo = interface
    ['{28BC7325-02B3-4DE9-B2E0-890B1F052B28}']

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

end.
