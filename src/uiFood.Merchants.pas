unit uiFood.Merchants;

interface
uses
  System.Generics.Collections;
Type
  TMerchant = class(TObject)
  private
    Fname: String;
    Fid: String;
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    property id: String read Fid write Fid;
    property name: String read Fname write Fname;
  published
    { published declarations }
  end;

implementation

end.
