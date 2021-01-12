unit uiFood.Localizer;

interface

uses
  SysUtils, Classes;

Type
  TLocalizer = class(TObject)
  private
    Fid: String;

  protected

  public
    property id: String read Fid write Fid;

  published

  end;

implementation

end.
