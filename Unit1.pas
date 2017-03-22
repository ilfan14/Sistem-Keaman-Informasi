unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.TeeProcs,
  VCLTee.Chart;

type
  TForm1 = class(TForm)
  Memo1: TMemo;
  Button1: TButton;
  Image1: TImage;
    Chart1: TChart;
  procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

  PRGBTripleArray = ^TRGBTripleArray;
  TRGBTripleArray = array[0..4095] of TRGBTriple;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  C: TColor;
  X: Integer;
  Y: Integer;
  Bitmap: TBitmap;
  Pixels: PRGBTripleArray;
begin
   Bitmap := TBitmap.Create;
   Bitmap.Assign(Image1.Picture.Graphic);
   Memo1.Lines.BeginUpdate;
    for Y := 0 to Bitmap.Height - 1 do
      begin
        Pixels := Bitmap.ScanLine[Y];
        for X := 0 to Bitmap.Width - 1 do
        begin
            C := RGB(
              Pixels[X].rgbtRed,
              Pixels[X].rgbtGreen,
              Pixels[X].rgbtBlue
            );
            Memo1.Lines.Add(
              '===============' + sLineBreak +
              'Pixel[' + IntToStr(X) + '; ' + IntToStr(Y) + ']' + sLineBreak +
              'Color: ' + ColorToString(C) + sLineBreak +
              'Red channel: ' + IntToStr(Pixels[X].rgbtRed) + sLineBreak +
              'Green channel: ' + IntToStr(Pixels[X].rgbtGreen) + sLineBreak +
              'Blue channel: ' + IntToStr(Pixels[X].rgbtBlue)
            );
        end;
      end;
     Memo1.Lines.EndUpdate;
   Bitmap.Free;
end;

end.
