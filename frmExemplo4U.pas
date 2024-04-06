unit frmExemplo4U;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.StdCtrls, FMX.Edit, FMX.Controls.Presentation,
  FMX.Layouts, System.Threading, System.Diagnostics, FMX.Objects;

type
  TfrmExemplo4 = class(TForm)
    layComandos: TLayout;
    Label1: TLabel;
    edtTempo: TEdit;
    btnExecutarThread: TButton;
    btnLimpar: TButton;
    btnMedTempo: TButton;
    layResultado: TLayout;
    memResultado: TMemo;
    procedure btnExecutarThreadClick(Sender: TObject);
    procedure btnMedTempoClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmExemplo4: TfrmExemplo4;
  Tempo1, Tempo2, Tempo3: Integer;

implementation

{$R *.fmx}

procedure TfrmExemplo4.btnExecutarThreadClick(Sender: TObject);
var
  TaskMae: ITask;
  TaskList: array[0..2] of ITask;
begin
//  Como usaremos o WaitForAll para esperar todos os trabalhos serem
//  concluidos para só depois remover o dialogo de espera (AniIndicator),
//  a taskmae é necessaria para não travar a interface com o usuario e o
//  programa para de responder

  TaskMae := TTask.Create (procedure
  var
    Cortina: TRectangle;
    Progress: TAniIndicator;
  begin
    // indicador de processo
    TThread.Synchronize(TThread.CurrentThread, procedure
    begin
      //cria e configura um TRectangle para cortina
      Cortina := TRectangle.Create(application);
      Cortina.Align := TAlignLayout.Contents;
      Cortina.Fill.Color := TAlphaColors.White;
      Cortina.Opacity := 0.7;
      //cria e configura um TAniIndicator para dialogo
      Progress := TAniIndicator.Create(application);
      Progress.Align := TAlignLayout.Center;
      Progress.Enabled := True;
      //add cortina ao form
      frmExemplo4.AddObject(Cortina);
      //add anime. de espera a cortina
      Cortina.AddObject(Progress);
    end);

    //trabalho 1
    TaskList[0] := TTask.Create(
      procedure
      var
        trabalho: Integer;
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
    TaskList[1] := TTask.Create(
      procedure
      var
        trabalho: Integer;
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
    TaskList[2] := TTask.Create(
      procedure
      var
        trabalho: Integer;
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

      //Inicia as Tasks utilizando os manipuladores
      TaskList[0].Start;
      TaskList[1].Start;
      TaskList[2].Start;

      //suspende (trava) a thread mãe e aguarda TODAS as threads do vetor (TaskList) terminarem
      TTask.WaitForAll(TaskList);
      //trava a thread mae e aguarda QUALQUER thread do vetor terminar
//    TTask.WaitForAny(TaskList);

      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        Progress.Free; //remove progress animation
        Cortina.Free; // remove a cortina
        Showmessage('Trabalhos concluidos');
      end);

    end).start; //inicia taskmae
    end;

procedure TfrmExemplo4.btnLimparClick(Sender: TObject);
begin
 memResultado.Lines.Clear;
 edtTempo.Text := '';
end;

procedure TfrmExemplo4.btnMedTempoClick(Sender: TObject);
begin
  edtTempo.Text := format('%.2f ms', [(tempo1+tempo2+tempo3)/3]);
end;

end.
