unit ERP_FRMProgresso;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvSmoothProgressBar, StdCtrls, Buttons;

type
  TFRMERPProgresso = class(TForm)
    BitBtn1: TBitBtn;
    ProgressBar: TAdvSmoothProgressBar;
    timer: TTimer;
    procedure BitBtn1Click(Sender: TObject);
    procedure timerTimer(Sender: TObject);
  private
    { Private declarations }
  public
  FativaInterface:boolean;
    { Public declarations }
  end;

var
  FRMERPProgresso: TFRMERPProgresso;

implementation

{$R *.dfm}

procedure TFRMERPProgresso.BitBtn1Click(Sender: TObject);
begin
        timer.Enabled:=false;
        FativaInterface:=false;
        close;
end;

procedure TFRMERPProgresso.timerTimer(Sender: TObject);
begin
  FativaInterface:=true;
  ProgressBar.Position := ProgressBar.Position +10;
  if  ProgressBar.Position>=100 then
   close;
end;

end.
