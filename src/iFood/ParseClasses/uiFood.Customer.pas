unit uiFood.Customer;

interface

uses
  SysUtils, Classes;

Type
  TCustomer = class(TObject)
  private
    Fname: String;
    FtaxPayerIdentificationNumber: Integer;
    Fuuid: String;
    Fphone: String;
    Fid: String;
    FordersCountOnRestaurant: Integer;

  public
    property id: String read Fid write Fid;
    property uuid: String read Fuuid write Fuuid;
    property name: String read Fname write Fname;
    property phone: String read Fphone write Fphone;
    property ordersCountOnRestaurant: Integer read FordersCountOnRestaurant
      write FordersCountOnRestaurant;
    property taxPayerIdentificationNumber: Integer
      read FtaxPayerIdentificationNumber write FtaxPayerIdentificationNumber;

  published

  end;

implementation


end.
