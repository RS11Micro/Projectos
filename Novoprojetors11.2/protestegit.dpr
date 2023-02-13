program protestegit;

uses
  Vcl.Forms,
  Unprincipal in 'Unprincipal.pas' {frmprincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrmprincipal, frmprincipal);
  Application.Run;
end.
