unit frmExemplo3U;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.StdCtrls, FMX.Edit, FMX.Controls.Presentation,
  FMX.Layouts, System.Threading, System.Diagnostics;

type
  TfrmExemplo3 = class(TForm)
    layComandos: TLayout;
    Label1: TLabel;
    edtTempo: TEdit;
    btnExecutarThread: TButton;
    btnLimpar: TButton;
    layResultado: TLayout;
    memResultado: TMemo;
    btnMedTempo: TButton;
    procedure btnExecutarThreadClick(Sender: TObject);
    procedure btnMedTempoClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmExemplo3: TfrmExemplo3;
  Tempo1,Tempo2,Tempo3: Integer;

implementation

{$R *.fmx}

procedure TfrmExemplo3.btnExecutarThreadClick(Sender: TObject);
var
 Task1,Task2,Task3: ITask;
begin
 //trabalho 1
 Task1 := TTask.Create(
 procedure
  var
    trabalho: integer;
    SW: TStopWatch;
  begin
    SW := TStopWatch.Create;
    SW.Start; // inicia a contagem de tempo (de forma precisa)

    for trabalho := 0 to 20 do begin
      TThread.Queue(TThread.CurrentThread, procedure begin
        memResultado.Lines.Add('Trabalho 1: '+trabalho.ToString);
      end);
      sleep(100); // simula processamento demorado
      end;

      SW.Stop; // para contagem de tempo
      TThread.Queue(TThread.CurrentThread, procedure begin
        memResultado.Lines.Add('Trabalho 1 concluido em '+SW.ElapsedMilliseconds.ToString)
      end);
      Tempo1 := SW.ElapsedMilliseconds;
  end);

 //trabalho 2
 Task2 := TTask.Create(
 procedure
  var
    trabalho: integer;
    SW: TStopWatch;
  begin
    SW := TStopWatch.Create;
    SW.Start; // inicia a contagem de tempo (de forma precisa)

    for trabalho := 0 to 30 do begin
      TThread.Queue(TThread.CurrentThread, procedure begin
        memResultado.Lines.Add('Trabalho 2: '+trabalho.ToString);
      end);
      sleep(100); // simula processamento demorado
      end;

      SW.Stop; // para contagem de tempo
      TThread.Queue(TThread.CurrentThread, procedure begin
        memResultado.Lines.Add('Trabalho 2 concluido em '+SW.ElapsedMilliseconds.ToString)
      end);
      Tempo2 := SW.ElapsedMilliseconds;
  end);

//trabalho 3
 Task3 := TTask.Create(
 procedure
  var
    trabalho: integer;
    SW: TStopWatch;
  begin
    SW := TStopWatch.Create;
    SW.Start; // inicia a contagem de tempo (de forma precisa)

    for trabalho := 0 to 40 do begin
      TThread.Queue(TThread.CurrentThread, procedure begin
        memResultado.Lines.Add('Trabalho 3: '+trabalho.ToString);
      end);
      sleep(100); // simula processamento demorado
      end;

      SW.Stop; // para contagem de tempo
      TThread.Queue(TThread.CurrentThread, procedure begin
        memResultado.Lines.Add('Trabalho 3 concluido em '+SW.ElapsedMilliseconds.ToString)
      end);
      Tempo3 := SW.ElapsedMilliseconds;
  end);

  //inicia as tasks utilizando os manipuladores
  Task1.Start;
  Task2.Start;
  Task3.Start;
end;

procedure TfrmExemplo3.btnLimparClick(Sender: TObject);
begin
 memResultado.Lines.Clear;
 edtTempo.Text := '';
end;

procedure TfrmExemplo3.btnMedTempoClick(Sender: TObject);
begin
  edtTempo.Text := format('%.2f ms', [(tempo1+tempo2+tempo3)/3]);
end;

end.
