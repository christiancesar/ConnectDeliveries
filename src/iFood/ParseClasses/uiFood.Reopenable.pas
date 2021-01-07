unit uiFood.Reopenable;

interface

uses
  SysUtils, Classes;

Type

  TReopenable = class(TObject)
  private
    Fidentifier: String;
    Ftype: String;
    Freopenable: Boolean;
    { private declarations }

  public
    property identifier: String read Fidentifier write Fidentifier;
    property &type: String read Ftype write Ftype;
    property Reopenable: Boolean read Freopenable write Freopenable;

    { public declarations }

  end;

implementation

end.
