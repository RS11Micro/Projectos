unit CBLFRMPmsTipoDoc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ActnList, Grids, AdvObj, BaseGrid, AdvGrid, AdvToolBar,
  SBEditProcura,inifiles,sblista,adodb,sbcontrolos,CBLFrmPmsContasFamilia,
  pngimage,CBLOperInterfaceProtel;

type
  TFRMCBLPmsTipoDoc = class(TForm)
    epimagem: TSBEditProcura;
    a: TAdvDockPanel;
    AdvToolBar1: TAdvToolBar;
    btSair: TAdvToolBarButton;
    btConfirmar: TAdvToolBarButton;
    Grelha: TAdvStringGrid;
    ActionList1: TActionList;
    acSair: TAction;
    AcConfirmar: TAction;
    PopupMenu1: TPopupMenu;
    BtContas: TAdvToolBarButton;
    procedure GrelhaRowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);
    procedure GrelhaButtonClick(Sender: TObject; ACol, ARow: Integer);
    procedure GrelhaClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AcConfirmarExecute(Sender: TObject);
    procedure acSairExecute(Sender: TObject);
    procedure GrelhaCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure GrelhaGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure BtContasClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
     FShemaProtel:string;
     FItemsnatureza:tstringList;
     FEntradaConFContasPorTipoDoc:Boolean;
     FlinhaSageCNC:Boolean;
     FID_Hotel:Integer;
     FconexaoProtel:string;
    Function DaNomeHotel(pID_TipoDocvnd:string;Var pID_Hotel:integer):string;
    Procedure GravaHotelTipodocHotelZero();
    Procedure GravaHotel(pID_TipodocPms,pID_Hotel:Integer);
    Procedure FormataGrelha;
    Procedure SeleccionaPmsTipoDocProtel(Sender :TObject);
    Function ObterConexao():Boolean;
    procedure MostraPmsPmsTipoDoc();
    Function  ProximaLinha():Integer;
    Function  dacontasSeleccionados():string;
    function GravaPmsPmsTipoDoc():boolean;
    Function  ValidaGravacao():Boolean;


  public
    { Public declarations }
    Function  Abreformulario():Boolean;

    Property EntradaConFContasPorTipoDoc:boolean read FEntradaConFContasPorTipoDoc write FEntradaConFContasPorTipoDoc;
    Property linhaSageCNC:boolean read FlinhaSageCNC write FlinhaSageCNC;

  end;

var
  FRMCBLPmsTipoDoc: TFRMCBLPmsTipoDoc;

implementation
uses IERPOGLOBAIS,SBBotoes,SBBETabelaDados, SBBaseDados, SBBSSistemaBase;

{$R *.dfm}
Const

  COL_ID_PmsTipoDoc = 0;
  COL_PmsTipoDoc = 1;
  COL_PmsID_Hotel = 2;
  COL_PmsHotel = 3;
  COL_ContaCbl= 4;
  COL_Natureza= 5;
  COL_Natureza1= 6;
  COL_NaturezaPag= 7;
  COL_NaturezaPag1= 8;
  COL_NaturezaTipoDoc= 9;
  COL_NCIVAPERIODO=10;
  COL_AbrevSerie= 11;
  COL_SerieERP= 12;
  Col_Max = 13;





Procedure TFRMCBLPmsTipoDoc.FormataGrelha;
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

    ColWidths[COL_ID_PmsTipoDoc] := 60;
    ColWidths[COL_PmsTipoDoc] := 200;
    ColWidths[COL_PmsID_Hotel] := 50;

    ColWidths[COL_PmsHotel] := 100;

    ColWidths[COL_ContaCbl] := 70;
    ColWidths[COL_NaturezaTipoDoc] := 70;
    ColWidths[COL_NCIVAPERIODO] := 50;

    ColWidths[COL_AbrevSerie] := 0;
    ColWidths[COL_SerieERP] := 0;



    ColWidths[COL_Natureza] := 50;
    ColWidths[COL_Natureza1] := 50;
    ColWidths[COL_NaturezaPag] := 50;
    ColWidths[COL_NaturezaPag1] := 50;





    ColWidths[COL_PmsTipoDoc]:= Width - colWidths[COL_PmsID_Hotel]-ColWidths[COL_AbrevSerie]-ColWidths[COL_PmsHotel] -ColWidths[COL_NaturezaTipoDoc]-ColWidths[COL_ID_PmsTipoDoc]- ColWidths[COL_ContaCbl]
        -ColWidths[COL_Natureza]-    ColWidths[COL_Natureza1]-ColWidths[COL_NCIVAPERIODO]-
        ColWidths[COL_NaturezaPag]-
        ColWidths[COL_NaturezaPag1]- ColWidths[COL_SerieERP]-21;


    Options:= [goFixedVertLine] + [goFixedHorzLine] + [goHorzLine] + [goVertLine] + [goEditing];
    If not(EntradaConFContasPorTipoDoc) then
    begin
        With Navigation do
        begin
          AllowDeleteRow:=True;
          AllowInsertRow:=True;
        end;
    end;

    Cells[COL_PmsID_Hotel, 0] := SB.Idioma.daTraducao(0, 'ID_Hotel');
    Cells[COL_SerieERP, 0] := SB.Idioma.daTraducao(0, 'Serie ERP');
    Cells[COL_AbrevSerie, 0] := SB.Idioma.daTraducao(0, 'A.Serie');
    Cells[COL_PmsHotel, 0] := SB.Idioma.daTraducao(0, 'Hotel');
    Cells[COL_ID_PmsTipoDoc, 0] := SB.Idioma.daTraducao(0, 'Cod.Pms');
    Cells[COL_PmsTipoDoc, 0] := SB.Idioma.daTraducao(0, 'Desc.Pms');
    Cells[COL_ContaCbl, 0] := SB.Idioma.daTraducao(0, 'Conta CBL');
    Cells[COL_Natureza, 0] := SB.Idioma.daTraducao(0, 'Natureza  >=0');
    Cells[COL_Natureza1, 0] := SB.Idioma.daTraducao(0, 'Natureza  <0');
    Cells[COL_NaturezaPag, 0] := SB.Idioma.daTraducao(0, 'Nat.Pag. >=0');
    Cells[COL_NaturezaPag1, 0] := SB.Idioma.daTraducao(0, 'Nat.Pag. <0');
    Cells[COL_NaturezaTipoDoc, 0] := SB.Idioma.daTraducao(0, 'Nat.Doc.');
    Cells[COL_NCIVAPERIODO, 0] := SB.Idioma.daTraducao(0, 'NC.Periodo IVA');

    Grelha.SortByColumn(COL_PmsHotel);


    EndUpdate;
  end;
End;





Function TFRMCBLPmsTipoDoc.ObterConexao():Boolean;
var
  id_Interface:integer;
begin
   id_Interface:=0;
   Result:=false;
   FShemaProtel:=DevolvechemaPms(id_Interface,FconexaoProtel);
   Result:= id_Interface>0;
end;

Procedure TFRMCBLPmsTipoDoc.SeleccionaPmsTipoDocProtel(Sender :TObject);
var
  Obj:TSBSelecaoLista;
Begin
  Obj := TSBSelecaoLista(Sender);
  Try
      If Assigned(Sender) Then
      Begin
        Grelha.Ints[COL_ID_PmsTipoDoc,Grelha.Row]:=Obj.Chave;
        Grelha.Cells[COL_PmsTipoDoc,Grelha.Row]:=Obj.ValorDescricao;
        Grelha.Cells[COL_PmsHotel,Grelha.Row]:=Obj.ListaValores.AtributoValor['Hotel'].asstring;
        Grelha.Cells[COL_PmsID_Hotel,Grelha.Row]:=Obj.ListaValores.AtributoValor['mpehotel'].asstring;

                   Grelha.addCheckBox(COL_NCIVAPERIODO,Grelha.Row, false,false);
        
         Grelha.rowcount:=Grelha.rowcount+1;
      End;
   Finally
     FreeAndNil(Obj);
   end;
end;


Function   TFRMCBLPmsTipoDoc.ProximaLinha():Integer;
var
   i:integer;
Begin
   Result:=-1;
   i:=1;
   While (i<= Grelha.Rowcount-1) and (Result=-1) do
   begin
      If Grelha.cells[COL_ID_PmsTipoDoc,i]='' then
         Result:=i;
      Inc(i);
   end;
   If Result=-1 then
   Begin
      Grelha.rowcount:=Grelha.rowcount+1;
      Result:=Grelha.rowcount-1
   end;
end;

Function TFRMCBLPmsTipoDoc.DaNomeHotel(pID_TipoDocvnd:string;Var pID_Hotel:integer):string;
var
SQL:string;
Lista:tsbbetabeladados;

begin


     SQL := ' Select   Ref,text,lizenz.mpehotel,lizenz.short as Hotel'
          + ' from '+FShemaProtel+'fiscalcd'
          + ' inner join  '+FShemaProtel+'lizenz on   '
         +'lizenz.mpehotel= fiscalcd.mpehotel'
          +' Where REf='+#39+pID_TipoDocvnd+#39;
      Lista:=sb.SBBD.AbrirLV(SQL);
      Result:=Lista.davalor('Hotel').asstring;
      pID_Hotel:=Lista.davalor('mpehotel').asinteger;
      FreeAndnil(Lista);
end;

procedure TFRMCBLPmsTipoDoc.MostraPmsPmsTipoDoc();
var
   i:integer;

   strsql:string;

   LID_Hotel:Integer;
   ListaTipodocCBLPMS:Tsbbetabeladados;
begin
   LID_Hotel:=0;


   i:=1;
   Try
          strsql:='';

          strsql:='Select * from CBL_TipoDocPMS';
          If FID_Hotel>0 then
             strsql:=strsql+' where CBL_TipoDocPMS.id_hotel='+inttostr(FID_Hotel);
          ListaTipodocCBLPMS:=sb.SBBD.AbrirLV(strsql);
          If Not(ListaTipodocCBLPMS.vazia) then
                  Grelha.rowcount:= ListaTipodocCBLPMS.NumLinhas+2;
          ListaTipodocCBLPMS.Inicio;
          while Not(ListaTipodocCBLPMS.NoFim) do
          begin

              If  ListaTipodocCBLPMS.davalor('Natureza').asstring<>'' then
              begin
                  Grelha.Cells[COL_Natureza, i] := ListaTipodocCBLPMS.davalor('Natureza').asstring;
              end;
              If  ListaTipodocCBLPMS.davalor('NaturezaNeg').asstring<>'' then
              begin
                  Grelha.Cells[COL_Natureza1, i] := ListaTipodocCBLPMS.davalor('NaturezaNeg').asstring;
              end;

              If  ListaTipodocCBLPMS.davalor('NaturezaPag').asstring<>'' then
              begin
                  Grelha.Cells[COL_NaturezaPag, i] := ListaTipodocCBLPMS.davalor('NaturezaPag').asstring;
              end;


              If  ListaTipodocCBLPMS.davalor('NaturezaPagNeg').asstring<>'' then
              begin
                  Grelha.Cells[COL_NaturezaPag1, i] := ListaTipodocCBLPMS.davalor('NaturezaPagNeg').asstring;
              end;

              If  ListaTipodocCBLPMS.davalor('NaturezaTipoDoc').asstring<>'' then
              begin
                  Grelha.Cells[COL_NaturezaTipoDoc, i] := ListaTipodocCBLPMS.davalor('NaturezaTipoDoc').asstring;
              end;

              Grelha.addCheckBox(COL_NCIVAPERIODO,i, ListaTipodocCBLPMS.davalor('NotaCreditoControlaPeriodoIVA').asboolean,false);

              Grelha.Ints[COL_ID_PmsTipoDoc,i]:=ListaTipodocCBLPMS.davalor('PMS_ID_TipoDoc').asinteger;
              Grelha.cells[COL_PmsTipoDoc,i]:=ListaTipodocCBLPMS.davalor('PMS_TipoDoc').asstring;
              Grelha.Cells[COL_ContaCbl,i]:=ListaTipodocCBLPMS.davalor('ContaCBL').asstring;
              
              Grelha.Cells[COL_AbrevSerie,i]:=ListaTipodocCBLPMS.davalor('AbrevSerie').asstring;
              Grelha.Cells[COL_SerieERP,i]:=ListaTipodocCBLPMS.davalor('SerieERP').asstring;
                Grelha.ints[COL_PmsID_Hotel,i]:=ListaTipodocCBLPMS.davalor('ID_Hotel').asinteger;
              Grelha.Cells[COL_PmsHotel,i]:= DaNomeHotel(ListaTipodocCBLPMS.davalor('PMS_ID_TipoDoc').asstring,LID_Hotel);
              If LID_Hotel>0 then
                  Grelha.ints[COL_PmsID_Hotel,i]:=LID_Hotel;
              inc(i);
              ListaTipodocCBLPMS.seguinte;
          end;
    Finally
       ListaTipodocCBLPMS.Fecha;
       Freeandnil(ListaTipodocCBLPMS);
       Grelha.SortByColumn(COL_PmsHotel);
    end;
end;



Function  TFRMCBLPmsTipoDoc.dacontasSeleccionados():string;
var i:integer;
begin
  Result:='';
  For i:=1 to Grelha.RowCount-1 do
  begin
     If Grelha.Cells[COL_ID_PmsTipoDoc,i]<>'' then
     Begin
       If Length(result)>0 then
               Result:=Result+',';
       Result:=Result+Grelha.Cells[COL_ID_PmsTipoDoc,i];
     end;
  end;
  If Length(result)>0 then
        Result:='('+Result+')';

end;

procedure TFRMCBLPmsTipoDoc.GrelhaButtonClick(Sender: TObject; ACol,
  ARow: Integer);
var

 filtro:string;
begin

 filtro:=dacontasSeleccionados;
 If Length(filtro)>0 then
     filtro:='fiscalcd.Ref not in'+ filtro;

 If FID_Hotel>0 then
 begin
     If Length(filtro)>0 then
       filtro:=filtro+' and ';
     filtro:='fiscalcd.mpehotel='+Inttostr(FID_Hotel);

 end;

  If Acol = COL_PmsTipoDoc then
    Listas.AbrirSQL('ListaPmsTipoDocCBL',filtro, Grelha, SeleccionaPmsTipoDocProtel)
end;



Function   TFRMCBLPmsTipoDoc.validagravacao():Boolean;
var
erros:string;
i:integer;
begin

  result:=true;
  for i:=1 to Grelha.RowCount-1 do
  Begin
      If  Grelha.Cells[COL_PmsTipoDoc,i]<>'' then
      Begin
        If  ((Grelha.Cells[COL_Natureza,i]='') or    (Grelha.Cells[COL_NaturezaTipoDoc,i]='')or
            (Grelha.Cells[COL_Natureza1,i]='') or (Grelha.Cells[COL_Naturezapag,i]='')
            or (Grelha.Cells[COL_Naturezapag1,i]='')) then
        begin
            If  erros<>'' then
            begin
              erros:=erros+#13;
            end;
            erros:='Naturezas';
        end;
        If  Grelha.Cells[COL_ContaCbl,i]='' then
        begin
            If  erros<>'' then
            begin
              erros:=erros+#13;
            end;
            erros:='ContaCBL';
        end;
      end;
  end;
  If erros<>'' then
  begin
   result:=false;
   sb.Dialogos.SBAviso('Não foi possível gravar'+#13+'Preencha os seguintes dados:'+#13+erros);
  end;
end;

function TFRMCBLPmsTipoDoc.GravaPmsPmsTipoDoc():boolean;
var
   i:integer;
   query:TAdoQuery;
   strsql:string;
   Connection:TadoConnection;
   ID_PmsTipoDoc:integer;
   PmsTipoDoc:string;
   ContaCbl,AbrevSerie,
    Natureza:string;
    NaturezaNeg:string;
    NaturezaPag:string;
    NaturezaPagNeg:string;
    NaturezaTipoDoc:string;
    SerieERP:string;
    ID_Hotel:string;
    NotaCreditoControlaPeriodoIVA:Boolean;
    ListaTipodocPMS:tsbbetabeladados;

begin
If validagravacao then
begin

    strsql:='';
    strsql:='Delete from CBL_TipoDocPMS';
    If FID_Hotel>0 then
      strsql:=strsql+' where CBL_TipoDocPMS.id_hotel='+inttostr(FID_Hotel);
    sb.SBBD.Executa(strsql);
    sb.SBBD.IniciaTransacao;
    try
    for i:=1 to Grelha.RowCount-1 do
    Begin

        If  Grelha.Cells[COL_PmsTipoDoc,i]<>'' then
        Begin
         strsql:='';

         ID_PmsTipodoc:=Grelha.Ints[COL_Id_PmsTipoDoc,i];
         PmsTipoDoc:=Grelha.Cells[COL_PmsTipoDoc,i];
         ContaCbl:=Grelha.Cells[COL_ContaCbl,i];
         AbrevSerie:=Grelha.Cells[COL_AbrevSerie,i];
         Natureza:=Grelha.Cells[COL_Natureza, i];
         NaturezaNeg:=Grelha.Cells[COL_Natureza1, i];
         NaturezaPag:=Grelha.Cells[COL_NaturezaPag, i];
         NaturezaPagNeg:=Grelha.Cells[COL_NaturezaPag1, i];
         NaturezaTipoDoc:=Grelha.Cells[COL_NaturezaTipoDoc, i];
         SerieERP:=Grelha.Cells[COL_SerieERP,i];
         ID_Hotel:=Grelha.Cells[COL_PmsID_Hotel,i];
         NotaCreditoControlaPeriodoIVA:=false;
         Grelha.GETCheckBoxState(COL_NCIVAPERIODO,i, NotaCreditoControlaPeriodoIVA);


         strsql:= 'INSERT INTO [CBL_TipoDocPMS]'
              +' ([PMS_ID_TipoDoc]'
              +' ,[PMS_TipoDoc]'
              +',Natureza, NaturezaNeg,NaturezaPag,NaturezaPagNeg'
              +' ,[ContaCBL],NaturezaTipoDoc,AbrevSerie,SerieERP,ID_Hotel,NotaCreditoControlaPeriodoIVA)'
              +' VALUES('
              +Inttostr(ID_PmsTipodoc)
              +','+#39+ PmsTipoDoc+#39
              +','+#39+ Natureza+#39
              +','+#39+ NaturezaNeg+#39
              +','+#39+ NaturezaPag+#39
              +','+#39+ NaturezaPagNeg+#39
              +','+#39+ ContaCbl+#39
              +','+#39+ NaturezaTipoDoc+#39
              +','+#39+ AbrevSerie+#39
             +','+#39+ SerieERP+#39
             +','+#39+ ID_Hotel+#39
             +','+sb.UtilSQL.BoolToSQLStr(NotaCreditoControlaPeriodoIVA)
              +')';
            sb.SBBD.Executa(strsql);

        end;
    end;


         strsql:=' delete from CBL_ContaFamiliaPMS where PMS_ID_TipoDoc not in(select PMS_ID_TipoDoc from CBL_TipoDocPMS)';
         sb.SBBD.Executa(strsql);



        Result:=true;
        sb.SBBD.TerminaTransacao;
        Except
             On E: Exception Do
             Begin
                 Result:=false;
                sb.SBBD.DesfazTransacao;
                raise SB.ErroNormal(0,'Pms_TipoDoc','Pms_TipoDoc','Não Foi possivel efectuar a Gravação ' + E.Message);
             End;
        end;

end
else
Result:=false;


end;





procedure TFRMCBLPmsTipoDoc.GrelhaRowChanging(Sender: TObject; OldRow,
  NewRow: Integer; var Allow: Boolean);
begin

RemoveBotaoGrelha(Grelha, COL_PmsTipoDoc, OldRow);

  if (NewRow >= Grelha.FixedRows) then
  begin
    If  Grelha.cells[COL_PmsTipoDoc, NewRow]='' then
            AdicionaBotaoGrelha(Grelha, COL_PmsTipoDoc, NewRow, epimagem.BtListaGlyph);
  end;

end;


procedure TFRMCBLPmsTipoDoc.GrelhaClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
//  If Grelha.Cells[COL_PmsTipoDoc,Grelha.Row]='' then
    AdicionaBotaoGrelha(Grelha, COL_PmsTipoDoc, ARow, epimagem.BtListaGlyph);

end;

procedure TFRMCBLPmsTipoDoc.FormCreate(Sender: TObject);
begin
  FormataFormPorDefeito(self);
  FormataBotoes(self);
  Top:=170;
  Left:=15;

end;

Function TFRMCBLPmsTipoDoc.Abreformulario():Boolean;
begin
 Result:=false;
 FEntradaConFContasPorTipoDoc:=false;
 FlinhaSageCNC:=false;
 FItemsnatureza:=TstringList.create;
 FItemsnatureza.Add('C');
 FItemsnatureza.Add('D');
 FormataGrelha;
 If  ObterConexao then
 begin
    Result:=true;
    GravaHotelTipodocHotelZero;
    FID_Hotel:=0;
    If FShemaProtel<>'' then
        MostraPmsPmsTipoDoc
    Else
        sb.Dialogos.SBAviso('A Coneção para a Base de Dados CBL, não se encontra Configurada!')
 end;
end;

procedure TFRMCBLPmsTipoDoc.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 If assigned(FItemsnatureza) then
   FreeAndnil(FItemsnatureza);

action:=cafree;
end;

procedure TFRMCBLPmsTipoDoc.AcConfirmarExecute(Sender: TObject);
begin
   screen.cursor:=CrHourGlass;
    Try
     If GravaPmsPmsTipoDoc then
     begin
//      RegistoLogOperacao(2);
      sb.Dialogos.SBMessage('Os dados foram gravados com sucesso');
     end;
    Finally
       screen.cursor:=CrDefault;
   end;
end;

procedure TFRMCBLPmsTipoDoc.acSairExecute(Sender: TObject);
begin
 self.close;
end;

procedure TFRMCBLPmsTipoDoc.GrelhaCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
If EntradaConFContasPorTipoDoc  then
    canedit:=false
else
    canedit:=Acol in[COL_PmsTipoDoc,COL_SerieERP,COL_NCIVAPERIODO,COL_ContaCbl,col_AbrevSerie,col_natureza,COL_Naturezatipodoc,COL_Natureza1,COL_NaturezaPag,COL_NaturezaPag1];
end;

procedure TFRMCBLPmsTipoDoc.GrelhaGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
 Case ACol of
    COL_Natureza,COL_Natureza1,COL_NaturezaPag,COL_NaturezaPag1,COL_NaturezaTipoDoc:
      Begin
        AEditor:=edComboList;
        Grelha.Combobox.Items := FItemsnatureza;
      End;
 end;     
end;

procedure TFRMCBLPmsTipoDoc.BtContasClick(Sender: TObject);
var
 FFrmCBLPmsContasFamilia:TFrmCBLPmsContasFamilia;
 NotaCreditoControlaPeriodoIVA:Boolean;
begin
If   GravaPmsPmsTipoDoc then
begin
    If Grelha.ints[COL_ID_PmsTipoDoc,Grelha.row]>0 then
    begin
             NotaCreditoControlaPeriodoIVA:=false;
         Grelha.GETCheckBoxState(COL_NCIVAPERIODO,Grelha.row, NotaCreditoControlaPeriodoIVA);

        FFrmCBLPmsContasFamilia:=TFrmCBLPmsContasFamilia.Create(Self);
        FFrmCBLPmsContasFamilia.ConfPorTipoDoc:=true;
        FFrmCBLPmsContasFamilia.POSID_TipoDocPMs:= Grelha.ints[COL_ID_PmsTipoDoc,Grelha.row];
        FFrmCBLPmsContasFamilia.POSTipoDocPMs:= Grelha.cells[COL_PmsTipoDoc,Grelha.row];
        FFrmCBLPmsContasFamilia.TipodocNotacredito:=NotaCreditoControlaPeriodoIVA;
        FFrmCBLPmsContasFamilia.ldoc.caption:= FFrmCBLPmsContasFamilia.POSTipoDocPMs;
        FFrmCBLPmsContasFamilia.linhaSageCNC:=FlinhaSageCNC;
        FFrmCBLPmsContasFamilia.Showmodal;
        FFrmCBLPmsContasFamilia.free;
    end;
end;
end;

procedure TFRMCBLPmsTipoDoc.FormShow(Sender: TObject);
begin
  BtContas.Visible:=true;
  If FShemaProtel='' then
    self.close;
end;

Procedure TFRMCBLPmsTipoDoc.GravaHotelTipodocHotelZero();
var
 SQL:string;
 Lista,ListaDocSemHotel:tsbbetabeladados;
 FShemaProtel:string;
 ID_HotelDoc,ID_TipoDocPms:integer;

begin
   Lista:=nil;
    ListaDocSemHotel:=sb.SBBD.AbrirLV('Select PMS_ID_TipoDoc from CBL_TipoDocPMS'
        +' where id_hotel=0');
    If Not (ListaDocSemHotel.vazia) then
    begin

         While Not(ListaDocSemHotel.nofim) do
         begin
             ID_HotelDoc:=0;
             ID_TipoDocPms:=ListaDocSemHotel.davalor('PMS_ID_TipoDoc').asinteger;
             SQL := ' Select   fiscalcd.mpehotel'
                  + ' from '+FShemaProtel+'fiscalcd'
                  +' Where REf='+inttostr(ID_TipoDocPms);
              Lista:=sb.SBBD.AbrirLV(SQL);
              If not(Lista.vazia) then
              begin
                ID_HotelDoc:=Lista.davalor('mpehotel').asinteger;
                GravaHotel(ID_TipoDocPms,ID_HotelDoc);
                Lista.Fecha;
              end;
              ListaDocSemHotel.seguinte;

        end;
    end;
    ListaDocSemHotel.fecha;
    If assigned(Lista) then
    Lista.Fecha;
end;




Procedure TFRMCBLPmsTipoDoc.GravaHotel(pID_TipodocPms,pID_Hotel:Integer);
var
   i:integer;
   query:TAdoQuery;
   strsql:string;
   Connection:TadoConnection;
begin

   Try


          strsql:='';
          strsql:='Update  CBL_TipoDocPMS';
          strsql:=strsql+' set  CBL_TipoDocPMS.id_hotel='+inttostr(pID_Hotel);
          strsql:=strsql+' where  CBL_TipoDocPMS.PMS_ID_TipoDoc='+inttostr(pID_TipodocPms);
          sb.SBBD.Executa(strsql);


    Finally

    end;

end;


end.
