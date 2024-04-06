unit frmExemplo5U;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.StdCtrls, FMX.Edit, FMX.Controls.Presentation,
  FMX.Layouts, System.Threading, System.Diagnostics, FMX.Objects;

type
  TfrmExemplo5 = class(TForm)
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
  frmExemplo5: TfrmExemplo5;

implementation

{$R *.fmx}

procedure TfrmExemplo5.btnExecutarThreadClick(Sender: TObject);
var
  TaskMae: ITask;
  FutureList: array[0..2] of IFuture<integer>;
begin
  TaskMae := TTask.Create(
  procedure
  var
    Cortina: TRectangle;
    Progress: TAniIndicator;
    TempoFinal: Double;
  begin
    //indicador de processo
    TThread.Synchronize(TThread.CurrentThread, procedure
    begin
      //cria e configura um Trectangle para cortina
      Cortina := TRectangle.Create(application);
      Cortina.Align := TAlignLayout.Contents;
      Cortina.Fill.Color := TAlphacolors.White;
      Cortina.Opacity := 0.7;
      //cria e configura um TAniIndicator para dialogo
      Progress:= TAniIndicator.Create(application);
      Progress.Align := TAlignLayout.Center;
      Progress.Enabled := True;
      //add cortina ao form
      frmExemplo5.AddObject(Cortina);
      //add anim. de espera a cortina
      Cortina.AddObject(Progress);
    end);

    //trabalho 1
    FutureList[0] := TTask.Future<integer>(
      function : integer
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
        result := SW.ElapsedMilliseconds;
      end);

      //trabalho 2
    FutureList[1] := TTask.Future<integer>(
      function : integer
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
        result := SW.ElapsedMilliseconds;
    end);

    //trabalho 3
    FutureList[2] := TTask.Future<integer>(
      function : integer
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
        result := SW.ElapsedMilliseconds;
    end);

     //inicia as tasks utilizando os manipuladores
     FutureList[0].Start;
     FutureList[1].Start;
     FutureList[2].Start;

     //não é possivel usar o waitforall com TFuture, pois já é o comportamento padrao
     //TTask.WaitForAll(FutureList);

     //TFuture.Value faz o papel do wait para aquela thread
     TempoFinal := (FutureList[0].Value+FutureList[1].Value+FutureList[2].Value)/3;

     TThread.Synchronize(TThread.CurrentThread, procedure
     begin
       Progress.Free; //remove progress animation
       Cortina.Free; //remove a cortina
       edtTempo.Text := Format ('%.2f',[TempoFinal]);
       showmessage ('Trabalhos concluidos');
     end);
  end).start; //inicia taskmae
end;

procedure TfrmExemplo5.btnLimparClick(Sender: TObject);
begin
 memResultado.Lines.Clear;
 edtTempo.Text := '';
end;

end.
