unit ERP_FrmExportInventarios;

interface

uses
  Windows, Messages, SysUtils,strutils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, AdvEdit, AdvMEdBtn, PlannerMaskDatePicker,
  AdvGroupBox, ActnList, AdvOfficeButtons, Grids, AdvObj, BaseGrid,Sbbotoes,
  AdvGrid, AdvOfficePager, ExtCtrls, AdvPanel, AdvToolBar,dateutils,sbcontrolos,
  ERPOperInterfaceFntCMP,sbbetabeladados, SBEditProcura,sblista,ERPBEEMPRESAINTERFACE,ierpListasDef,
  ImgList,Menus,math;


type
  TFRMERPExportInventarios = class(TForm)
    AdvDockPanel1: TAdvDockPanel;
    AdvToolBar1: TAdvToolBar;
    Btsair: TAdvToolBarButton;
    BtExportar: TAdvToolBarButton;
    tbSepIcons: TAdvToolBarSeparator;
    BtActualizar: TAdvToolBarButton;
    btLimpar: TAdvToolBarButton;
    AdvToolBarSeparator1: TAdvToolBarSeparator;
    AdvPanel1: TAdvPanel;
    AdvPanel2: TAdvPanel;
    AdvOfficePager1: TAdvOfficePager;
    TssbDocCompras: TAdvOfficePage;
    GrelhaInventario: TAdvStringGrid;
    PanelTotVendas: TAdvPanel;
    Label2: TLabel;
    StTotalCreditos: TStaticText;
    tssbImpressao: TAdvOfficePage;
    GroupBox1: TGroupBox;
    LbsbRelatorio: TLabel;
    cmbRelatorios: TComboBox;
    cbsbVisualizar: TAdvOfficeCheckBox;
    lbsbInicio: TLabel;
    edtInventarios: TSBEditProcura;
    ActionList1: TActionList;
    Accontrair: TAction;
    acexpandir: TAction;
    procedure FormCreate(Sender: TObject);
    procedure edtInventariosBtListaClick(Sender: TObject);
    procedure BtsairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtActualizarClick(Sender: TObject);
    procedure AccontrairExecute(Sender: TObject);
    procedure acexpandirExecute(Sender: TObject);
    procedure BtExportarClick(Sender: TObject);
    procedure btLimparClick(Sender: TObject);
  private
    { Private declarations }
    FFormatoDecimalGrelhaValor:string;
    FFormatoDecimalGrelhaQuant:string;
    FLISTAInventario:TSBBETABELADADOS;
    FcontasPorConfigurar:Boolean;
    Procedure Inicializaform;
    procedure LimpaGrelha;
    procedure PreencheGRELHA;
    Procedure FormataGrelha;
    Function  PreencheVariaveisGerais():Boolean;
    Function  DevolveIDInventariosExportados:string;
    
    procedure PreencheGreLhaAgrupadaporProduto;
    procedure PreencheGreLhaAgrupadaporArmazem;

  public
    { Public declarations }
      Procedure AbreFormulario;
     Procedure SeleccionaInventario(Sender :TObject);

  end;

var
  FRMERPExportInventarios: TFRMERPExportInventarios;

implementation
uses iERPOglobais,FNTUTILGrelha, SBBSSistemaBase, SBBSUtilSQL,IERPFrmPrincipal,ERPLogOperacoes,
  SBValor, SBBaseDados;
var

FID_cLienteIndiferenciado:string;
FExpApenasComprasFechadas:Boolean;
FExportaAgrpArmazem:Boolean;

Const
  Col_Arv=0;
  Col_ContaERP=1;
  Col_DescricaoProduto=2;
  Col_Qtd=3;
  Col_PrecoMedioProduto=4;
  Col_ValorLinhaSemIVA=5;

  Col_GrupoFamilia=6;
  Col_Familia=7;
  Col_SubFamilia=8;
  Col_ID_Armazem=9;
  Col_DescricaoArmazem=10;
  Col_ID_Inventario=11;
  Col_ID_Produto=12;
  Col_ID_Unidade=13;
  Col_MaxCols=14;



{$R *.dfm}

Function FormatoDecimalGrelhaQuant():string;
var
 casasDecimais:integer;
 lstFlags:tsbbeTabelaDados;
 strsql:string;
begin
  strsql:='select NumCasasDecQuantStock from tab_flags';
  lstFlags:=MotorFnt.sb.sbbd.AbrirLV(strsql);
  casasDecimais:=lstFlags.davalor('NumCasasDecQuantStock').asinteger;
  Result:='%.'+inttostr(casasDecimais)+'f';
  freeandnil(lstFlags);
end;

Function FormatoDecimalGrelhaValor():string;
var
 casasDecimais:integer;
 lstFlags:tsbbeTabelaDados;
 strsql:string;
begin
  strsql:='select NumCasasDecValorStock from tab_flags';
  lstFlags:=MotorFnt.sb.sbbd.AbrirLV(strsql);
  casasDecimais:=lstFlags.davalor('NumCasasDecValorStock').asinteger;
  Result:='%.'+inttostr(casasDecimais)+'f';
  freeandnil(lstFlags);
end;

Procedure TFRMERPExportInventarios.AbreFormulario;
begin
 PreencheVariaveisGerais;
 Inicializaform;
 showmodal;
end;

Procedure TFRMERPExportInventarios.Inicializaform;
Begin
  FormataFormPorDefeito(self);
  FormataBotoes(self);
  FormataGrelha;
end;

procedure TFRMERPExportInventarios.FormCreate(Sender: TObject);
begin
 FormataFormPorDefeito(self);
 FormataBotoes(self);
 FFormatoDecimalGrelhaValor:=FormatoDecimalGrelhaValor;
 FFormatoDecimalGrelhaQuant:=FormatoDecimalGrelhaQuant;
 Top:=FrmIERPPrincipal.MenuOpcoes.Height+20;
end;

procedure TFRMERPExportInventarios.edtInventariosBtListaClick(
  Sender: TObject);
  var mfiltro:string;
begin
  inherited;
  mfiltro:=DevolveIDInventariosExportados;
  if mfiltro<> '' then
     mfiltro:='id_inventario not in('+mfiltro+')';
  Listasfnt.AbrirSQL('ListaInventarios',mfiltro,edtInventarios, SeleccionaInventario);
end;

Function TFRMERPExportInventarios.DevolveIDInventariosExportados:string;
Var strsql:string;
lstInventarios:tsbbeTabelaDados;
begin
  strsql:='select * from ERP_CabInventario';
  lstInventarios:=sb.sbbd.AbrirLV(strsql);

  if lstInventarios.Vazia then
   result:=''
  else
  begin
    while not lstInventarios.NoFim do
    begin
        Result := Result + ifthen(Result <> '', ',' , '') + IntToStr(lstInventarios.davalor('id_inventario').AsInteger);
        lstInventarios.seguinte;
    end;
  end;
  if Assigned(lstInventarios) then
    freeandnil(lstInventarios);
end;
procedure TFRMERPExportInventarios.SeleccionaInventario;
var
  Obj:TSBSelecaoLista;
Begin
  Obj:=TSBSelecaoLista(Sender);
  edtInventarios.ID_Chave:=Obj.Chave;
  edtInventarios.text:=Obj.ValorDescricao;
  Obj.Free;
end;

procedure TFRMERPExportInventarios.BtsairClick(Sender: TObject);
begin
 close;
end;

procedure TFRMERPExportInventarios.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=cafree;
end;

procedure TFRMERPExportInventarios.BtActualizarClick(Sender: TObject);
begin
  if edtInventarios.ID_Chave>0 then
  begin
     if assigned(FLISTAInventario) then
     begin
        FLISTAInventario.Fecha;
        Freeandnil(FLISTAInventario);
     end;
     LimpaGrelha;
     PreencheGRELHA;
  end
  else
  sb.Dialogos.SBMessage(0,'Selecione o Inventário');   
end;

procedure TFRMERPExportInventarios.LimpaGrelha;
VAR
  i:integer;
begin

  for i:=1 to GrelhaInventario.ALLRowCount-1 do
  begin
      GrelhaInventario.RemoveNode(i);
  end;
  GrelhaInventario.clearnormalcells;
  GrelhaInventario.rowcount:=GrelhaInventario.fixedrows+1;
  If assigned(FLISTAInventario) then
  begin
   FLISTAInventario.Fecha;
   freeandnil(FLISTAInventario);

  end;
end;


procedure TFRMERPExportInventarios.PreencheGRELHA;
var
segue:Boolean;
i:integer;
DadosNos :TDadosnos;
begin

   FLISTAInventario:=ERPOperInterfacefntCMP.DaListaInventariosPorExportar(inttostr(edtInventarios.ID_Chave),FExportaAgrpArmazem);
   If FLISTAInventario<>nil then
    If Not FLISTAInventario.Vazia then
       segue:=true;

   if segue =true then
   begin
    If FExportaAgrpArmazem=false then
      PreencheGreLhaAgrupadaporProduto
    else
          PreencheGreLhaAgrupadaporArmazem
   end;
end;

procedure TFRMERPExportInventarios.PreencheGreLhaAgrupadaporArmazem;
var
    i:integer;
    DadosNos :TDadosnos;
    DescArmazem:string;
begin
     i:=GrelhaInventario.FixedRows;
     DadosNos := TDadosnos.create;
     FLISTAInventario.inicio;
     While Not FLISTAInventario.nofim do
     begin
        with GrelhaInventario do
        begin
          If  (Not(ExisteNo('inv'+IntTostr(FLISTAInventario.davalor('id_inventario').asinteger),DadosNos))) Then
          Begin
            IncrementaNos('inv'+FLISTAInventario.davalor('id_inventario').asstring, i, DadosNos);
            MergeCells(Col_ContaERP,i,6,1);
            Cells[Col_ContaERP,i]:='Inventario de:'+FLISTAInventario.davalor('Descricao').AsString
            +' ('+FormatDateTime('dd-mm-yy',FLISTAInventario.davalor('Datainicio').asdatetime)
            +'_'+FormatDateTime('dd-mm-yy',FLISTAInventario.davalor('datafim').asdatetime)
            +')';
            FontStyles[Col_ContaERP,i]:=[fsBold];
            RowColor[i]:=clInfoBk;
            Alignments[Col_ContaERP,i]:=taCenter;
            Ints[Col_ID_Inventario,i]:=FLISTAInventario.davalor('id_inventario').AsInteger;

            inc(i);

            RowCount:=RowCount+1;
          end;

          DescArmazem:='inv'+FLISTAInventario.daValor('ID_Inventario').AsString+'Ar'+FLISTAInventario.daValor('ID_Armazem').AsString;
          If  (Not(ExisteNo(DescArmazem,DadosNos))) Then
          Begin
            IncrementaNos('inv'+FLISTAInventario.davalor('id_inventario').asstring, i, DadosNos);
            IncrementaNos(DescArmazem, i, DadosNos);
            MergeCells(Col_DescricaoProduto,i,3,1);
            Cells[Col_ContaERP,i]:=FLISTAInventario.davalor('ContaERPARM').AsString;

            Cells[Col_DescricaoProduto,i]:='Armazém: '+FLISTAInventario.davalor('Armazem').AsString;
            Ints[Col_ID_Inventario,i]:=FLISTAInventario.davalor('id_inventario').AsInteger;
            Ints[Col_ID_Armazem,i]:=FLISTAInventario.davalor('id_Armazem').AsInteger;
            FontStyles[Col_ContaERP,i]:=[fsBold];
            RowColor[i]:=clInfoBk;
            If FLISTAInventario.davalor('ContaERPARM').AsString='' then
            begin
               colors[Col_ContaERP,i]:=clred;
            end;
            Alignments[Col_ContaERP,i]:=taCenter;

            inc(i);
            RowCount:=RowCount+1;
          end;


          IncrementaNos('inv'+FLISTAInventario.davalor('id_inventario').asstring, i, DadosNos);
          IncrementaNos(DescArmazem, i, DadosNos);

          Ints[Col_ID_Inventario,i]:=FLISTAInventario.davalor('id_inventario').AsInteger;
          Ints[Col_ID_Produto,i]:=FLISTAInventario.davalor('ID_Produto').AsInteger;

          Cells[Col_GrupoFamilia, i] := FLISTAInventario.davalor('GrupoFamilia').AsString;
          Cells[Col_Familia, i] := FLISTAInventario.davalor('Familia').AsString;
          Cells[Col_SubFamilia, i] :=FLISTAInventario.davalor('SubFamilia').AsString;

          Cells[Col_ContaERP,i]:=FLISTAInventario.davalor('ContaERP').AsString;

           If FLISTAInventario.davalor('ContaERP').AsString='' then
           begin
               colors[Col_ContaERP,i]:=clred;
          end;

          Cells[Col_DescricaoProduto,i]:=FLISTAInventario.davalor('DescricaoProduto').AsString;

          Ints[Col_ID_Unidade,i]:=FLISTAInventario.davalor('ID_Unidade').AsInteger;
          Floats[Col_Qtd,i]:=FLISTAInventario.davalor('Qtd').AsFloat;
          Floats[Col_PrecoMedioProduto,i]:=FLISTAInventario.davalor('PrecoMedioProduto').AsFloat;
          Floats[Col_ValorLinhaSemIVA,i]:=FLISTAInventario.davalor('ValorLinhaSemIVA').AsFloat;
          inc(i);
          RowCount:=RowCount+1;

        end;
         FLISTAInventario.Seguinte;
     end;


     If Assigned(DadosNos) Then
     Begin
          For i:=0 to DadosNos.Num-1 Do
            GrelhaInventario.AddNode(DadosNos.elem[i].Posicao, DadosNos.elem[i].NumFilhos);


         Try
          For i:=1 to DadosNos.Num-1 Do
            GrelhaInventario.ContractNode(DadosNos.elem[i].Posicao);
         except
         end;   

         Freeandnil(DadosNos);

     End;

end;


procedure TFRMERPExportInventarios.PreencheGreLhaAgrupadaporProduto;
var
    i:integer;
    DadosNos :TDadosnos;
begin
     i:=GrelhaInventario.FixedRows;
     DadosNos := TDadosnos.create;
     While Not FLISTAInventario.nofim do
     begin
        with GrelhaInventario do
        begin
          If  (Not(ExisteNo(IntTostr(FLISTAInventario.davalor('id_inventario').asinteger),DadosNos))) Then
          Begin
            IncrementaNos(FLISTAInventario.davalor('id_inventario').asstring, i, DadosNos);
            MergeCells(Col_ContaERP,i,8,1);
            Cells[Col_ContaERP,i]:='Inventario de:'+FLISTAInventario.davalor('Descricao').AsString
            +'('+FormatDateTime('dd-mm-yy',FLISTAInventario.davalor('Datainicio').asdatetime)
            +'_'+FormatDateTime('dd-mm-yy',FLISTAInventario.davalor('datafim').asdatetime)
            +')';

             FontStyles[Col_ID_Produto,i]:=[fsBold];
            Ints[Col_ID_Inventario,i]:=FLISTAInventario.davalor('id_inventario').AsInteger;
            Rowcolor[i]:=Clinfobk;            
            inc(i);
            RowCount:=RowCount+1;
          end;
          IncrementaNos(FLISTAInventario.davalor('id_inventario').asstring, i, DadosNos);

          Ints[Col_ID_Inventario,i]:=FLISTAInventario.davalor('id_inventario').AsInteger;
          Ints[Col_ID_Produto,i]:=FLISTAInventario.davalor('ID_Produto').AsInteger;

          Cells[Col_ContaERP,i]:=FLISTAInventario.davalor('ContaERP').AsString;
          Cells[Col_DescricaoProduto,i]:=FLISTAInventario.davalor('DescricaoProduto').AsString;

          Cells[Col_GrupoFamilia, i] := FLISTAInventario.davalor('GrupoFamilia').AsString;
          Cells[Col_Familia, i] := FLISTAInventario.davalor('Familia').AsString;
          Cells[Col_SubFamilia, i] :=FLISTAInventario.davalor('SubFamilia').AsString;
          

          Ints[Col_ID_Unidade,i]:=FLISTAInventario.davalor('ID_Unidade').AsInteger;
          Floats[Col_Qtd,i]:=FLISTAInventario.davalor('Qtd').AsFloat;
          Floats[Col_PrecoMedioProduto,i]:=FLISTAInventario.davalor('PrecoMedioProduto').AsFloat;
          Floats[Col_ValorLinhaSemIVA,i]:=FLISTAInventario.davalor('ValorLinhaSemIVA').AsFloat;
          inc(i);
          RowCount:=RowCount+1;

        end;
        FLISTAInventario.Seguinte;
     end;
     If Assigned(DadosNos) Then
     Begin
          For i:=0 to DadosNos.Num-1 Do
            GrelhaInventario.AddNode(DadosNos.elem[i].Posicao, DadosNos.elem[i].NumFilhos);
     End;
end;

Procedure TFRMERPExportInventarios.FormataGrelha;
Var
  i: Integer;
  item: TMenuItem;
  strEstado:string;
Begin
  with GrelhaInventario do
  begin
    BeginUpdate;
    Clear;
    FixedCols := 0;
    FixedRows := 1;
    RowCount := FixedRows + 1;
    ColCount := Col_MaxCols;



   ColWidths[Col_ID_Armazem]:=0;
    ColWidths[Col_ID_Inventario]:=0;
    ColWidths[Col_ID_Unidade] :=0;
    ColWidths[Col_ID_Produto] := 0;
    ColWidths[Col_DescricaoArmazem] := 0;


    ColWidths[Col_Arv] := 30;
    ColWidths[Col_Qtd] := 90;
    ColWidths[Col_ContaERP] := 80;
    ColWidths[Col_PrecoMedioProduto] := 80;
    ColWidths[Col_ValorLinhaSemIVA] := 90;

    ColWidths[Col_GrupoFamilia] := 80;
    ColWidths[Col_Familia] := 80;
    ColWidths[Col_SubFamilia] := 80;




    ColWidths[Col_DescricaoProduto]:= Width - ColWidths[Col_Arv]
    - ColWidths[Col_Qtd]-ColWidths[Col_ID_Produto]
    - ColWidths[Col_ID_Unidade]
    - ColWidths[Col_PrecoMedioProduto]
    - ColWidths[Col_ContaERP]
    - ColWidths[Col_ValorLinhaSemIVA]

    - ColWidths[Col_GrupoFamilia]
    - ColWidths[Col_Familia]
    - ColWidths[Col_SubFamilia]-
     21;


    Options:= [goFixedVertLine] + [goFixedHorzLine] + [goHorzLine] + [goVertLine]+[goColsizing]-[goEditing];
    With Navigation do
    begin
        AllowDeleteRow:=false;
        AllowInsertRow:=False;
    end;

    ControlLook.NoDisabledButtonLook:=True;
    Cells[Col_DescricaoProduto, 0] := SB.Idioma.daTraducao(0, 'Produto');
    Cells[Col_ContaERP, 0] := SB.Idioma.daTraducao(0, 'ContaERP');
    Cells[Col_ID_Unidade, 0] := SB.Idioma.daTraducao(0, 'id_unidade');
    Cells[Col_Qtd, 0] := SB.Idioma.daTraducao(0, 'Quantidade');
    Cells[Col_PrecoMedioProduto, 0] := SB.Idioma.daTraducao(0, 'PCM');
    Cells[Col_ValorLinhaSemIVA, 0] := SB.Idioma.daTraducao(0, 'V.S\IVA');

    Cells[Col_GrupoFamilia, 0] := SB.Idioma.daTraducao(0, 'Grupo ');
    Cells[Col_Familia, 0] := SB.Idioma.daTraducao(0, 'Familia');
    Cells[Col_SubFamilia, 0] := SB.Idioma.daTraducao(0, 'Sub.Familia');



    For i:= 0 To PopupMenu.Items.Count-3 Do
      PopupMenu.Items.Delete(i);

    item:= TMenuItem.Create(GrelhaInventario);
    item.Action := acExpandir;
    item.Caption := 'Expandir Grelha';
    PopupMenu.Items.Insert(0,item);

    item:= TMenuItem.Create(GrelhaInventario);
    item.Action := acContrair;
    item.Caption :=  'Contrair Grelha';
    PopupMenu.Items.Insert(1, item);



    EndUpdate;
  end;
End;




procedure TFRMERPExportInventarios.AccontrairExecute(Sender: TObject);
begin
GrelhaInventario.contractall;
//fdsfasdf
end;

procedure TFRMERPExportInventarios.acexpandirExecute(Sender: TObject);
begin
GrelhaInventario.expandall;
end;

Function TFRMERPExportInventarios.PreencheVariaveisGerais():Boolean;
var
 ObjInterface:TERPBEEMPRESAINTERFACE;
 mensagem:string;
begin
  result:=false;
  FExpApenasComprasFechadas:=false;
  FExportaAgrpArmazem:=false;
  FID_clienteIndiferenciado:='';
  ObjInterface:=nil;
  ObjInterface:= MotorERP.ERPInterface.InterfaceActivo('ERP_COMPRASSYSCONTROLLER');
  If assigned(ObjInterface) then
  begin
       Result:=True;
       ERPOperInterfaceFNTcmp.FOBJInterface:=MotorERP.ERPInterface.Clone(ObjInterface);
       FID_clienteIndiferenciado:= ObjInterface.ID_clienteIndiferenciado;
       FExpApenasComprasFechadas:= ObjInterface.ExpApenasComprasFechadas;
       FExportaAgrpArmazem:= ObjInterface.ExpInventarioAgrpArmProd;

       If ObjInterface.BDConexao='' then
         mensagem:='Falta Conexão á Base de Dados do SYSCONTROLLER!';

       If ObjInterface.ID_clienteIndiferenciado='' then
       begin
        If mensagem<>'' then
        begin
         mensagem:=mensagem+#13;
        end;
         mensagem:=mensagem+'Falta Configurar o cliente indeferenciado!'
       end;


       If mensagem<>'' then
       begin
        Result:=false;
        sb.Dialogos.SBMessage(mensagem+#13+'Verifique as Configurações do Interface!');
        BtActualizar.enabled:=false;
        BtExportar.Enabled:=false;
       end;
       if result=true then
            CarregaListasSyscontroller(ObjInterface.BDConexao);
        freeandnil(ObjInterface);
  end
  else
  begin
   result:=false;
   sb.Dialogos.SBMessage('Não existe interface: "ERP_COMPRASSYSCONTROLLER" Ativo!');
   BtActualizar.enabled:=false;
   BtExportar.Enabled:=false;
  end;

end;

procedure TFRMERPExportInventarios.BtExportarClick(Sender: TObject);
var merros:string;
begin
  if sb.Dialogos.SBConfirmacao('Deseja Exportar o Inventario?') then
  begin
      If  assigned(FLISTAInventario) then
       begin
          FcontasPorConfigurar:=false;
          If Not(FcontasPorConfigurar) then
          begin
              If ExportarInventarios(FLISTAInventario,merros) then
              begin
                  sb.Dialogos.SBMessage(0,'Efetuada exportação de Inventario de:'+edtInventarios.text);
                  edtInventarios.ID_Chave:=-1;
                  edtInventarios.Text:='';
                  LimpaGrelha;
              end
              else
              sb.Dialogos.SBMessage(0,merros);
          end
          else
          begin
            sb.Dialogos.SBMessage('Não é possível exportar!'+#13+'Verifique as Contas ERP.');
          end;
       end;
  end;
end;

procedure TFRMERPExportInventarios.btLimparClick(Sender: TObject);
begin
  edtInventarios.ID_Chave:=-1;
  edtInventarios.Text:='';
  LimpaGrelha;
end;

end.
