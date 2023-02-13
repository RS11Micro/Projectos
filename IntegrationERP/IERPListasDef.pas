unit IERPListasDef;



interface
 uses messages;

procedure CarregaListasProtel(mconexao,Shema,linkserver:string);
procedure CarregaListasSyscontroller(pconexao:string);
procedure CarregaListas;


implementation

uses SBListasFac40, IERPOGlobais, SBFrmSplash, SBBSSistemaBase, SBLista40,
     SysUtils, SBBEConsTipos, SBListasFac,
     SBLista,SBBETabelaDados,ERPBEEMPRESAINTERFACE,Dialogs, SBBSUtilSQL;




procedure CarregaListas;
var
  i: Integer;
  objListaDef40:TSBListaDef40;
  OBJInterface:TERPBEEMPRESAINTERFACE;
  OBJInterface1:TERPBEEMPRESAINTERFACE;
Begin

    objListaDef40:=Listas.Adiciona('ERP_EMPRESAINTERFACE','ERP_EMPRESAINTERFACE');
    with objListaDef40 do
    begin
       AdicionaColuna(0,'ID','ID', 0);
       AdicionaColuna(0,'ID_Interface','ID_Interface',0);
       AdicionaColuna(0,'INTERFACE','nomeinterface',150);
       AdicionaColuna(0,'Descrição','Descricao',100);
       AdicionaColuna(0,'BDServidor','BDServidor',80);
       AdicionaColuna(0,'BDUSER','BDUSER',80);
       AdicionaColuna(0,'BDPASSWORD','BDPass',80);
       AdicionaColuna(0,'BDNOME','BDNOME',80);
       AdicionaColuna(0,'Ativo','ativo',40);


       ChaveNome:='ID';
       AtributoDescricao:='Descricao';
       EscondeChave:=True;
       ActivaBotoesOperacoes:=true;


        SQL := ' select ERP_EMPRESAINTERFACE.ID,ERP_EMPRESAINTERFACE.ID_Interface,BDServidor,ERP_EMPRESAINTERFACE.descricao'
              +' ,BDUSER,BDPASSWORD,BDNOME,BDConexao,ERP_INTERFACE.nomeinterface,ERP_EMPRESAINTERFACE.ativo'
              +',ID_clienteIndiferenciado,''*****'' as BDPass'
              +',Ativo,ERP_INTERFACE.NomeInterface'
              +' from ERP_EMPRESAINTERFACE'
              +' inner join ERP_INTERFACE on '
              +' ERP_INTERFACE.id_interface=ERP_EMPRESAINTERFACE.id_interface';
        Titulo:= sb.idioma.datraducao(0,'Interfaces');
        ID_String:=0;
        Titulo:='Interfaces';
        IDG_SBLISTA:= '{82B2B16F-613A-4B73-9912-98EA123A4E74}';
   end;




   objListaDef40:=Listas.Adiciona('AreaNegocio','AreaNegocio');
    with objListaDef40 do
    begin
       AdicionaColuna(0,'Código','ID_AreaNegocio', 50);
       AdicionaColuna(0,'Descrição','DescricaoArea',150);
       AdicionaColuna(0,'Conta ERP','ContaERP',100);


       ChaveNome:='ID_AreaNegocio';
       AtributoDescricao:='DescricaoArea';
       EscondeChave:=True;
       ActivaBotoesOperacoes:=true;

        SQL := ' select * '
              +' from ERP_AreaNegocio';

        Titulo:= sb.idioma.datraducao(0,'Áreas de negócio');
        ID_String:=0;
        Titulo:='Áreas de negócio';
        IDG_SBLISTA:='{DFE80924-46C5-4509-BB69-6F05D213CFA0}';
   end;






  objListaDef40:=Listas.Adiciona('GrupoUtilizador');
  with objListaDef40 do
  begin
     AdicionaColuna(0,'Código','ID_GrupoUtilizador', 80);
     AdicionaColuna(42,'Descrição','Descricao',250);

     SQL := ' select *'
              +' From GrupoUtilizador ';


     ChaveTipoDados:=tdString;
     ChaveNome:='ID_GrupoUtilizador';
     EscondeChave:=True;
     Titulo:='Grupo de Utilizador';
     Ordem := 'Descricao';
     ActivaBotoesOperacoes:=false;
     AtributoDescricao:='Descricao';
     IDG_SBLista:='{3334DEB4-676F-4E8D-B6AE-66296BFBEFCE}';
  end;


      objListaDef40:=Listas.Adiciona('FntInterfaceCenExp','FntInterfaceCenExp');
      with objListaDef40 do
      begin
         AdicionaColuna(0,'ID_InterfaceCenExp','ID_InterfaceCenExp', 60);
         AdicionaColuna(0,'Interface','Nome',250);


         EscondeChave:=True;
         ChaveNome:='ID_InterfaceCenExp';
         AtributoDescricao:='Nome';


         SQL := 'select FntInterfaceCenExp.ID_InterfaceCenExp,FntInterface.Nome as nome'
                + ' from FntInterfaceCenExp'
                + ' inner join FntInterface on FntInterface.ID_Interface='
                + ' FntInterfaceCenExp.ID_Interface';


         ID_String:=0;
         Ordem := 'ID_InterfaceCenExp';
         ActivaBotoesOperacoes:=false;
         Conexao:='';
         Titulo:='Lista Interfaces do IMC';
         IDG_SBLista:='{1BD5F308-E21F-41B5-9B00-FD1DB3C5E724}'
     end;


   OBJInterface1:=nil;
  OBJInterface1:=MotorERP.ERPInterface.InterfaceActivo('ERP_CBLPROTEL');
  OBJInterface:=MotorERP.ERPInterface.InterfaceActivo('ERP_VENDASPROTEL');
  If (assigned(OBJInterface))then
  begin
      CarregaListasProtel(OBJInterface.BDConexao,OBJInterface.BDSchema,OBJInterface.Namelinkedserver);
      freeandnil(OBJInterface);
  end
  else
  If (assigned(OBJInterface1))then
  begin
      CarregaListasProtel(OBJInterface1.BDConexao,OBJInterface1.BDSchema,OBJInterface1.Namelinkedserver);
      freeandnil(OBJInterface1);
  end ;

  OBJInterface:=MotorERP.ERPInterface.InterfaceActivo('ERP_VENDASSYSCONTROLLER');
  If assigned(OBJInterface) then
  begin
    If OBJInterface.BDConexao<>'' then
    begin
      CarregaListasSyscontroller(OBJInterface.BDConexao);
    end;
    freeandnil(OBJInterface);
  end
  else
  OBJInterface:=MotorERP.ERPInterface.InterfaceActivo('ERP_ComprasSYSCONTROLLER');
  If assigned(OBJInterface) then
  begin
    If OBJInterface.BDConexao<>'' then
    begin
      CarregaListasSyscontroller(OBJInterface.BDConexao);
    end;
    freeandnil(OBJInterface);
  end


end;


procedure CarregaListasProtel(mconexao,Shema,linkserver:string);
var

  objListaDef:TSBListaDef40;
  ListaDados:TSBBETabelaDados;
 // OBJInterfaceProtel:TERPBEEMPRESAINTERFACE;
  OBJInterfaceSys:TERPBEEMPRESAINTERFACE;
begin
  OBJInterfaceSys:=MotorERP.ERPInterface.InterfaceActivo('ERP_VENDASSYSCONTROLLER');

  If mConexao<>'' then
  begin
{      If  linkserver<>'' then
           Shema:=linkserver+'.'+Shema;}

     objListaDef:=Listas.Adiciona('PmsHoteis','PmsHoteis');
     with objListaDef do
     begin
        AdicionaColuna(0,'Código ','mpehotel',50);
        AdicionaColuna(0,'Hotel','hotel',250);
        AdicionaColuna(0,'H.Abrev','short',250);


        EscondeChave:=True;
        ChaveNome:='mpehotel';
        AtributoDescricao:='short';
         Conexao:=mConexao;

        SQL := ' Select   DISTINCT Lizenz.*'
             + ' from '+Shema+'Lizenz'
             +'  INNER join '+Shema+'xsetup on lizenz.mpehotel=xsetup.mpehotel '
               +' where xsection = ''ERP_Interface'''
               +' and   xkey = ''Activo'' and xvalue = 1 ';


        ID_String:=0;
        ActivaBotoesOperacoes:=false;
        IDG_SBLista:='{EF6E941D-2354-45CD-BC50-2EE32C50336C}';
  end;


  objListaDef:=Listas.Adiciona('PmsHoteisGeral','PmsHoteisGeral');
  with objListaDef do
  begin
     AdicionaColuna(0,'Código ','mpehotel',50);
     AdicionaColuna(0,'Hotel','hotel',250);
     AdicionaColuna(0,'H.Abrev','short',250);


     EscondeChave:=True;
     ChaveNome:='mpehotel';
     AtributoDescricao:='short';
      Conexao:=mConexao;

     SQL := ' Select   DISTINCT Lizenz.*'
          + ' from '+Shema+'Lizenz';

     ID_String:=0;
     ActivaBotoesOperacoes:=false;
     IDG_SBLista:='{A785A77F-29D1-42D2-8B64-D73FEF3916B4}';

  end;




  objListaDef:=Listas.Adiciona('HoteisContaSaco','HoteisContaSaco');
  with objListaDef do
  begin
     AdicionaColuna(0,'Código ','mpehotel',50);
     AdicionaColuna(0,'Hotel','hotel',250);
     AdicionaColuna(0,'Conta Saco','ContaSaco',80);


     EscondeChave:=True;
     ChaveNome:='mpehotel';
     AtributoDescricao:='hotel';
      Conexao:=mConexao;

     SQL := ' select xsetup.mpehotel, lizenz.hotel, xsetup.xvalue as ContaSaco '
    +' from '+Shema+'xsetup inner join '+Shema+'xsetup as x1'
    +' on x1.mpehotel=xsetup.mpehotel'
    +' and x1.xsection = ''ERP_Interface'''
    +'             and   x1.xkey = ''Activo'' and x1.xvalue = 1'
    +' inner join   '+Shema+'lizenz on'
    +'  lizenz.mpehotel=xsetup.mpehotel'

    +' where xsetup.xsection = ''ERP_Interface'''
    +'  and xsetup.xkey = ''ClienteSaco''';



     ID_String:=0;
     Titulo:='Hoteis\Conta Saco(Cliente Indiferenciado)';
     ActivaBotoesOperacoes:=false;
     IDG_SBLista:='{0ABC06FB-589A-4030-9834-0A21A795098E}';

  end;




  objListaDef:=Listas.Adiciona('PmsTipoDoc','PmsTipoDoc');
  with objListaDef do
  begin

     AdicionaColuna(0,'Hotel ','Hotel',100);
     AdicionaColuna(0,'Código ','ref',50);
     AdicionaColuna(0,'Descrição','text',150);
     AdicionaColuna(0,'typeDoc','typeDoc',60);
     AdicionaColuna(0,'Conta ERP','erpserie',80);


     EscondeChave:=True;
     ChaveNome:='mpehotel';
     AtributoDescricao:='short';
     conexao:=mConexao;

     SQL := ' Select   text, ref,typeDoc,erpserie,lizenz.short as Hotel'
          + ' from '+Shema+'fiscalcdsaft'
          + ' inner join  '+Shema+'lizenz on   '
          + ' lizenz.mpehotel= fiscalcdsaft.mpehotel';


     ID_String:=0;
     ordem:='fiscalcdsaft.mpehotel, fiscalcdsaft.erpserie desc';
     Titulo:='PMS_Tipos de documentos';
     ActivaBotoesOperacoes:=false;
     IDG_SBLista:='{40179CA0-FA6F-4EB6-8C96-9AC1519C3E59}';

  end;

 objListaDef:=Listas.Adiciona('PmsTipoDocCBL','PmsTipoDocCBL');
  with objListaDef do
  begin
     AdicionaColuna(0,'Código ','Ref', 50);
     AdicionaColuna(0,'Descrição','Text',250);
     AdicionaColuna(0,'Hotel','Hotel',100);
     AdicionaColuna(0,'mpehotel','mpehotel',0);


     EscondeChave:=True;
     ChaveNome:='Ref';
     AtributoDescricao:='Text';

     SQL := ' Select   Ref,text,fiscalcd.mpehotel,lizenz.short as Hotel'
          + ' from '+Shema+'fiscalcd'

          + ' inner join  '+Shema+'lizenz on   '
         + 'lizenz.mpehotel= fiscalcd.mpehotel';


     ID_String:=0;
     ActivaBotoesOperacoes:=false;
     IDG_SBLista:='{2A98220F-51CE-4FB2-8FF2-BC5E0FA4D9E4}';

  end;

  objListaDef:=Listas.Adiciona('PmsProdutos','PmsProdutos');
  with objListaDef do
  begin
     AdicionaColuna(0,'Código ','ktonr',50);
     AdicionaColuna(0,'Descrição','bez',150);
     AdicionaColuna(0,'Conta ERP','ContaERP',80);


     EscondeChave:=True;
     ChaveNome:='ktonr';
     AtributoDescricao:='bez';
      Conexao:=mConexao;


     SQL := ' select ktonr,bez ,Gvkonto as ContaERP '
     +' from '+Shema+'ukto '
     +' union all '
     +'select Art.ref,Art.text,artsys.Gvkonto as ContaERP '
     +' from '+Shema+'articles as Art'
     +' inner join '+Shema+'ArticlesPMSSYS as artsys  on Art.ref=artsys.ref ';




     ID_String:=0;
     Titulo:='Pms-Produtos';
     ActivaBotoesOperacoes:=false;
     IDG_SBLista:='{DAB8050C-A46F-498C-ADF3-63578B4E0791}';

  end;


     objListaDef:=Listas.Adiciona('ContasFamilia','ContasFamilia');
  with objListaDef do
  begin
     AdicionaColuna(0,'Código ','kto',50);
     AdicionaColuna(0,'Descrição','Bez',250);

     EscondeChave:=True;
     ChaveNome:='kto';
     AtributoDescricao:='bez';

     SQL := ' Select   *'
          + ' from '+Shema+'ukto';

     ID_String:=0;
     ActivaBotoesOperacoes:=false;
     IDG_SBLista:='{D1DCEFDC-C601-4094-A7CF-A7BD4F5D3A69}';

  end;



  objListaDef:=Listas.Adiciona('PmsIVAS','PmsIVAS');
  with objListaDef do
  begin
     AdicionaColuna(0,'Código ','satznr',50);
     AdicionaColuna(0,'IVA','satz',50);
     AdicionaColuna(0,'Descrição','kennz2',150);
     AdicionaColuna(0,'Conta ERP','ContaERP',80);


     EscondeChave:=True;
     ChaveNome:='satz';
     AtributoDescricao:='kennz2';
      Conexao:=mConexao;

     SQL := ' select satznr,satz,kennz2,account as ContaERP'
          + ' from '+Shema+'mwst'
          +' where account<>''''';

     ID_String:=0;
     Titulo:='Pms-IVAS COM CONTA ERP';
     
     ActivaBotoesOperacoes:=false;
     IDG_SBLista:='{17FF89F8-325F-4E8C-B255-6E4B51F8565B}';

  end;

 objListaDef:=Listas.Adiciona('PmsPagamentos','PmsPagamentos');
  with objListaDef do
  begin
     AdicionaColuna(0,'Código ','ZA',50);
     AdicionaColuna(0,'Descrição','BEZ',150);
     AdicionaColuna(0,'Conta ERP','ContaERP',80);


     EscondeChave:=True;
     ChaveNome:='ZA';
     AtributoDescricao:='BEZ';
      Conexao:=mConexao;

     SQL := ' select  ZA, BEZ,fibukto as ContaERP'
          + ' from '+Shema+'zahlart';


     ID_String:=0;
     Titulo:='Pms-Pagamentos';
     ActivaBotoesOperacoes:=false;
     IDG_SBLista:='{86482D31-3991-4533-8C73-4AA9DB5A218A}';

  end;








        objListaDef:=Listas.Adiciona('zahlart','zahlart');
        with objListaDef do
        begin
           AdicionaColuna(47,'Código','ZA', 60);
           AdicionaColuna(42,'Descrição','Bez',250);

           EscondeChave:=True;
           ChaveNome:='ZA';
           AtributoDescricao:='Bez';

           SQL := 'select *'
                  +'from '+Shema+'zahlart';

           ID_String:=4996;
           Ordem := 'Bez';
           ActivaBotoesOperacoes:=true;
           Conexao:=mConexao;
           IDG_SBLista:='{933DB056-CD49-47BA-BAF4-883273FA1783}';
        end;

      objListaDef:=Listas.Adiciona('pmsReservasDoc','pmsReservasDoc');
        with objListaDef do
        begin
           AdicionaColuna(0,'ID_ReservaHotel','id_reservaHotel', 80);
           AdicionaColuna(0,'Nr_Reserva','nr_reserva', 80);
           AdicionaColuna(0,'Nome_cliente','Nome_cliente', 120);
           AdicionaColuna(0,'Nomequarto','Nomequarto', 60);
           AdicionaColuna(0,'Data_chegada','Data_chegada', 65);
           AdicionaColuna(0,'Data_saida','Data_saida', 65);

           EscondeChave:=True;
           ChaveNome:='nr_reserva';
           AtributoDescricao:='Nomequarto';

           SQL :='select id_reservaHotel, nr_reserva, Nome_cliente,Nomequarto,Data_chegada,Data_saida '
               +'  from '+Shema+'v_reservasHotel ';

           ID_String:=4996;
           Ordem := 'id_reservaHotel,Nomequarto';
           ActivaBotoesOperacoes:=true;
           Conexao:=mConexao;
           IDG_SBLista:='{C1302443-6C82-498E-9009-B7E2F7DD432C}';
        end;










        objListaDef:=Listas.Adiciona('UKTO','Ukto');
        with objListaDef do
        begin
           AdicionaColuna(47,'Código','KTOnr', 60);
           AdicionaColuna(42,'Descrição','Bez',250);

          EscondeChave:=True;
          ChaveNome:='KTOnr';
          AtributoDescricao:='Bez';

          SQL := 'select KTOnr,Bez'
              +' from '+Shema+'Ukto';

          ID_String:=0;
          Ordem := 'Bez';
          ActivaBotoesOperacoes:=true;
          Conexao:=mConexao;
          IDG_SBLista:='{DF17A58D-EAB8-471F-A607-103123A9FA33}'
      end;



      objListaDef:=Listas.Adiciona('Resstat','Resstat');
      with objListaDef do
      begin
         AdicionaColuna(47,'Código','resnr', 60);
         AdicionaColuna(42,'Descrição','resbez',250);

         EscondeChave:=True;
         ChaveNome:='resnr';
         AtributoDescricao:='resbez';

         SQL := 'select resnr,resbez'
              +' from '+Shema+'Resstat';

         ID_String:=0;
         Ordem := 'resbez';
         ActivaBotoesOperacoes:=false;
         Conexao:=mConexao;
         IDG_SBLista:='{B7E967B0-03DD-412A-93BA-C92C2331D474}'
     end;


      objListaDef:=Listas.Adiciona('fiscalcd','fiscalcd');
      with objListaDef do
      begin
         AdicionaColuna(47,'Código','ref', 60);
         AdicionaColuna(42,'Descrição','Text',250);
         AdicionaColuna(0,'clx','clx',0);         

         EscondeChave:=True;
         ChaveNome:='ref';
         AtributoDescricao:='Text';

         SQL := 'select ref,Text,clx'
              +' from '+Shema+'fiscalcd';

         ID_String:=0;
         Ordem := 'Text';
         ActivaBotoesOperacoes:=true;
         Conexao:=mConexao;
         IDG_SBLista:='{4FCA15C4-D69F-4596-9348-9745C2FB76F2}'
     end;

      objListaDef:=Listas.Adiciona('Kunden','Kunden');
      with objListaDef do
      begin
         AdicionaColuna(0,'Código','Kdnr', 60);
         AdicionaColuna(0,'Agencia','name1',250);
         AdicionaColuna(0,'Morada','Strasse',250);

         EscondeChave:=True;
         ChaveNome:='Kdnr';
         AtributoDescricao:='name1';

         SQL := 'select Kdnr,name1,strasse'
              +' from '+Shema+'Kunden';

         ID_String:=0;
         Ordem := 'name1';
         FiltroBase:='typ=3';
         ActivaBotoesOperacoes:=true;
         Conexao:=mConexao;

         IDG_SBLista:='{B97099AB-32B4-44D3-A8F9-3B195534F25E}';
     end;



  end;



end;


procedure CarregaListasSyscontroller(pconexao:string);
var
  i: Integer;

  objListaDef40:TSBListaDef40;
  minterface:TERPBEEMPRESAINTERFACE;
Begin
    minterface:=MotorERP.ERPInterface.InterfaceActivo('ERP_VENDASSYSCONTROLLER');
    objListaDef40:=ListasFnt.Adiciona('Clientes','Cliente');
    with objListaDef40 do
    begin
       AdicionaColuna(47,'Código','VNume', 0);
       AdicionaColuna(0,'Cartão','vcartao',0);
       AdicionaColuna(0,'Cliente','Cliente',250);
       AdicionaColuna(312,'Contribuinte','vcont',90);
       AdicionaColuna(144,'Data Nascimento','Dnasc',0);
       AdicionaColuna(72,'Morada','vMor1',0);
       AdicionaColuna(0,'Telefone','vTelf',0);
       AdicionaColuna(0,'Telemóvel','Vtelem',0);
       AdicionaColuna(0,'Vapel','Vapel',0);
       AdicionaColuna(0,'Vnome','Vnome',0);
       AdicionaColuna(71,'Localidade','vlocalidade',0);

       AdicionaColuna(155,'Email','ve_mail',0);


       AdicionaColuna(0,'fichaanonimizada','fichaanonimizada',0);

       ChaveNome:='VNume';
       AtributoDescricao:='cliente';
       EscondeChave:=True;
       ActivaBotoesOperacoes:=true;

        SQL := 'select * from (select vnume,Vnome,Vapel,Vnome+'' ''+Vapel as Cliente,Vmor1,vlocalidade,'
        +'Dnasc,ve_mail,vcpos,vrua,vcont,vTelf,Vtelem,inactivo,subtipoentidade'
             +', vcartao,fichaanonimizada'
             + ' from tab_cliente ) as x';
        Titulo:= sb.idioma.datraducao(0,'Clientes');
        ID_String:=0;
        IDG_SBLISTA:= '{E5111D2D-18B6-4F96-B228-584A87E12BD2}';
   end;


   objListaDef40:=ListasFnt.Adiciona('CentroExploracao','CentroExploracao');
    with objListaDef40 do
    begin
       AdicionaColuna(0,'icodi','icodi', 0);
       AdicionaColuna(0,'C.Exploração','vdesc',120);
       AdicionaColuna(0,'Interface','Interface',150);
       AdicionaColuna(0,'ID_InterfaceCenExp','ID_InterfaceCenExp',0);


       ChaveNome:='icodi';
       AtributoDescricao:='Vdesc';
       EscondeChave:=True;
       ActivaBotoesOperacoes:=false;


        SQL := ' select Fntinterfacecenexp.ID_InterfaceCenExp,Icodi, Vdesc,Fntinterface.Nome as Interface'
              +' from tab_cenexp'
              +' inner join Fntinterfacecenexp on Fntinterfacecenexp.ID_CentroExploracao='
              +' tab_cenexp.icodi'
              +' inner join Fntinterface on Fntinterfacecenexp.ID_Interface='
              +' Fntinterface.ID_Interface'
              +' where Fntinterfacecenexp.Activo=1 ';
        Titulo:= sb.idioma.datraducao(0,'Centro Exploração/Interface');
        ID_String:=0;
        IDG_SBLISTA:= '{EEF17B38-4E32-4B85-87BC-A868DD6439E7}';
   end;

 objListaDef40:=ListasFnt.Adiciona('InterfaceCentroExploracao','InterfaceCentroExploracao');
    with objListaDef40 do
    begin
       AdicionaColuna(0,'icodi','icodi', 0);
       AdicionaColuna(0,'C.Exploração','vdesc',120);
       AdicionaColuna(0,'Interface','Interface',150);
       AdicionaColuna(0,'ID_InterfaceCenExp','ID_InterfaceCenExp',0);


       ChaveNome:='ID_InterfaceCenExp';
       AtributoDescricao:='Vdesc';
       EscondeChave:=True;
       ActivaBotoesOperacoes:=True;


        SQL := ' select Fntinterfacecenexp.ID_InterfaceCenExp,Icodi, Vdesc,Fntinterface.Nome as Interface'
              +' from tab_cenexp'
              +' inner join Fntinterfacecenexp on Fntinterfacecenexp.ID_CentroExploracao='
              +' tab_cenexp.icodi'
              +' inner join Fntinterface on Fntinterfacecenexp.ID_Interface='
              +' Fntinterface.ID_Interface'
              +' where Fntinterfacecenexp.Activo=1 and Fntinterface.Nome=''Primavera_ERP_VND''';
        Titulo:= sb.idioma.datraducao(0,'Centro Exploração/Interface');
        ID_String:=0;
        IDG_SBLISTA:= '{EB57386D-A8EE-4384-BD50-AC365D919EF7}';
   end;



    objListaDef40:=ListasFnt.Adiciona('TiposDocsContaERP','TiposDocsContaERP');
    with objListaDef40 do
    begin
       AdicionaColuna(0,'Código','ID_TipodocVnd', 80);
       AdicionaColuna(0,'Descricao','Descricao',120);
       AdicionaColuna(0,'Conta ERP','ContaERP',80);

       ChaveNome:='ID_TipodocVnd';
       AtributoDescricao:='Descricao';
       EscondeChave:=True;
       ActivaBotoesOperacoes:=true;
  

        SQL := ' select ID_TipodocVnd,Descricao,ContaERP'
              +' from TipodocVnd'
              +' where Tipodocumento<>7 and TipodocVnd.Ativo=1 and isnull(TipodocVnd.ContaERP,'''')<>''''';
        Titulo:= sb.idioma.datraducao(0,'TiposDocsContaERP');
        ID_String:=0;
        Titulo:='Lista de Tipos Documentos/ CONTAS ERP';
        IDG_SBLISTA:= '{091903F1-C112-4F50-BEA0-F597779BAFE2}';
   end;


    objListaDef40:=ListasFnt.Adiciona('TiposDocsSemContaERP','TiposDocsSemContaERP');
    with objListaDef40 do
    begin
       AdicionaColuna(0,'Código','ID_TipodocVnd', 80);
       AdicionaColuna(0,'Abreviatura','Abreviatura',120);
       AdicionaColuna(0,'Descricao','Descricao',120);
              

       ChaveNome:='ID_TipodocVnd';
       AtributoDescricao:='Descricao';
       EscondeChave:=True;
       ActivaBotoesOperacoes:=false;

        SQL := ' select ID_TipodocVnd,Descricao,abreviatura,ContaERP'
              +' from TipodocVnd'
              +' where Tipodocumento<>7 and TipodocVnd.Ativo=1 and isnull(TipodocVnd.ContaERP,'''')=''''';
        Titulo:= sb.idioma.datraducao(0,'Tipos Doc.Venda sem Conta ERP');
        ID_String:=0;
        Titulo:='Lista de Tipos Documentos sem CONTA ERP';
        IDG_SBLISTA:= '{2EE679F8-426F-4801-A556-45627D902136}';
   end;

       objListaDef40:=ListasFnt.Adiciona('Inventarios','Inventarios');
    with objListaDef40 do
    begin
       AdicionaColuna(0,'id_inventario','id_inventario', 0);
       AdicionaColuna(0,'descricao','descricao',120);
       AdicionaColuna(0,'DataInicio','DataInicio',80);
       AdicionaColuna(0,'DataFim','DataFim',80);
              

       ChaveNome:='id_inventario';
       AtributoDescricao:='Descricao';
       EscondeChave:=True;
       ActivaBotoesOperacoes:=false;

        SQL :=' select id_inventario,descricao,DataInicio,DataFim from CabInventario '
        +' inner join Periodo on CabInventario.ID_Periodo=periodo.ID_Periodo '
        +' where Estado=1 ';
        Titulo:= sb.idioma.datraducao(0,'Tipos Doc.Venda sem Conta ERP');
        ID_String:=0;
        Titulo:='Lista de Inventarios Concluídos por exportar';
        IDG_SBLISTA:= '{AB22E259-F6FF-4AAC-83FD-74F14DDE4C40}';
   end;


    objListaDef40:=ListasFnt.Adiciona('ProdutosComContaERP','ProdutosComContaERP');
    with objListaDef40 do
    begin

       AdicionaColuna(0,'Sub.Familia','SubFamilia',120);
       AdicionaColuna(0,'Código','Vproduto', 65);
       AdicionaColuna(0,'Produto','Vdesc1',200);
       AdicionaColuna(0,'Conta ERP','ContaCbl',80);
       AdicionaColuna(0,'ClassificacaoProduto','ClassificacaoProduto',0);



       ChaveNome:='Vproduto';
       AtributoDescricao:='Vdesc1';
       EscondeChave:=True;
       ActivaBotoesOperacoes:=true;



     SQL:='select distinct TAB_PRODUTO.Vproduto,TAB_PRODUTO.vdesc1,TAB_PRODUTO.contacbl,'
        +' TAB_SubFam.VCodSubFam,TAB_SubFam.VDesc as SubFamilia,TAB_PRODUTO.ClassificacaoProduto'
        + '  from TAB_PRODUTO'
        +' INNER JOIN TAB_SubFam ON TAB_PRODUTO.VSUBFAM = TAB_SubFam.VCodSubFam '

              +' where TAB_PRODUTO.Activo=1 ';
        Ordem:='TAB_SubFam.VDesc,TAB_PRODUTO.vdesc1';
        ID_String:=0;
        Titulo:='Lista de Produtos/ CONTAS ERP';
        IDG_SBLISTA:= '{C8909B2A-B3D9-454C-B086-AC908D3B82B8}';

     AdicionaFiltro('{48FE7BFC-419C-4541-B187-D6967E8319D3}',sb.idioma.datraducao(0,'Venda'), '  ClassificacaoProduto=0');
     AdicionaFiltro('{77DD597A-9CB2-4D0B-AF4B-E46336709C3A}',sb.idioma.datraducao(0,'Compra'),'  ClassificacaoProduto=1');
     AdicionaFiltro('{2E04251A-48FB-4420-93DB-A67BC0541465}',sb.idioma.datraducao(0,'Compra/Venda'),'  ClassificacaoProduto =2');
     AdicionaFiltro('{A978EC09-B1D2-41C1-AEC6-2E254F566CEF}',sb.idioma.datraducao(0,'Todos'),'  ClassificacaoProduto in(0,1,2)');


   end;
   //IVAS


    objListaDef40:=ListasFnt.Adiciona('IVASComContaERP','IVASComContaERP');
    with objListaDef40 do
    begin

       AdicionaColuna(0,'ID_IVA','ID_IVA',60);
       AdicionaColuna(0,'IVA','Percentagem', 80);
       AdicionaColuna(0,'Descricao','VDESC', 150);
       AdicionaColuna(0,'TaxExceptionReason','TaxExceptionReason',0);
       AdicionaColuna(0,'Conta ERP','ContaCBL',80);


       ChaveNome:='ID_IVA';
       AtributoDescricao:='VDESC';
       EscondeChave:=True;
       ActivaBotoesOperacoes:=true;



     SQL:='select vcodi as ID_IVA,NPerc as Percentagem,TaxExceptionReason,vdesc,ContaCBL'
        +' from  Tab_iva'
        +' where  isnull(Tab_iva.ContaCBL,'''')<>''''';
        Ordem:='Tab_iva.NPerc';
        ID_String:=0;
        Titulo:='Lista de IVAS/ CONTAS ERP';
        IDG_SBLISTA:= '{D50DC449-3A8B-42D0-8F43-79C1C733608A}';
   end;


    objListaDef40:=ListasFnt.Adiciona('IVASSEMContaERP','IVASSEMContaERP');
    with objListaDef40 do
    begin

       AdicionaColuna(0,'ID_IVA','ID_IVA',60);
       AdicionaColuna(0,'IVA','Percentagem', 80);
       AdicionaColuna(0,'Descricao','VDESC', 150);
       AdicionaColuna(0,'TaxExceptionReason','TaxExceptionReason',0);
       AdicionaColuna(0,'Conta ERP','ContaCBL',80);


       ChaveNome:='ID_IVA';
       AtributoDescricao:='VDESC';
       EscondeChave:=True;
       ActivaBotoesOperacoes:=true;



     SQL:='select vcodi as ID_IVA,NPerc as Percentagem,TaxExceptionReason,vdesc,ContaCBL'
        +' from  Tab_iva'
        +' where  isnull(Tab_iva.ContaCBL,'''')=''''';
        Ordem:='Tab_iva.NPerc';
        ID_String:=0;
        Titulo:='Lista de IVAS/ CONTAS ERP';
        IDG_SBLISTA:= '{8BFE1638-4036-49E7-894C-5BF8664B527D}';
   end;

   //pagamentos


    objListaDef40:=ListasFnt.Adiciona('PagamentosComContaERP','PagamentosComContaERP');
    with objListaDef40 do
    begin

       AdicionaColuna(0,'Codigo','VCODPAG',60);
       AdicionaColuna(0,'Descricao','VDESCPAG', 150);
       AdicionaColuna(0,'Conta ERP','ContaCBL',80);


       ChaveNome:='VCODPAG';
       AtributoDescricao:='VDESCPAG';
       EscondeChave:=True;
       ActivaBotoesOperacoes:=true;

     SQL:='select VCODPAG,VDESCPAG,VACTIVO,ContaCBL'
        +' from tab_metodopag '
        +' where vactivo=1 and  isnull(tab_metodopag.ContaCBL,'''')<>''''';
        Ordem:='tab_metodopag.VDESCPAG';
        ID_String:=0;
        Titulo:='Lista de Pagamentos/ CONTAS ERP';
        IDG_SBLISTA:= '{4F30D19F-62D5-4CC1-B297-1AF7484FC7B9}';
   end;


    objListaDef40:=ListasFnt.Adiciona('PagamentosSemContaERP','PagamentosSemContaERP');
    with objListaDef40 do
    begin

       AdicionaColuna(0,'VCODPAG','VCODPAG',60);
       AdicionaColuna(0,'Descrição','VDESCPAG', 150);
       AdicionaColuna(0,'Conta ERP','ContaCBL',80);


       ChaveNome:='VCODPAG';
       AtributoDescricao:='VDESCPAG';
       EscondeChave:=True;
       ActivaBotoesOperacoes:=true;


     SQL:='select VCODPAG,VDESCPAG,VACTIVO,ContaCBL'
        +' from tab_metodopag '
        +' where vactivo=1 and   isnull(tab_metodopag.ContaCBL,'''')=''''';
        Ordem:='tab_metodopag.VDESCPAG';
        ID_String:=0;
        Titulo:='Lista de Pagamentos/ CONTAS ERP';
        IDG_SBLISTA:='{2B009969-AD0A-426C-8ED2-46E155B2D448}';
   end;




   objListaDef40:=ListasFnt.Adiciona('SubFamProdutos','SubfamProdutos');
    with objListaDef40 do
    begin


       AdicionaColuna(0,'Código','VCodSubFam', 80);
       AdicionaColuna(0,'Sub.Familia','SubFamilia',200);


       ChaveNome:='VCodSubFam';
       AtributoDescricao:='SubFamilia';
       EscondeChave:=True;
       ActivaBotoesOperacoes:=false;



       SQL:='select  '
         +' TAB_SubFam.VCodSubFam,TAB_SubFam.VDesc as SubFamilia'
        + '  from TAB_SubFam';
        Ordem:='TAB_SubFam.VDesc';
        ID_String:=0;
        Titulo:='Lista de Sub.Fam.Produtos';
        IDG_SBLISTA:= '{F260F42D-DCF5-40CF-9AE9-349891EE9182}';
   end;




 

  objListaDef40:=ListasFnt.Adiciona('TipoComunicacao');
  with objListaDef40 do
  begin
     AdicionaColuna(47,'Código','TipoComunicacao',0);
     AdicionaColuna(42,'Descrição','Descricao',250);

     EscondeChave:=True;
     MultiSeleccao:=false;
     ActivaBotaoDuplicar:=false;
     Titulo:='Tipos de Comunicação';
     IDG_SBLista:='{B600D1E6-A3F8-4C3D-A8A5-C80286B11316}';
     ordem:='descricao';
  end;



  objListaDef40:=ListasFnt.Adiciona('TipoComunicaoOBS','TipoComunicaoOBS');
  with objListaDef40 do
  begin
     AdicionaColuna(47,'Código','TipoComunicacao',0);
     AdicionaColuna(0,'Descrição','Descricao',120);
     AdicionaColuna(0,'Detalhe','Observacoes',450);


     SQL := 'select TipoComunicacao,Descricao, cast(Observacoes as varchar (400)) as Observacoes from TipoComunicacao';

     EscondeChave:=True;
     MultiSeleccao:=false;
     ActivaBotaoDuplicar:=false;
     Titulo:='Tipos de Comunicação';
     ChaveNome:='TipoComunicacao';
     AtributoDescricao:='Observacoes';

     IDG_SBLista:='{A485D4BD-EB70-4406-8149-C2B8C85201DA}';
     ordem:='descricao';
  end;



  objListaDef40:=ListasFnt.Adiciona('GrupoUtilizadorSelecao');
  with objListaDef40 do
  begin
    AdicionaColuna(2507,'Grupo Utilizador','vGUtil', 150);
    AdicionaColuna(42,'Descrição','vDesc', 250);
    AdicionaColuna(2407,'Nível','sNive', 60);
    FiltroBase:='GrpUtilizadorInterno=0 and vgutil<>''MICRONET''';
    ChaveTipoDados:=tdString;
    ChaveNome:='vGUtil';
    AtributoDescricao:='vDesc';
    EscondeChave:=False;
    ActivaBotoesOperacoes:=false;
    ActivaBotaoDuplicar:=false;

    ID_String := 4159;
    IDG_SBLista:='{6A7EF288-7A3F-4FE6-96F1-51D14F6A9B14}';
   end;

  objListaDef40:=ListasFnt.Adiciona('CCCondicaoPagamento');
  with objListaDef40 do
  begin
     AdicionaColuna(47,'Código','ID_CCCondicaoPagamento', 0);
     AdicionaColuna(54,'Abreviatura','Abreviatura',100);
     AdicionaColuna(42,'Descrição','Descricao',250);

     EscondeChave:=True;

     ID_String:=2311;
     IDG_SBLista:='{39AA9FD3-DA37-487E-B1E6-0592C32D9109}';
  end;
  //tipo documentos de compras

    objListaDef40:=ListasFnt.Adiciona('TiposDocsComprasContaERP','TiposDocsComprasContaERP');
    with objListaDef40 do
    begin
       AdicionaColuna(0,'Código','ID_Tipomovimento', 80);
       AdicionaColuna(0,'Descricao','Descricao',120);
       AdicionaColuna(0,'Conta ERP','ContaERP',80);

       ChaveNome:='ID_Tipomovimento';
       AtributoDescricao:='Descricao';
       EscondeChave:=True;
       ActivaBotoesOperacoes:=true;


        SQL := ' select ID_Tipomovimento,Descricao,ContaERP'
              +' from Tipomovimento'
              +' where  isnull(Tipomovimento.ContaERP,'''')<>''''';
        ID_String:=0;
        Titulo:='Lista de Tipos Docs. Stocks/Com CONTA ERP';
        IDG_SBLISTA:= '{A040F56B-0AA4-4108-923F-69CD614032C4}';
   end;


    objListaDef40:=ListasFnt.Adiciona('TiposDocsComprasSemContaERP','TiposDocsComprasSemContaERP');
      with objListaDef40 do
    begin
       AdicionaColuna(0,'Código','ID_Tipomovimento', 80);
       AdicionaColuna(0,'Descricao','Descricao',120);
       AdicionaColuna(0,'Conta ERP','ContaERP',80);

       ChaveNome:='ID_Tipomovimento';
       AtributoDescricao:='Descricao';
       EscondeChave:=True;
       ActivaBotoesOperacoes:=true;


        SQL := ' select ID_Tipomovimento,Descricao,ContaERP'
              +' from Tipomovimento'
              +' where  isnull(Tipomovimento.ContaERP,'''')=''''';
        Titulo:= sb.idioma.datraducao(0,'Tipos Docs.Stocks');
        ID_String:=0;
        Titulo:='Lista de Tipos Docs.Stocks/Sem CONTAS ERP';
        IDG_SBLISTA:= '{EF85839D-30BD-42E0-AD71-E531369FDAD1}';
   end;




   //aramzem compras

    objListaDef40:=ListasFnt.Adiciona('ArmazemContaERP','ArmazemContaERP');
    with objListaDef40 do
    begin
       AdicionaColuna(0,'Código','ID_Armazem', 80);
       AdicionaColuna(0,'Descricao','Descricao',120);
       AdicionaColuna(0,'Conta ERP','ContaERP',80);

       ChaveNome:='ID_Armazem';
       AtributoDescricao:='Descricao';
       EscondeChave:=True;
       ActivaBotoesOperacoes:=true;


        SQL := ' select ID_Armazem,Descricao,ContaERP'
              +' from Armazem'
              +' where  isnull(Armazem.ContaERP,'''')<>''''';
        ID_String:=0;
        Titulo:='Lista de Armazéns/Com CONTA ERP';
        IDG_SBLISTA:= '{C1563CE9-1433-4459-B495-983DED425772}';
   end;


    objListaDef40:=ListasFnt.Adiciona('ArmazemSemContaERP','ArmazensSemContaERP');
      with objListaDef40 do
    begin
       AdicionaColuna(0,'Código','ID_Armazem', 80);
       AdicionaColuna(0,'Descricao','Descricao',120);
       AdicionaColuna(0,'Conta ERP','ContaERP',80);

       ChaveNome:='ID_Armazem';
       AtributoDescricao:='Descricao';
       EscondeChave:=True;
       ActivaBotoesOperacoes:=true;


        SQL := ' select ID_Armazem,Descricao,ContaERP'
              +' from Armazem'
              +' where  isnull(Armazem.ContaERP,'''')=''''';

        ID_String:=0;
        Titulo:='Lista de Armazéns/Sem CONTAS ERP';
        IDG_SBLISTA:= '{6D996931-1D2F-4AC2-8259-D072FE29296D}';
   end;


end;


end.
