unit CBLFRMPaisMercado;

interface

uses


  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ActnList, Grids, AdvObj, BaseGrid, AdvGrid, AdvToolBar,
  SBEditProcura,inifiles,sblista,adodb,sbcontrolos,CBLOperInterfaceProtel,
  pngimage;

type
  TFRMCBLPaisMercado = class(TForm)
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
    RemoveSeleo1: TMenuItem;
    AtribuiMercado1: TMenuItem;
    Nacional1: TMenuItem;
    InterComunitario1: TMenuItem;
    ExtraComunitrio1: TMenuItem;
    SelecionaTodos1: TMenuItem;
    AtribuiMercadoSugAutomtica1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GrelhaCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure RemoveSeleo1Click(Sender: TObject);
    procedure Nacional1Click(Sender: TObject);
    procedure InterComunitario1Click(Sender: TObject);
    procedure ExtraComunitrio1Click(Sender: TObject);
    procedure AcConfirmarExecute(Sender: TObject);
    procedure acSairExecute(Sender: TObject);
    procedure SelecionaTodos1Click(Sender: TObject);
    procedure AtribuiMercadoSugAutomtica1Click(Sender: TObject);
  private
    { Private declarations }
     FconexaoProtel:string;
     FShemaProtel:string;
    Procedure FormataGrelha;
    procedure PreencheGrelhaPaises();
    Function  ObterConexao():Boolean;
    procedure GravaDados;

  public
    { Public declarations }
    Function Abreformulario():Boolean;
  end;

var
  FRMCBLPaisMercado: TFRMCBLPaisMercado;

implementation
uses IERPOGLobais,SBBotoes,SBBETabelaDados, SBBaseDados, SBBSSistemaBase,ERPBEEMPRESAINTERFACE;

{$R *.dfm}
Const

  COL_ID_PmsPais = 0;
  COL_PmsPais = 1;
  COL_PmsCODISO = 2;
  COL_Mercado= 3;
  COL_ID_Mercado= 4;
  COL_check=5;
  Col_Max = 6;

Procedure TFRMCBLPaisMercado.FormataGrelha;
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

    ColWidths[COL_ID_PmsPais] := 70;
    ColWidths[COL_PmsPais] := 100;
    ColWidths[COL_PmsCODISO] := 80;
    ColWidths[COL_Mercado] := 150;
    ColWidths[COL_id_Mercado] := 0;
    ColWidths[COL_check] := 35;

    ColWidths[COL_PmsPais]:= Width - ColWidths[COL_ID_PmsPais]-ColWidths[COL_PmsCODISO]
     -ColWidths[COL_Mercado]-ColWidths[COL_check]-21;


    Options:= [goFixedVertLine] + [goFixedHorzLine] + [goHorzLine] + [goVertLine] + [goEditing];
        With Navigation do
        begin
          AllowDeleteRow:=false;
          AllowInsertRow:=false;
        end;


    Cells[COL_ID_PmsPais, 0] := SB.Idioma.daTraducao(0, 'ID_Pais');
    Cells[COL_PmsPais, 0] := SB.Idioma.daTraducao(0, 'Pais');
    Cells[COL_PmsCODISO, 0] := SB.Idioma.daTraducao(0, 'Code');
    Cells[COL_Mercado, 0] := SB.Idioma.daTraducao(0, 'Mercado');
    Grelha.SortByColumn(COL_Mercado);

    EndUpdate;
  end;
End;






Function DevolvechemaHotel(var pIDInterface:Integer;var pConnectionstring:string):string;
var strsql:string;
    ProtelObjInterface:TERPBEEMPRESAINTERFACE;
    DescSchemaPms,
   DescSchemaSys:string;
begin
  result:='';
  ProtelObjInterface:=nil;
  pIDInterface:=0;
  ProtelObjInterface:= MotorERP.ERPInterface.InterfaceActivo('ERP_CBLPROTEL');
  If ProtelObjInterface<>nil then
  begin
     pConnectionstring:=ProtelObjInterface.BDConexao;
     Result:= ProtelObjInterface.BDSchema;
     If   ProtelObjInterface.Namelinkedserver<>'' then
        Result:=ProtelObjInterface.Namelinkedserver+'.'+Result;
     pIDInterface:= ProtelObjInterface.id;
  end
  else
  begin
      ProtelObjInterface:= MotorERP.ERPInterface.InterfaceActivo('ERP_VENDASPROTEL');
      If ProtelObjInterface<>nil then
      begin
        pConnectionstring:=ProtelObjInterface.BDConexao;
        Result:= ProtelObjInterface.BDSchema;
        Result:=ProtelObjInterface.Namelinkedserver+'.'+Result;        
        pIDInterface:= ProtelObjInterface.id;
      end
  end;
  If pIDInterface=0 then
    sb.Dialogos.SBMessage('Não existe Interface PMS ativo!');

end;



Function TFRMCBLPaisMercado.ObterConexao():Boolean;
var
  id_Interface:integer;
begin
   id_Interface:=0;
   Result:=false;
   FShemaProtel:=DevolvechemaHotel(id_Interface,FconexaoProtel);
   Result:= id_Interface>0;
end;



procedure TFRMCBLPaisMercado.PreencheGrelhaPaises();
var
   Lista,ListaPMS:TSBBETabelaDados;
   sql,strsql:string;
   i:integer;
   filtro,Connectionstring:string;
   schema:string;
   IDInterface:integer;

begin
    strsql:='';
    strsql:='select * from PMSPaisMercado';
    Lista:=sb.SBBD.AbrirLV(strsql);
    schema:=DevolvechemaHotel(IDInterface,Connectionstring);


   i:= 1;
   sql:='Select  codenr as id_pais,Land as Pais,addinfo as code from '+schema+'Natcode';
   ListaPMS:=SB.SBBD.AbrirLV(sql);
   If not(ListaPMS.vazia) then
     Grelha.Rowcount:=Grelha.fixedrows+ ListaPMS.NumLinhas;
   Try
    while not(ListaPMS.NoFim) do
    begin
        With Grelha do
        begin
           Grelha.cells[COL_ID_PmsPais,i]:=ListaPMS.Davalor('id_pais').asstring;
           Grelha.Cells[COL_PmsPais,i]:=ListaPMS.Davalor('Pais').asString;
           Grelha.Cells[COL_PmsCODISO,i]:=ListaPMS.Davalor('code').asString;
           If not(Lista.vazia) then
           begin
             If Lista.dataset.Locate('ID_Pais',ListaPMS.Davalor('id_pais').asstring,[]) then
             begin
               Grelha.cells[Col_ID_Mercado,i]:=Lista.davalor('ID_Mercado').asstring;
               Grelha.cells[COL_Mercado,i]:=Lista.davalor('DescMercado').asstring;
             end;

           end;

           Grelha.AddCheckBox(col_check,i,false,false);
           inc(i);
        end;
        ListaPMS.seguinte;
    end;
   Finally
     FreeAndNil(Lista);

     Freeandnil(ListaPMs);
   end;
   Grelha.SortByColumn(col_ID_Mercado);
   Grelha.row:=1;
end;



procedure TFRMCBLPaisMercado.FormCreate(Sender: TObject);
begin
  FormataFormPorDefeito(self);
  FormataBotoes(self);

end;

Function TFRMCBLPaisMercado.Abreformulario():Boolean;
begin
 Result:=false;
 If  ObterConexao then
 begin
  Result:=true;
  FormataGrelha;
  PreencheGrelhaPaises;
 end
 else
 begin
   Result:=false;
   self.close;
 end;

end;


procedure TFRMCBLPaisMercado.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action:=cafree;
end;

procedure TFRMCBLPaisMercado.GrelhaCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
 canedit:=ACol=col_check;
end;

procedure TFRMCBLPaisMercado.RemoveSeleo1Click(Sender: TObject);
var
 i:Integer;
begin
For i:=1 to Grelha.RowCount-1 do
  Grelha.SetCheckBoxState(col_check,i,false);
end;

procedure TFRMCBLPaisMercado.Nacional1Click(Sender: TObject);
var
 i:Integer;
begin
    For i:=1 to Grelha.RowCount-1 do
    begin
       If Grelha.cells[COL_PmsCODISO,i]='PT' then
       begin
             Grelha.cells[COL_Mercado,i] := 'Nacional';
             Grelha.Ints[COL_ID_Mercado,i] := 1;
       end;
    end;
end;

procedure TFRMCBLPaisMercado.InterComunitario1Click(Sender: TObject);
var
 i:Integer;
 check:Boolean;
begin
    For i:=1 to Grelha.RowCount-1 do
    begin
        Check:=false;
        Grelha.GetCheckBoxState(col_check,i,Check);
        If Check then
        begin
           if  Grelha.cells[COL_PmsCODISO,i]<>'PT' then
           begin
             Grelha.cells[COL_Mercado,i] := 'Inter-Comunitário';
             Grelha.Ints[COL_ID_Mercado,i] := 2;
           end;
        end;
    end;

end;

procedure TFRMCBLPaisMercado.ExtraComunitrio1Click(Sender: TObject);
var
 i:Integer;
 check:Boolean;
begin
    For i:=1 to Grelha.RowCount-1 do
    begin
        Check:=false;
        Grelha.GetCheckBoxState(col_check,i,Check);
        If Check then
        begin
           if  Grelha.cells[COL_PmsCODISO,i]<>'PT' then
           begin
             Grelha.cells[COL_Mercado,i] := 'Extra-Comunitário';
             Grelha.Ints[COL_ID_Mercado,i] := 3;
           end;  
        end;
    end;
end;

procedure TFRMCBLPaisMercado.GravaDados;
var
    i:integer;
    strsql:string;
    ID_Pais,
    Descricao,
    CodISO,
    ID_Mercado,
    DescMercado:string;
begin

     sb.sbbd.IniciaTransacao;
     Try
        strsql:='';
        strsql:='Delete from PMSPaisMercado';
        sb.SBBD.Executa(strsql);
        for i:=1 to Grelha.RowCount-1 do
         Begin

              strsql:='';
              ID_Pais:=Grelha.cells[COL_ID_PmsPais,i];
              Descricao:=Grelha.cells[COL_PmsPais,i];
              CodISO:=Grelha.cells[COL_PmsCODISO,i];
              ID_Mercado:=Grelha.cells[COL_ID_Mercado,i];
              DescMercado:=Grelha.cells[COL_Mercado,i];

              strsql:=  'INSERT INTO [PMSPaisMercado]'
                   +'([ID_Pais]'
                   +',[Descricao]'
                   +',[CodISO]'
                   +',[ID_Mercado]'
                   +',[DescMercado])'
                   +'  VALUES ('
                   +#39+ID_pais+#39
                 +','+#39+ Descricao+#39
                 +','+#39+ CodISO+#39
                 +','+#39+ ID_Mercado+#39
                 +','+#39+ DescMercado+#39+')';
                sb.SBBD.Executa(strsql);

         end;
        sb.sbbd.TerminaTransacao;
        Except

             On E: Exception Do
             Begin
                sb.sbbd.DesfazTransacao;
                raise SB.ErroNormal(0,'PMS_PaisMercado','PMS_PaisMercado','Não Foi possivel efectuar a Gravação ' + E.Message);

             End;
        end;

end;
procedure TFRMCBLPaisMercado.AcConfirmarExecute(Sender: TObject);
begin
    GravaDados;
    self.close;
end;

procedure TFRMCBLPaisMercado.acSairExecute(Sender: TObject);
begin
 self.close;
end;

procedure TFRMCBLPaisMercado.SelecionaTodos1Click(Sender: TObject);
var
 i:Integer;
begin
For i:=1 to Grelha.RowCount-1 do
  Grelha.SetCheckBoxState(col_check,i,true);
end;

procedure TFRMCBLPaisMercado.AtribuiMercadoSugAutomtica1Click(
  Sender: TObject);
var
 i:Integer;
begin
    For i:=1 to Grelha.RowCount-1 do
    begin
       If Grelha.cells[COL_PmsCODISO,i]='PT' then
       begin
             Grelha.cells[COL_Mercado,i] := 'Nacional';
             Grelha.Ints[COL_ID_Mercado,i] := 1;
       end
       else

        IF ((Grelha.cells[COL_PmsCODISO,i]='DE') or
        (Grelha.cells[COL_PmsCODISO,i]='AT') or
        (Grelha.cells[COL_PmsCODISO,i]='BE') or
        (Grelha.cells[COL_PmsCODISO,i]='BG') or
        (Grelha.cells[COL_PmsCODISO,i]='CY') or


        (Grelha.cells[COL_PmsCODISO,i]='HR') or
        (Grelha.cells[COL_PmsCODISO,i]='DK') or
        (Grelha.cells[COL_PmsCODISO,i]='SK') or
        (Grelha.cells[COL_PmsCODISO,i]='SI') or

        (Grelha.cells[COL_PmsCODISO,i]='ES') or
        (Grelha.cells[COL_PmsCODISO,i]='EE') or
        (Grelha.cells[COL_PmsCODISO,i]='FI') or
        (Grelha.cells[COL_PmsCODISO,i]='FR') or

        (Grelha.cells[COL_PmsCODISO,i]='GR') or
        (Grelha.cells[COL_PmsCODISO,i]='HU') or
        (Grelha.cells[COL_PmsCODISO,i]='IE') or
        (Grelha.cells[COL_PmsCODISO,i]='IT') or


        (Grelha.cells[COL_PmsCODISO,i]='LV') or
        (Grelha.cells[COL_PmsCODISO,i]='LT') or
        (Grelha.cells[COL_PmsCODISO,i]='LU') or
        (Grelha.cells[COL_PmsCODISO,i]='MT') or


        (Grelha.cells[COL_PmsCODISO,i]='NL') or
        (Grelha.cells[COL_PmsCODISO,i]='PL') or

        (Grelha.cells[COL_PmsCODISO,i]='UK') or


        (Grelha.cells[COL_PmsCODISO,i]='RO') or
        (Grelha.cells[COL_PmsCODISO,i]='SE') or
        (Grelha.cells[COL_PmsCODISO,i]='IS') or
        (Grelha.cells[COL_PmsCODISO,i]='NO') or
        (Grelha.cells[COL_PmsCODISO,i]='CH'))then

        begin
                     Grelha.cells[COL_Mercado,i] := 'Inter-Comunitário';
                     Grelha.Ints[COL_ID_Mercado,i] := 2;
        end
        else
        begin
                     Grelha.cells[COL_Mercado,i] := 'Extra-Comunitário';
                     Grelha.Ints[COL_ID_Mercado,i] := 3;
        end

end;

       Grelha.SortByColumn(COL_Mercado);
end;


end.
