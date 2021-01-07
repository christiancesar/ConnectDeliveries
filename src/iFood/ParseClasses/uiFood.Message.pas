unit uiFood.Message;

interface

uses
  SysUtils, Classes;

Type

  TMessage = class(TObject)
  private
    Fsubtitle: String;
    Ftitle: String;
    Fdescription: String;
    Fpriority: Integer;
    { private declarations }

  public
    property title: String read Ftitle write Ftitle;
    property subtitle: String read Fsubtitle write Fsubtitle;
    property description: String read Fdescription write Fdescription;
    property priority: Integer read Fpriority write Fpriority;
    { public declarations }

  end;

implementation

end.
