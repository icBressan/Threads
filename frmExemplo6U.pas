unit frmExemplo6U;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.StdCtrls, FMX.Edit, FMX.Controls.Presentation,
  FMX.Layouts, System.Threading, System.Diagnostics, FMX.Objects;

type
  TfrmExemplo6 = class(TForm)
    layComandos: TLayout;
    Label1: TLabel;
    edtContador: TEdit;
    btnExecutarThread: TButton;
    btnLimpar: TButton;
    layResultado: TLayout;
    memResultado: TMemo;
    btnResumir: TButton;
    btnSuspender: TButton;
    btnParar: TButton;
    procedure btnExecutarThreadClick(Sender: TObject);
    procedure btnPararClick(Sender: TObject);
    procedure btnResumirClick(Sender: TObject);
    procedure btnSuspenderClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
  private
    { Private declarations }
    procedure Encerramento(Sender: Tobject);
  public
    { Public declarations }
  end;

var
  frmExemplo6: TfrmExemplo6;
  MinhaThreadAnonima: TThread;

implementation

{$R *.fmx}

procedure TfrmExemplo6.btnExecutarThreadClick(Sender: TObject);
begin
  MinhaThreadAnonima := TThread.CreateAnonymousThread(
  procedure
  var
   contador:integer; //conta quantas vezes o trabalho foi realizado
 begin
    contador := 0;
  // repete o trabalho indefinidamente
  // TThread.CheckTerminated lê o valor do flag Terminated da thread atual
  // flag Terminated é definido para true quando chamado a procedure
  // Terminated da thread
  // sempre q houver um loop de trabalho na thread, é importante verificar
  // se o valor do flag Terminated para garantir um mecanismo de parada
  // externo para thread.
  while not TThread.CheckTerminated do begin
    memResultado.Lines.Add('Faz qualquer coisa..');
    Inc(contador);
    //limita  o trabalho da thread (equivalente a um timeout)
    if contador=10 then
     raise Exception.Create('Limite do contador atingido!');

    sleep(900);//simula processamento demorado
  end;

 end);

 //evento disparado quando thread chega ao fim (sai o loop while)
 //associa procedure ENCERRAMENTO ao evento
   MinhaThreadAnonima.OnTerminate := Encerramento;
 //remove thread da memoria automaticamente quando a mesma chegar ao fim
   MinhaThreadAnonima.FreeOnTerminate := True;
 //coloca um "nome" na thread para facilitar o debug (view->Debug Windows->Threads)
   MinhaThreadAnonima.NameThreadForDebugging('MinhaThreadAnonima');
   MinhaThreadAnonima.Start;//inicia a thread
end;

procedure TfrmExemplo6.btnLimparClick(Sender: TObject);
begin
  memResultado.Lines.Clear;
  edtContador.Text := '';
end;

procedure TfrmExemplo6.btnPararClick(Sender: TObject);
begin
//finaliza a thread, necessita que o loop de trabalho verifique o flag terminated
  MinhaThreadAnonima.Terminate;
end;

procedure TfrmExemplo6.btnResumirClick(Sender: TObject);
begin
 //tira da pausa
 MinhaThreadAnonima.Resume;
end;

procedure TfrmExemplo6.btnSuspenderClick(Sender: TObject);
begin
// pausa a thread
  MinhaThreadAnonima.Suspend;
end;

procedure TfrmExemplo6.Encerramento(Sender: Tobject);
var
 error: Exception;
begin
 edtContador.Text := memResultado.Lines.Count.ToString;
 memResultado.Lines.Add('A Thread chegou ao fim!');

 //verifica se ocorreu algum erro na execução do trabalho
 Error := Exception(TThread(Sender).FatalException);
 if error <> nil then begin
   memResultado.Lines.Add('Ocorreu um erro ao executar a thread: ' + Error.Message);
 end;
end;

end.
