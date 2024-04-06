unit frmPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation;

type
  TfrmThreads = class(TForm)
    btnExemplo1: TButton;
    btnExemplo2: TButton;
    btnExemplo3: TButton;
    btnExemplo4: TButton;
    btnExemplo5: TButton;
    btnExemplo6: TButton;
    Label1: TLabel;
    procedure btnExemplo1Click(Sender: TObject);
    procedure btnExemplo2Click(Sender: TObject);
    procedure btnExemplo3Click(Sender: TObject);
    procedure btnExemplo4Click(Sender: TObject);
    procedure btnExemplo5Click(Sender: TObject);
    procedure btnExemplo6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmThreads: TfrmThreads;

implementation
uses frmExemplo1U,frmExemplo2U,frmExemplo3U,frmExemplo4U,frmExemplo5U,frmExemplo6U;

{$R *.fmx}

procedure TfrmThreads.btnExemplo1Click(Sender: TObject);
begin
 frmExemplo1.show;
end;

procedure TfrmThreads.btnExemplo2Click(Sender: TObject);
begin
 frmExemplo2.show;
end;

procedure TfrmThreads.btnExemplo3Click(Sender: TObject);
begin
 frmExemplo3.show;
end;

procedure TfrmThreads.btnExemplo4Click(Sender: TObject);
begin
 frmExemplo4.show;
end;

procedure TfrmThreads.btnExemplo5Click(Sender: TObject);
begin
 frmExemplo5.Show;
end;

procedure TfrmThreads.btnExemplo6Click(Sender: TObject);
begin
 frmExemplo6.Show;
end;

end.
