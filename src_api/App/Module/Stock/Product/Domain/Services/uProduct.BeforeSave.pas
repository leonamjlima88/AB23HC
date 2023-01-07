unit uProduct.BeforeSave;

interface

uses
  uProduct,
  uApplication.Types;

type
  IProductBeforeSave = Interface
    ['{B48C8E0C-0CA7-4F53-9700-64D0EB703BBC}']
    function Execute: IProductBeforeSave;
  end;

  TProductBeforeSave = class(TInterfacedObject, IProductBeforeSave)
  private
    FEntity: TProduct;
    FState: TEntityState;
    constructor Create(AEntity: TProduct; AStateEnum: TEntityState);
    function HandleAttributes: IProductBeforeSave;
    function HandleProduct: IProductBeforeSave;
  public
    class function Make(AEntity: TProduct; AStateEnum: TEntityState): IProductBeforeSave;
    function Execute: IProductBeforeSave;
  end;

implementation

uses
  uHlp,
  System.SysUtils;

{ TProductBeforeSave }

constructor TProductBeforeSave.Create(AEntity: TProduct; AStateEnum: TEntityState);
begin
  inherited Create;
  FEntity := AEntity;
  FState  := AStateEnum;
end;

function TProductBeforeSave.Execute: IProductBeforeSave;
begin
  Result := Self;
  HandleAttributes;
end;

function TProductBeforeSave.HandleAttributes: IProductBeforeSave;
begin
  Result := Self;
  HandleProduct;
end;

function TProductBeforeSave.HandleProduct: IProductBeforeSave;
begin
  if FEntity.simplified_name.Trim.IsEmpty then
    FEntity.simplified_name := Copy(FEntity.name,1,30);
end;

class function TProductBeforeSave.Make(AEntity: TProduct; AStateEnum: TEntityState): IProductBeforeSave;
begin
  Result := Self.Create(AEntity, AStateEnum);
end;

end.

