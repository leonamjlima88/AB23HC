unit uProduct;

interface

uses
  uApplication.Types,
  uAclUser,
  uBase.Entity,
  Data.DB,
  uUnit,
  uStorageLocation,
  uCategory,
  uSize,
  uBrand,
  uProduct.Types;

type
  TProduct = class(TBaseEntity)
  private
    Fid: Int64;
    Fname: string;
    Fgross_weight: Double;
    Fcost: Double;
    Fgenre: TProductGenre;
    Funit_id: Int64;
    Fpacking_weight: Double;
    Fprice: Double;
    Fcurrent_quantity: Double;
    Fmarketup: Double;
    Fis_to_move_the_stock: SmallInt;
    Fstorage_location_id: Int64;
    Fmanufacturing_code: String;
    Fsku_code: String;
    Fmaximum_quantity: Double;
    Fis_product_for_scales: SmallInt;
    Fean_code: String;
    Ftype: TProductType;
    Fcomplement_note: String;
    Fnet_weight: Double;
    Fcategory_id: Int64;
    Fsize_id: Int64;
    Fbrand_id: Int64;
    Fsimplified_name: String;
    Fminimum_quantity: Double;
    Fis_discontinued: SmallInt;
    Finternal_note: String;
    Fidentification_code: String;
    Fcreated_at: TDateTime;
    Fupdated_at: TDateTime;
    Fupdated_by_acl_user_id: Int64;
    Fcreated_by_acl_user_id: Int64;
    Ftenant_id: Int64;

    // OneToOne
    Funit: TUnit;
    Fstorage_location: TStorageLocation;
    Fcategory: TCategory;
    Fsize: TSize;
    Fbrand: TBrand;
    Fupdated_by_acl_user: TAclUser;
    Fcreated_by_acl_user: TAclUser;
    procedure Initialize;
  public
    constructor Create; overload;
    destructor Destroy; override;

    property id: Int64 read Fid write Fid;
    property name: string read Fname write Fname;
    property simplified_name: String read Fsimplified_name write Fsimplified_name;
    property &type: TProductType read Ftype write Ftype;
    property sku_code: String read Fsku_code write Fsku_code;
    property ean_code: String read Fean_code write Fean_code;
    property manufacturing_code: String read Fmanufacturing_code write Fmanufacturing_code;
    property identification_code: String read Fidentification_code write Fidentification_code;
    property cost: Double read Fcost write Fcost;
    property marketup: Double read Fmarketup write Fmarketup;
    property price: Double read Fprice write Fprice;
    property current_quantity: Double read Fcurrent_quantity write Fcurrent_quantity;
    property minimum_quantity: Double read Fminimum_quantity write Fminimum_quantity;
    property maximum_quantity: Double read Fmaximum_quantity write Fmaximum_quantity;
    property gross_weight: Double read Fgross_weight write Fgross_weight;
    property net_weight: Double read Fnet_weight write Fnet_weight;
    property packing_weight: Double read Fpacking_weight write Fpacking_weight;
    property is_to_move_the_stock: SmallInt read Fis_to_move_the_stock write Fis_to_move_the_stock;
    property is_product_for_scales: SmallInt read Fis_product_for_scales write Fis_product_for_scales;
    property internal_note: String read Finternal_note write Finternal_note;
    property complement_note: String read Fcomplement_note write Fcomplement_note;
    property is_discontinued: SmallInt read Fis_discontinued write Fis_discontinued;
    property unit_id: Int64 read Funit_id write Funit_id;
    property category_id: Int64 read Fcategory_id write Fcategory_id;
    property brand_id: Int64 read Fbrand_id write Fbrand_id;
    property size_id: Int64 read Fsize_id write Fsize_id;
    property storage_location_id: Int64 read Fstorage_location_id write Fstorage_location_id;
    property genre: TProductGenre read Fgenre write Fgenre;
    property created_at: TDateTime read Fcreated_at write Fcreated_at;
    property updated_at: TDateTime read Fupdated_at write Fupdated_at;
    property created_by_acl_user_id: Int64 read Fcreated_by_acl_user_id write Fcreated_by_acl_user_id;
    property updated_by_acl_user_id: Int64 read Fupdated_by_acl_user_id write Fupdated_by_acl_user_id;
    property tenant_id: Int64 read Ftenant_id write Ftenant_id;

    // OneToOne
    property &unit: TUnit read Funit write Funit;
    property category: TCategory read Fcategory write Fcategory;
    property brand: TBrand read Fbrand write Fbrand;
    property size: TSize read Fsize write Fsize;
    property storage_location: TStorageLocation read Fstorage_location write Fstorage_location;
    property created_by_acl_user: TAclUser read Fcreated_by_acl_user write Fcreated_by_acl_user;
    property updated_by_acl_user: TAclUser read Fupdated_by_acl_user write Fupdated_by_acl_user;

    procedure Validate; override;
  end;

implementation

uses
  System.SysUtils;

{ TProduct }

constructor TProduct.Create;
begin
  inherited Create;
  Initialize;
end;

destructor TProduct.Destroy;
begin
  if Assigned(Funit)                then Funit.Free;
  if Assigned(Fcategory)            then Fcategory.Free;
  if Assigned(Fbrand)               then Fbrand.Free;
  if Assigned(Fsize)                then Fsize.Free;
  if Assigned(Fstorage_location)    then Fstorage_location.Free;
  if Assigned(Fcreated_by_acl_user) then Fcreated_by_acl_user.Free;
  if Assigned(Fupdated_by_acl_user) then Fupdated_by_acl_user.Free;
  inherited;
end;

procedure TProduct.Initialize;
begin
  Fcreated_at          := now;
  Funit                := TUnit.Create;
  Fcategory            := TCategory.Create;
  Fbrand               := TBrand.Create;
  Fsize                := TSize.Create;
  Fstorage_location    := TStorageLocation.Create;
  Fcreated_by_acl_user := TAclUser.Create;
  Fupdated_by_acl_user := TAclUser.Create;
end;

procedure TProduct.Validate;
var
  lIsInserting: Boolean;
begin
  if Fname.Trim.IsEmpty then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['name']));

  if (Ftenant_id <= 0) then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['tenant_id']));

  if Fsimplified_name.Trim.IsEmpty then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['simplified_name']));

  if (Funit_id <= 0) then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['unit_id']));

  lIsInserting := Fid = 0;
  case lIsInserting of
    True: Begin
      if (Fcreated_by_acl_user_id <= 0) then
        raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['created_by_acl_user_id']));
    end;
    False: Begin
      if (Fupdated_by_acl_user_id <= 0) then
        raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['updated_by_acl_user_id']));
    end;
  end;
end;

end.
