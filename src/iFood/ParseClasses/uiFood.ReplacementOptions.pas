unit uiFood.ReplacementOptions;

interface

uses
  SysUtils, Classes;

Type
  TReplacementOptions = class(TObject)
  private
    Fmode: String;

  protected

  public
    property mode: String read Fmode write Fmode;

  published

  end;

implementation

end.
