program Threads;

uses
  System.StartUpCopy,
  FMX.Forms,
  frmPrincipal in 'frmPrincipal.pas' {frmThreads},
  frmExemplo1U in 'frmExemplo1U.pas' {frmExemplo1},
  frmExemplo2U in 'frmExemplo2U.pas' {frmExemplo2},
  frmExemplo3U in 'frmExemplo3U.pas' {frmExemplo3},
  frmExemplo4U in 'frmExemplo4U.pas' {frmExemplo4},
  frmExemplo6U in 'frmExemplo6U.pas' {frmExemplo6},
  frmExemplo5U in 'frmExemplo5U.pas' {frmExemplo5};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmThreads, frmThreads);
  Application.CreateForm(TfrmExemplo1, frmExemplo1);
  Application.CreateForm(TfrmExemplo2, frmExemplo2);
  Application.CreateForm(TfrmExemplo3, frmExemplo3);
  Application.CreateForm(TfrmExemplo4, frmExemplo4);
  Application.CreateForm(TfrmExemplo6, frmExemplo6);
  Application.CreateForm(TfrmExemplo5, frmExemplo5);
  Application.Run;
end.
