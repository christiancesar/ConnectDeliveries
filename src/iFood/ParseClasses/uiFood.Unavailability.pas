unit uiFood.Unavailability;

interface

uses
  SysUtils, Classes;

Type

  TUnavailability = class(TObject)
  private
    FstoreId: String;
    Fid: String;
    FauthorId: String;
    Fstart: String;
    Fdescription: String;
    Fend: String;
    { private declarations }

  public
    property id: String read Fid write Fid;
    property storeId: String read FstoreId write FstoreId;
    property description: String read Fdescription write Fdescription;
    property authorId: String read FauthorId write FauthorId;
    property start: String read Fstart write Fstart;
    property &end: String read Fend write Fend;
    { public declarations }

  end;

implementation

end.
