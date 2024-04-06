unit frmExemplo1U;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.StdCtrls, FMX.Edit, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  FMX.Layouts, System.Diagnostics;

type
  TfrmExemplo1 = class(TForm)
    layComandos: TLayout;
    layResultado: TLayout;
    memResultado: TMemo;
    Label1: TLabel;
    edtTempo: TEdit;
    btnExecutar: TButton;
    btnLimpar: TButton;
    procedure btnExecutarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmExemplo1: TfrmExemplo1;

implementation

{$R *.fmx}

procedure TfrmExemplo1.btnExecutarClick(Sender: TObject);
var t1, t2, t3: Integer;
    SW:TStopWatch;
begin
  SW := TStopWatch.Create;
  SW.Start; // inicia contagem de tempo (de forma precisa)

  //trabalho 1
  for t1 := 0 to 30 do begin
    memResultado.Lines.Add('Trabalho 1: '+t1.ToString);
    sleep(100); //simula processamento demorado
  end;

  //trabalho 2
  for t2 := 0 to 30 do begin
    memResultado.Lines.Add('Trabalho 2: '+t2.ToString);
    sleep(100); //simula processamento demorado
  end;

  //trabalho 3
  for t3 := 0 to 30 do begin
    memResultado.Lines.Add('Trabalho 3: '+t3.ToString);
    sleep(100); //simula processamento demorado
  end;

  SW.Stop; //para contagem do tempo
  //exibe o tempo gasto para realizar os 3 trabalhos sequencialmente
  edtTempo.Text := SW.ElapsedMilliseconds.ToString;
end;

procedure TfrmExemplo1.btnLimparClick(Sender: TObject);
begin
 memResultado.Lines.Clear;
 edtTempo.Text := '';
end;

end.
