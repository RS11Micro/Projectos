unit ERPEnvioEmail;

interface
uses  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvOfficeButtons, StdCtrls, AdvGroupBox, ExtCtrls, AdvPanel,
  AdvToolBar,EASendMailObjLib_TLB,inifiles,SBControlos,sbbotoes,sbbetabeladados;

procedure EnviaEmail(passunto,pmensagem:string);
Procedure InsereRegistoLogEmail(pTipoInterface:integer;pID_Movimento:Integer;pDescmovimento,pMensagem:string);
Procedure EnviaEmailErroExporAuto(pTipoInterface:integer;pID_Movimento:Integer;passunto,pdescMovimento,pmensagem:string);

implementation

uses Ierpoglobais,IERPFrmPrincipal, SBBSSistemaBase, SBBSUtilSQL,
  SBBaseDados, SBBSCifraNum;





procedure DirectSend(oSmtp: TMail);
var
  Rcpts: OleVariant;
  i, RcptBound: integer;
  RcptAddr: WideString;
begin
  Rcpts := oSmtp.Recipients;
  RcptBound := VarArrayHighBound( Rcpts, 1 );
  for i := 0 to RcptBound do
  begin
    RcptAddr := VarArrayGet( Rcpts, i );
    oSmtp.ClearRecipient();
    oSmtp.AddRecipientEx( RcptAddr, 0 );
    if oSmtp.SendMail() = 0 then
    begin

//      FEnviouMail:=true;
    end
    else
    begin
  //    FultimoErro:=oSmtp.GetLastErrDescription();
    //  FEnviouMail:=false;
    end;
  end;
end;


// before delphi doesn't support unicode very well in VCL, so
// we have to convert the ansistring to unicode by current default codepage.
function ChAnsiToWide(const StrA: AnsiString): WideString;
var
  nLen: integer;
begin
  Result := StrA;
  if Result <> '' then
  begin
    // convert ansi string to widestring (unicode) by current system codepage
    nLen := MultiByteToWideChar(GetACP(), 1, PansiChar(@StrA[1]), -1, nil, 0);
    SetLength(Result, nLen - 1);
    if nLen > 1 then
      MultiByteToWideChar(GetACP(), 1, PansiChar(@StrA[1]), -1, PWideChar(@Result[1]), nLen - 1);
  end;
end;


procedure EnviaEmail(passunto,pmensagem:string);
var
  oSmtp: TMail;
  i: integer;
  Rcpts: OleVariant;
  RcptBound: integer;
  RcptAddr: WideString;
  oEncryptCert: TCertificate;
  StrBody:string;
  Strpassword:string;

begin

  // Create TMail Object
  oSmtp := TMail.Create(Application);

//  pb 11-01.2019 coloquei a licenca do componente
  //  oSmtp.LicenseCode := 'TryIt';
  oSmtp.LicenseCode := 'ES-AA1141023508-00608-2EB7A4D3E62E33173F0126318532560E';


//  oSmtp.Charset := m_arCharset[lstCharset.ItemIndex, 1];
  oSmtp.FromAddr := ChAnsiToWide(trim(FrmIERPPrincipal.POP3FromUser));

  // Add recipient's
  oSmtp.AddRecipientEx(ChAnsiToWide(trim(FrmIERPPrincipal.POP3EMailTO)), 0 );

  // Set subject
  oSmtp.Subject := ChAnsiToWide(FrmIERPPrincipal.EMailHotel+'_Integration ERP: '+passunto);

  oSmtp.BodyFormat := 0;
  // Set body
  StrBody:=pmensagem;
  oSmtp.ImportHtml( StrBody, GetCurrentDir());


  // get all to, cc, bcc email address to an array
  Rcpts := oSmtp.Recipients;
  RcptBound := VarArrayHighBound( Rcpts, 1 );

  oSmtp.ServerAddr := trim(FrmIERPPrincipal.POP3ServerConta);



  if oSmtp.ServerAddr <> '' then
  begin
    if FrmIERPPrincipal.SMTPAuthenticationType=1 then
    begin
      oSmtp.UserName := trim( FrmIERPPrincipal.SMTPUSERAutenticacao);
      Strpassword:= sb.Cifranum.DecifraString( FrmIERPPrincipal.SMTPServerPassword,20);
      oSmtp.Password := trim(Strpassword);
    end;
 end;
  if (RcptBound > 0) and (oSmtp.ServerAddr = '') then
  begin
    // To send email without specified smtp server, we have to send the emails one by one
    // to multiple recipients. That is because every recipient has different smtp server.
    DirectSend( oSmtp );

    exit;
  end;

  if oSmtp.SendMail() = 0 then
  begin
//   ShowMessage('envioumail');
//    FEnviouMail:=true;
  end
  else
  begin
 //   FultimoErro:= oSmtp.GetLastErrDescription();
 //  ShowMessage('nao envioumail');
  //  FEnviouMail:=false;
  end;


end;

Function MailErroJaEnviado(TipoInterface:integer;pID_Movimento:Integer):boolean;
var
 listabd:tsbbetabeladados;
 strsql:string;
begin
  result:=false;

  strsql:='select * from ERP_LogMail where TipoInterface='+inttostr(TipoInterface)
  +' and ID_Movimento='+inttostr(pID_Movimento)
  +' and data ='+ sb.UtilSQL.DataToSQLData(sb.DataSistema);
  listabd:=sb.SBBD.AbrirLV(strsql);
  Result:= not(listabd.Vazia);
  listabd.Fecha;
  Freeandnil(listabd);
end;

Procedure InsereRegistoLogEmail(pTipoInterface:integer;pID_Movimento:Integer;pDescmovimento,pMensagem:string);
var
  strsql:string;
  DescInterface:string;
begin
  if   pTipoInterface=1 then
        DescInterface:= 'ERP_VENDASPROTEL'
  else
  if   pTipoInterface=2 then
    DescInterface:= 'ERP_VENDASSYSCONTROLLER'
  else
  if   pTipoInterface=3 then
    DescInterface:= 'ERP_COMPRASSYSCONTROLLER'
  else
  if   pTipoInterface=4 then
          DescInterface:= 'ERP_INVENTARIOS'

  else
  if   pTipoInterface=5 then
          DescInterface:= 'CBL_VendasProtel';

  strsql:=' insert into ERP_LogMail(TipoInterface,DescInterface,Data,ID_Movimento,DescMovimento,mensagem)'
  +' values('+Inttostr(pTipoInterface)
  +','+sb.UtilSQL.StrToSQLStrpelica(DescInterface)
  +','+sb.UtilSQL.DataToSQLData(sb.DataSistema)
  +','+Inttostr(pID_Movimento)
  +','+sb.UtilSQL.StrToSQLStrpelica(pDescmovimento)
  +','+sb.UtilSQL.StrToSQLStrpelica(pMensagem)
  +')';
  sb.SBBD.Executa(strsql);
end;



procedure EnviaEmailErroExporAuto(pTipoInterface:integer;pID_Movimento:Integer;passunto,pdescMovimento,pmensagem:string);
var
  oSmtp: TMail;
  i: integer;
  Rcpts: OleVariant;
  RcptBound: integer;
  RcptAddr: WideString;
  oEncryptCert: TCertificate;
  StrBody,Strpassword:string;
  segue:Boolean;
begin
  segue:=true;

  If not (MailErroJaEnviado(pTipoInterface,pID_Movimento)) then
  Begin
     InsereRegistoLogEmail(pTipoInterface,pID_Movimento,pDescmovimento,pMensagem);
  End
  Else
  begin
   segue:=false;
  end;

  If segue then
  begin
      // Create TMail Object
      oSmtp := TMail.Create(Application);
//  pb 11-01.2019 coloquei a licenca do componente  
//  oSmtp.LicenseCode := 'TryIt';
  oSmtp.LicenseCode := 'ES-AA1141023508-00608-2EB7A4D3E62E33173F0126318532560E';

    //  oSmtp.Charset := m_arCharset[lstCharset.ItemIndex, 1];
      oSmtp.FromAddr := ChAnsiToWide(trim(FrmIERPPrincipal.POP3FromUser));

      // Add recipient's
      oSmtp.AddRecipientEx(ChAnsiToWide(trim(FrmIERPPrincipal.POP3EMailTO)), 0 );

      // Set subject
      oSmtp.Subject := ChAnsiToWide('Integration ERP: '+passunto);

      oSmtp.BodyFormat := 0;
      // Set body
      StrBody:=pmensagem;
      oSmtp.ImportHtml( StrBody, GetCurrentDir());


      // get all to, cc, bcc email address to an array
      Rcpts := oSmtp.Recipients;
      RcptBound := VarArrayHighBound( Rcpts, 1 );


      oSmtp.ServerAddr := trim(FrmIERPPrincipal.POP3ServerConta);

     if oSmtp.ServerAddr <> '' then
      begin
        if FrmIERPPrincipal.SMTPAuthenticationType=1 then
        begin
          oSmtp.UserName := trim( FrmIERPPrincipal.SMTPUSERAutenticacao);
          Strpassword:= sb.Cifranum.DecifraString( FrmIERPPrincipal.SMTPServerPassword,20);
          oSmtp.Password := trim(Strpassword);
        end;
     end;
      if (RcptBound > 0) and (oSmtp.ServerAddr = '') then
      begin
        // To send email without specified smtp server, we have to send the emails one by one
        // to multiple recipients. That is because every recipient has different smtp server.
        DirectSend( oSmtp );

        exit;
      end;

      if oSmtp.SendMail() = 0 then
      begin
    //   ShowMessage('envioumail');
    //    FEnviouMail:=true;
      end
      else
      begin
     //   FultimoErro:= oSmtp.GetLastErrDescription();
     //  ShowMessage('nao envioumail');
      //  FEnviouMail:=false;
      end;
  end;

end;




end.
