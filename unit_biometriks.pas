unit unit_biometriks;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.TeeProcs,
  VCLTee.Chart, Vcl.Buttons, Data.DB, VCLTee.TeeData, Vcl.ExtDlgs, VCLTee.Series,jpeg ;

type
  TForm1 = class(TForm)
  Memo1: TMemo;
  Button1: TButton;
  Image1: TImage;
    Chart1: TChart;
    SeriesDataSet1: TSeriesDataSet;
    BitBtn1: TBitBtn;
    OpenPictureDialog1: TOpenPictureDialog;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;
    BitBtn2: TBitBtn;
  procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

  PRGBTripleArray = ^TRGBTripleArray;
  TRGBTripleArray = array[0..4095] of TRGBTriple;

var
  Form1: TForm1;
  jpeg: TJPEGImage;
  Bitmap : TBitmap;
  hisr,hisg,hisb : array[0..255] of integer;

implementation

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  i2:integer;
begin
if OpenPictureDialog1.Execute then
begin
  jpeg := TJPEGImage.Create;
  jpeg.LoadFromFile(OpenPictureDialog1.FileName);
  jpeg.DIBNeeded;
  image1.Width:=jpeg.Width;
  image1.Height:=jpeg.Height;
  Bitmap:=TBitmap.Create;
  Bitmap.Assign(jpeg);
  Image1.Picture.Assign(Bitmap);

  for i2 := 0 to 255 do
  begin
    hisr[i2]:=0;
    hisg[i2]:=0;
    hisb[i2]:=0;
  end;

  Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
end;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
var R,G,B:word;
i,j:integer;
begin
  for I := 1 to Bitmap.Width -1 do
  begin
    for j := 1 to Bitmap.Height -1 do
      begin
        R:=GetRValue(Bitmap.Canvas.Pixels[i,j]);
        G:=GetGValue(Bitmap.Canvas.Pixels[i,j]);
        B:=GetBValue(Bitmap.Canvas.Pixels[i,j]);

        inc(hisr[R]);
        inc(hisg[G]);
        inc(hisb[B]);

      end;
  end;
  Series1.Clear;
  Series2.Clear;
  Series3.Clear;

  for I := 1 to 255 do
    begin
      series1.AddXY(i,hisr[i],'',clRed);
      series2.AddXY(i,hisg[i],'',clGreen);
      series3.AddXY(i,hisb[i],'',clBlue);
    end;

end;

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
