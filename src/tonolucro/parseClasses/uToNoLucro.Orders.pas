unit uToNoLucro.Orders.Live;

interface

uses
SysUtils, Classes, System.Generics.Collections;

Type

  TOrders = class(TObject)
  private
    { private declarations }

  public
    { public declarations }
    property items: TObjectList<TOrder> read Fitems write Fitems;
    property meta: TMeta read Fmeta write Fmeta;
    property links: TStrings read Flinks write Flinks;

    constructor Create;
    destructor Destroy; override;
  end;
    
implementation
    


    
end.