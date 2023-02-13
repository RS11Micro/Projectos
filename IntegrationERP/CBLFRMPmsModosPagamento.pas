unit CBLFRMPmsModosPagamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ActnList, Grids, AdvObj, BaseGrid, AdvGrid, AdvToolBar,
  SBEditProcura,inifiles,sblista,sbcontrolos,adodb, StdCtrls, ExtCtrls,
  AdvPanel,CBLOperInterfaceProtel, AdvUtil, System.Actions;

type
  TFRMCBLPmsModosPagamento = class(TForm)
    epimagem: TSBEditProcura;
    a: TAdvDockPanel;
    AdvToolBar1: TAdvToolBar;
    btSair: TAdvToolBarButton;
    btConfirmar: TAdvToolBarButton;
    ActionList1: TActionList;
    acSair: TAction;
    AcConfirmar: TAction;
    PopupMenu1: TPopupMenu;
    Replicar1: TMenuItem;
    AdvPanel1: TAdvPanel;
    AdvPanel2: TAdvPanel;
    Grelha: TAdvStringGrid;
    Label1: TLabel;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GrelhaRowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);
    procedure GrelhaCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure GrelhaButtonClick(Sender: TObject; ACol, ARow: Integer);
    procedure GrelhaClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure AcConfirmarExecute(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure acSairExecute(Sender: TObject);
    procedure Replicar1Click(Sender: TObject);

  private
    { Private declarations }
     FShemaProtel:string;
     FID_Hotel:Integer;
     FconexaoProtel:string;

     procedure ReplicaHotel(pid_Linha:Integer);
     Procedure SeleccionaPmsHotel(Sender :TObject);
    Procedure FormataGrelha;
    Procedure SeleccionaModosPagamentoProtel(Sender :TObject);
    Function  ObterConexao():Boolean;
    procedure MostraPmsModosPagamento();
    Function  ProximaLinha():Integer;
    Function  dacontasSeleccionados():string;
    Function GravaPmsModosPagamento():Boolean;
  public
    { Public declarations }
   Function  Abreformulario():Boolean;
  end;

var
  FRMCBLPmsModosPagamento: TFRMCBLPmsModosPagamento;

implementation
uses IERPOGLOBAIS,SBBotoes,SBBETabelaDados, SBBaseDados, SBBSSistemaBase;

{$R *.dfm}
Const
    COL_Hotel=0;
  COL_ID_PmsModoPagamento = 1;
  COL_PmsModoPagamento = 2;
  COL_ContaCbl= 3;
  COL_ID_Hotel= 4;

  Col_Max = 5;



Procedure TFRMCBLPmsModosPagamento.FormataGrelha;
var
  i: Integer;
Begin
  with Grelha do
  begin
    ShowHint := True;  
    BeginUpdate;
    Clear;
    FixedCols := 0;
    FixedRows := 1;
    RowCount := 2;
    ColCount := COL_Max;

    ColWidths[COL_ID_PmsModoPagamento] := 70;
    ColWidths[COL_PmsModoPagamento] := 100;
    ColWidths[COL_ContaCbl] := 70;
    ColWidths[COL_ID_Hotel] := 0;
    ColWidths[COL_Hotel] := 80;




    ColWidths[COL_PmsModoPagamento]:= Width - ColWidths[COL_ID_PmsModoPagamento]- ColWidths[COL_Hotel]-ColWidths[COL_ContaCbl]
    -21;


    Options:= [goFixedVertLine] + [goFixedHorzLine] + [goHorzLine] + [goVertLine] + [goEditing];
    With Navigation do
    begin
      AllowDeleteRow:=True;
      AllowInsertRow:=True;
    end;
    Cells[COL_ID_PmsModoPagamento, 0] := SB.Idioma.daTraducao(0, 'Cod.Pms');
    Cells[COL_PmsModoPagamento, 0] := SB.Idioma.daTraducao(0, 'Desc.Pms');
    Cells[COL_ContaCbl, 0] := SB.Idioma.daTraducao(0, 'Conta CBL');
    Cells[COL_Hotel, 0] := SB.Idioma.daTraducao(0, 'Hotel');

    EndUpdate;
  end;
End;



procedure TFRMCBLPmsModosPagamento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
action:=cafree;
end;


Function TFRMCBLPmsModosPagamento.ObterConexao():Boolean;
var
  id_Interface:integer;
begin
   id_Interface:=0;
   Result:=false;
   FShemaProtel:=DevolvechemaPms(id_Interface,FconexaoProtel);
   Result:= id_Interface>0;
end;

Procedure TFRMCBLPmsModosPagamento.SeleccionaModosPagamentoProtel(Sender :TObject);
var
  Obj:TSBSelecaoLista;
Begin
  Obj := TSBSelecaoLista(Sender);
  Try
      If Assigned(Sender) Then
      Begin
        Grelha.Ints[COL_ID_PmsModoPagamento,Grelha.Row]:=Obj.Chave;
        Grelha.Cells[COL_PmsModoPagamento,Grelha.Row]:=Obj.ValorDescricao;
         Grelha.rowcount:=Grelha.rowcount+1;
      End;
   Finally
     FreeAndNil(Obj);
   end;
end;


Function   TFRMCBLPmsModosPagamento.ProximaLinha():Integer;
var
   i:integer;
Begin
   Result:=-1;
   i:=1;
   While (i<= Grelha.Rowcount-1) and (Result=-1) do
   begin
      If Grelha.cells[COL_ID_PmsModoPagamento,i]='' then
         Result:=i;
      Inc(i);
   end;
   If Result=-1 then
   Begin
      Grelha.rowcount:=Grelha.rowcount+1;
      Result:=Grelha.rowcount-1
   end;
end;

procedure TFRMCBLPmsModosPagamento.GrelhaRowChanging(Sender: TObject;
  OldRow, NewRow: Integer; var Allow: Boolean);
begin
RemoveBotaoGrelha(Grelha, COL_PmsModoPagamento, OldRow);
RemoveBotaoGrelha(Grelha, COL_Hotel, OldRow);

  if (NewRow >= Grelha.FixedRows) then
  begin

            AdicionaBotaoGrelha(Grelha, COL_PmsModoPagamento, NewRow, epimagem.BtListaGlyph);

            AdicionaBotaoGrelha(Grelha, COL_Hotel, NewRow, epimagem.BtListaGlyph);

  end;
end;

procedure TFRMCBLPmsModosPagamento.GrelhaCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
canedit:=Acol in[COL_PmsModoPagamento,COL_ContaCbl,col_hotel];
end;


procedure TFRMCBLPmsModosPagamento.MostraPmsModosPagamento();
var
   i:integer;
   query:TAdoQuery;
   strsql:string;
   Connection:TadoConnection;
   ListaCBLPag:Tsbbetabeladados;
begin
   i:=1;
   Try
          strsql:='';
          strsql:='Select * from CBL_ModoPagamentoPMS';
          If FID_Hotel>0 then
                  strsql:=strsql+' where CBL_ModoPagamentoPMS.id_hotel='+inttostr(FID_Hotel);

          ListaCBLPag:=sb.SBBD.AbrirLV(strsql);

          If Not(ListaCBLPag.vazia) then
                  Grelha.rowcount:= ListaCBLPag.NumLinhas+2;

          while Not(ListaCBLPag.nofim) do
          begin
              Grelha.Ints[COL_ID_PmsModoPagamento,i]:=ListaCBLPag.davalor('PMS_ID_ModoPagamento').asinteger;
              Grelha.cells[COL_PmsModoPagamento,i]:=ListaCBLPag.davalor('PMS_ModoPagamento').asstring;
              Grelha.Cells[COL_ContaCbl,i]:=ListaCBLPag.davalor('ContaCBL').asstring;
              Grelha.Cells[COL_ID_Hotel,i]:=ListaCBLPag.davalor('ID_Hotel').asstring;
              Grelha.Cells[COL_Hotel,i]:=ListaCBLPag.davalor('Hotel').asstring;
              inc(i);
              ListaCBLPag.seguinte;
          end;
    Finally
        ListaCBLPag.fecha;
    end;
end;



procedure TFRMCBLPmsModosPagamento.FormCreate(Sender: TObject);
begin
  FormataFormPorDefeito(self);
  FormataBotoes(self);
  FormataGrelha;

end;

Function TFRMCBLPmsModosPagamento.Abreformulario():Boolean;
begin
 Result:=false;
 If  ObterConexao then
 begin
  Result:=true;
  FID_Hotel:=0;
  MostraPmsModosPagamento
 end
 else
 begin
   Result:=false;
   self.close;
 end;

end;

Function  TFRMCBLPmsModosPagamento.dacontasSeleccionados():string;
var i:integer;
begin
 Result:='';
  For i:=1 to Grelha.RowCount-1 do
  begin
     If Grelha.Cells[COL_ID_PmsModoPagamento,i]<>'' then
     Begin
       If Length(result)>0 then
               Result:=Result+',';
       Result:=Result+Grelha.Cells[COL_ID_PmsModoPagamento,i];
     end;
  end;
  If Length(result)>0 then
        Result:='('+Result+')';

end;

procedure TFRMCBLPmsModosPagamento.GrelhaButtonClick(Sender: TObject; ACol,
  ARow: Integer);
var
 filtro:string;
 FiltroHotel:string;
begin

   FiltroHotel:='';
   If FID_Hotel>0 then
          FiltroHotel:=FiltroHotel+' mpehotel='+inttostr(FID_Hotel);

  If Acol = COL_PmsModopagamento then
    Listas.AbrirSQL('ListaPmsPagamentos','', Grelha, SeleccionaModosPagamentoProtel);

  If Acol = COL_Hotel then
    Listas.AbrirSQL('ListaPmsHoteisGeral',FiltroHotel, Grelha, SeleccionaPmsHotel);


end;

Procedure TFRMCBLPmsModosPagamento.SeleccionaPmsHotel(Sender :TObject);
var
  Obj:TSBSelecaoLista;
Begin
  Obj := TSBSelecaoLista(Sender);
  Try
      If Assigned(Sender) Then
      Begin
          Grelha.Ints[COL_ID_Hotel,Grelha.Row]:=Obj.Chave;
        Grelha.Cells[COL_Hotel,Grelha.Row]:=Obj.ValorDescricao;

      End;
   Finally
     FreeAndNil(Obj);
   end;
end;

procedure TFRMCBLPmsModosPagamento.GrelhaClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin

    AdicionaBotaoGrelha(Grelha, COL_PmsModoPagamento, ARow, epimagem.BtListaGlyph);

    AdicionaBotaoGrelha(Grelha, COL_Hotel, ARow, epimagem.BtListaGlyph);

end;


Function TFRMCBLPmsModosPagamento.GravaPmsModosPagamento():Boolean;
var
   i:integer;

   strsql:string;
   Connection:TadoConnection;
   ID_PmsPagamento:integer;
   PmsPagamento:string;
   ContaCbl,id_hotel,hotel:string;


begin
  result:=true;
  sb.SBBD.IniciaTransacao;
   Try
          strsql:='';

          strsql:='Delete from CBL_ModoPagamentoPMS';
          If FID_Hotel>0 then
             strsql:=strsql+' where id_hotel='+Inttostr(Fid_Hotel);
         sb.SBBD.Executa(strsql);

         for i:=1 to Grelha.RowCount-1 do
         Begin

             If  Grelha.Cells[COL_PmsModoPagamento,i]<>'' then
             Begin
              strsql:='';

              ID_PmsPagamento:=Grelha.Ints[COL_Id_PmsModoPagamento,i];
              PmsPagamento:=Grelha.Cells[COL_PmsModoPagamento,i];
              ContaCbl:=Grelha.Cells[COL_ContaCbl,i];
              id_hotel:=Grelha.Cells[COL_Id_Hotel,i];
              hotel:=Grelha.Cells[COL_Hotel,i];


              strsql:= 'INSERT INTO [CBL_ModoPagamentoPMS]'
                   +' ([PMS_ID_ModoPagamento]'
                   +' ,[PMS_ModoPagamento]'
                   +' ,[ContaCBL],id_hotel,hotel)'
                   +' VALUES('
                   +Inttostr(ID_PmsPagamento)
                   +','+#39+ PmsPagamento+#39
                   +','+#39+ ContaCbl+#39
                   +','+#39+ id_hotel+#39
                   +','+#39+ hotel+#39
                   +')';
               sb.SBBD.Executa(strsql);

             end;
         end;
        sb.SBBD.TerminaTransacao;
        Except

             On E: Exception Do
             Begin
                  sb.SBBD.DesfazTransacao;
                raise SB.ErroNormal(0,'CBL_ModoPagamentoPMS','CBL_ModoPagamentoPMS','Não Foi possivel efectuar a Gravação ' + E.Message);
             result:=false;
             End;
        end;

end;


procedure TFRMCBLPmsModosPagamento.AcConfirmarExecute(Sender: TObject);
begin
  screen.cursor:=CrHourGlass;
    Try
     if GravaPmsModosPagamento then
     begin
          //     RegistoLogOperacao(4);
        sb.Dialogos.SBMessage('Dados Gravados com sucesso!');
     end;
    Finally
       screen.cursor:=CrDefault;
   end;
end;

procedure TFRMCBLPmsModosPagamento.btSairClick(Sender: TObject);
begin
 self.close;
end;

procedure TFRMCBLPmsModosPagamento.acSairExecute(Sender: TObject);
begin
 self.close;
end;

procedure TFRMCBLPmsModosPagamento.ReplicaHotel(pid_Linha:Integer);
var
i:integer;
id_hotel,hotel:string;
begin
 id_hotel:=Grelha.cells[col_id_Hotel,pid_Linha];
 hotel:=Grelha.cells[col_Hotel,pid_Linha];
 For i:=pid_Linha+1 to Grelha.RowCount-1 do
 begin
    Grelha.cells[col_id_Hotel,i]:= id_hotel;
    Grelha.cells[col_Hotel,i]:= hotel;

 end;
end;


procedure TFRMCBLPmsModosPagamento.Replicar1Click(Sender: TObject);
begin
 if Grelha.col=col_hotel then
 begin
  ReplicaHotel(Grelha.Row);
 end;
end;

end.
