unit frmExemplo2U;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.StdCtrls, FMX.Edit, FMX.Controls.Presentation,
  FMX.Layouts, System.Diagnostics, System.Threading;

type
  TfrmExemplo2 = class(TForm)
    layComandos: TLayout;
    Label1: TLabel;
    edtTempo: TEdit;
    btnExecutarThread: TButton;
    btnLimpar: TButton;
    layResultado: TLayout;
    memResultado: TMemo;
    procedure btnExecutarThreadClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmExemplo2: TfrmExemplo2;

implementation

{$R *.fmx}

procedure TfrmExemplo2.btnExecutarThreadClick(Sender: TObject);
begin
//cria uma nova TTask (ITask Interface) para thread
 TTask.Create(
 procedure //uma procedure anonima é necessária para execução
   var t1, t2,t3: Integer; //controle dos loops
    SW:TStopWatch;//medidor de tempo do processamento
 begin
   SW := TStopWatch.Create;
   Sw.Start; //inicia contagem de tempo (de forma precisa)

   // trabalho 1
   for t1 := 0 to 20 do begin
    memResultado.Lines.Add('Trabalho 1: '+t1.ToString);
    sleep(100); //simula processamento demorado
   end;

   // trabalho 2
   for t2 := 0 to 30 do begin
     memResultado.Lines.Add('Trabalho 2: '+t2.ToString);
     sleep(100); //simula processamento demorado
   end;

   // trabalho 3s
   for t3 := 0 to 40 do begin
     memResultado.Lines.Add('Trabalho 3: '+t3.ToString);
     sleep(100); //simula processamento demorado
   end;

   SW.Stop; //para contagem do tempo
   //exibe o tempo gasto para realizar os 3 trabalhos sequencialmente
   edtTempo.Text := SW.ElapsedMilliseconds.ToString;

 end).start; //fim da procedure / inicia o trabalho
 end;

procedure TfrmExemplo2.btnLimparClick(Sender: TObject);
begin
 memResultado.Lines.Clear;
 edtTempo.Text := '';
end;

end.
