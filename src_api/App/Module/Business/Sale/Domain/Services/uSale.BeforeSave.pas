unit uSale.BeforeSave;

interface

uses
  uSale,
  uApplication.Types,
  uSaleItem;

type
  ISaleBeforeSave = Interface
    ['{22D5E425-6761-4769-8D39-236537CBFD81}']
    function Execute: ISaleBeforeSave;
  end;

  TSaleBeforeSave = class(TInterfacedObject, ISaleBeforeSave)
  private
    FEntity: TSale;
    FState: TEntityState;
    constructor Create(AEntity: TSale; AStateEnum: TEntityState);
    function HandleAttributes: ISaleBeforeSave;
    function HandleSale: ISaleBeforeSave;
    function HandleSaleItem(AEntity: TSaleItem): ISaleBeforeSave;
    function HandleSaleItemList: ISaleBeforeSave;
  public
    class function Make(AEntity: TSale; AStateEnum: TEntityState): ISaleBeforeSave;
    function Execute: ISaleBeforeSave;
  end;

implementation

uses
  uHlp,
  System.SysUtils;

{ TSaleBeforeSave }

constructor TSaleBeforeSave.Create(AEntity: TSale; AStateEnum: TEntityState);
begin
  inherited Create;
  FEntity := AEntity;
  FState  := AStateEnum;
end;

function TSaleBeforeSave.Execute: ISaleBeforeSave;
begin
  Result := Self;
  HandleAttributes;
end;

function TSaleBeforeSave.HandleAttributes: ISaleBeforeSave;
begin
  Result := Self;
  HandleSale;
  HandleSaleItemList;
end;

function TSaleBeforeSave.HandleSale: ISaleBeforeSave;
begin
//
end;

function TSaleBeforeSave.HandleSaleItem(AEntity: TSaleItem): ISaleBeforeSave;
begin
//
end;

function TSaleBeforeSave.HandleSaleItemList: ISaleBeforeSave;
var
  lSaleItem: TSaleItem;
begin
  for lSaleItem in FEntity.sale_item_list do
    HandleSaleItem(lSaleItem);
end;

class function TSaleBeforeSave.Make(AEntity: TSale; AStateEnum: TEntityState): ISaleBeforeSave;
begin
  Result := Self.Create(AEntity, AStateEnum);
end;

end.

