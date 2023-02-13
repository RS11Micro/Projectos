unit ERP_FrmContaMail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvOfficeButtons, StdCtrls, AdvGroupBox, ExtCtrls, AdvPanel,
  AdvToolBar,EASendMailObjLib_TLB,inifiles,SBControlos,sbbotoes;

type
  TFrmERP_ContaMail = class(TForm)
    AdvDockPanel2: TAdvDockPanel;
    sbPanelLateral: TAdvToolBar;
    btConfirmar: TAdvToolBarButton;
    btCancelar: TAdvToolBarButton;
    AdvPanel1: TAdvPanel;
    lbsbConta1: TLabel;
    LbsbNomeconta: TLabel;
    EdNomeConta: TEdit;
    edConta: TEdit;
    gbsbUtilizador: TAdvGroupBox;
    lbsbEmail: TLabel;
    lbsbNome: TLabel;
    edFromNome: TEdit;
    edFromMail: TEdit;
    grpsmtp: TAdvGroupBox;
    Label8: TLabel;
    Label7: TLabel;
    EdUserAutenticacao: TEdit;
    edtPassword: TEdit;
    AdvGroupBox17: TAdvGroupBox;
    Label4: TLabel;
    edEmailTo: TEdit;
    chkAuth: TAdvOfficeCheckBox;
    btnSend: TButton;
    btverpass: TButton;
    Label1: TLabel;
    EDHotelMail: TEdit;
    procedure btnSendClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btConfirmarClick(Sender: TObject);
    procedure chkAuthClick(Sender: TObject);
    procedure btverpassClick(Sender: TObject);

  private
    { Private declarations }
    function ChAnsiToWide(const StrA: AnsiString): WideString;
    procedure DirectSend(oSmtp: TMail);
    function Validagravacao(var merros:string):boolean;
    procedure preenchedados;
  public
    { Public declarations }
  end;

var
  FrmERP_ContaMail: TFrmERP_ContaMail;

implementation
uses Ierpoglobais,IERPFrmPrincipal, SBBSCifraNum;

{$R *.dfm}
procedure TFrmERP_ContaMail.preenchedados;
begin
 with FrmIERPPrincipal do
 begin
  edConta.Text:=POP3ServerConta;
  EdNomeConta.Text:=POP3ServerNameConta;
  edFromNome.Text :=POP3FromUser;
  edFromMail.Text:=POP3FromMail;
  edEmailTo.Text:=POP3EMailTO;
  EDHotelMail.Text:=EMailHotel;

  if SMTPAuthenticationType=1 then
  begin
     chkAuth.checked:=true;
     grpsmtp.Enabled:=true;
     EdUserAutenticacao.Enabled:=true;
     edtPassword.Enabled:=true;

  end
  else
  begin
     chkAuth.checked:=false;
     grpsmtp.Enabled:=false;
     EdUserAutenticacao.Enabled:=false;
     edtPassword.Enabled:=false;

  end;
  EdUserAutenticacao.Text:=SMTPUSERAutenticacao;
  If SMTPServerPassword<>'' then
          edtPassword.Text:=  sb.Cifranum.DecifraString(SMTPServerPassword,20);

 end;
end;

procedure TFrmERP_ContaMail.DirectSend(oSmtp: TMail);
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
function TFrmERP_ContaMail.ChAnsiToWide(const StrA: AnsiString): WideString;
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


procedure TFrmERP_ContaMail.btnSendClick(Sender: TObject);
var
  oSmtp: TMail;
  i: integer;
  Rcpts: OleVariant;
  RcptBound: integer;
  RcptAddr: WideString;
  oEncryptCert: TCertificate;
  StrBody:string;

begin
  if trim(edFromMail.Text) = '' then
  begin
    ShowMessage( 'Please input From email address!' );
    edFromMail.SetFocus();
    exit;
  end;

  if(trim(edEmailTo.Text) = '' )then
  begin
    ShowMessage( 'Please input To or Cc email addresses, please use comma(,) to separate multiple addresses!');
    edEmailTo.SetFocus();
    exit;
  end;

  if chkAuth.Checked and ((trim(EdUserAutenticacao.Text)='') or
  (trim(edtPassword.Text)='')) then
  begin
    ShowMessage( 'Please input User, Password for SMTP authentication!' );
    edEmailTo.SetFocus();
    exit;
  end;

  btnSend.Enabled := false;
  // Create TMail Object
  oSmtp := TMail.Create(Application);
//  pb 11-01.2019 coloquei a licenca do componente  
//  oSmtp.LicenseCode := 'TryIt';
  oSmtp.LicenseCode := 'ES-AA1141023508-00608-2EB7A4D3E62E33173F0126318532560E';


//  oSmtp.Charset := m_arCharset[lstCharset.ItemIndex, 1];
  oSmtp.FromAddr := ChAnsiToWide(trim(edFromMail.Text));

  // Add recipient's
  oSmtp.AddRecipientEx(ChAnsiToWide(trim(edEmailTo.Text)), 0 );
//  oSmtp.AddRecipientEx(ChAnsiToWide(trim(textCc.Text)), 1 );
  //  oSmtp.AddRecipientEx(ChAnsiToWide(trim(TextBCC.Text)), 2 );

  // Set subject
  oSmtp.Subject := ChAnsiToWide(EDHotelMail.text+'_TesteEmail');

    oSmtp.BodyFormat := 0;




  // Set body
 StrBody:='teste';




// oSmtp.BodyText := StrBody;

 oSmtp.ImportHtml( StrBody, GetCurrentDir());







  // get all to, cc, bcc email address to an array
  Rcpts := oSmtp.Recipients;
  RcptBound := VarArrayHighBound( Rcpts, 1 );
  // search encrypting cert for every recipient.
 { if chkEncrypt.Checked then
    for i := 0 to RcptBound do
    begin
       RcptAddr := VarArrayGet( Rcpts, i );
       oEncryptCert := TCertificate.Create(Application);
       if not oEncryptCert.FindSubject(RcptAddr,
          CERT_SYSTEM_STORE_CURRENT_USER, 'AddressBook' ) then
          if not oEncryptCert.FindSubject(RcptAddr,
            CERT_SYSTEM_STORE_CURRENT_USER, 'my' ) then
          begin
            ShowMessage( 'Failed to find cert for ' + RcptAddr + ': ' + oEncryptCert.GetLastError());
            btnSend.Enabled := true;
            exit;
          end;

       oSmtp.RecipientsCerts.Add(oEncryptCert.DefaultInterface);
    end;
           }
  oSmtp.ServerAddr := trim(EdConta.Text);
  if oSmtp.ServerAddr <> '' then
  begin
    if chkAuth.Checked then
    begin
      oSmtp.UserName := trim(EdUserAutenticacao.Text);
      oSmtp.Password := trim(edtPassword.Text);
    end;

   { if chkSSL.Checked then
    begin
      oSmtp.SSL_init();
      // If SSL port is 465, please add the following codes
      // oSmtp.ServerPort := 465;
      // oSmtp.SSL_starttls := 0;
    end; }
  end;

  if (RcptBound > 0) and (oSmtp.ServerAddr = '') then
  begin
    // To send email without specified smtp server, we have to send the emails one by one
    // to multiple recipients. That is because every recipient has different smtp server.
    DirectSend( oSmtp );
    btnSend.Enabled := true;
    exit;
  end;

  if oSmtp.SendMail() = 0 then
  begin

//    FEnviouMail:=true;
  end
  else
  begin
 //   FultimoErro:= oSmtp.GetLastErrDescription();
  //  FEnviouMail:=false;
  end;

  btnSend.Enabled := true;
end;

procedure TFrmERP_ContaMail.FormCreate(Sender: TObject);
begin

  FormataFormPorDefeito(Self);
  FormataBotoes(Self);
  preenchedados;
  showmodal;
end;

procedure TFrmERP_ContaMail.btCancelarClick(Sender: TObject);
begin
 self.close;
end;

procedure TFrmERP_ContaMail.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action:=cafree;
end;

function TFrmERP_ContaMail.Validagravacao(var merros:string):boolean;
begin
  result:=true;
  if  EdNomeConta.Text='' then
  begin
     result:=false;
     merros:=merros+'Incoming Mail Server (POP) não preenchido;';
  end;

  if    edFromMail.Text='' then
  begin
     result:=false;
     merros:=merros+'From não preenchido;';

  end;

  if    edEmailTo.Text='' then
  begin
     result:=false;
     merros:=merros+'Send to não preenchido;';

  end;

end;
procedure TFrmERP_ContaMail.btConfirmarClick(Sender: TObject);
var
  MailIni: TIniFile;
  mPassEncriptada,merros:string;
begin
  if Validagravacao(merros) then
  begin
  MailIni := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Mail.ini');
  with MailIni do
  begin
    WriteString('Pop3', 'ServerConta', edConta.Text);
    WriteString('Pop3', 'ServerNameConta', EdNomeConta.Text);

    WriteString('Pop3', 'FromUser', edFromNome.Text);

    WriteString('Pop3', 'FromMail',edFromMail.Text);

    WriteString('Pop3', 'EMailTO',edEmailTo.Text);

    WriteString('Pop3', 'EMailHotel',EDHotelMail.Text);






    If  chkAuth.checked then
        WriteInteger('Smtp', 'SMTPAuthenticationType', 1)
    else
    WriteInteger('Smtp', 'SMTPAuthenticationType', 0);
    WriteString('Smtp', 'USERAutenticacao', EdUserAutenticacao.Text);


    WriteString('Smtp', 'ServerPassword', sb.Cifranum.CifraString(edtPassword.Text,20));

    FrmIERPPrincipal.POP3ServerConta:=edConta.Text;
    FrmIERPPrincipal.POP3ServerNameConta:=EdNomeConta.Text;

    FrmIERPPrincipal.POP3FromUser:=edFromNome.Text;
    FrmIERPPrincipal.POP3FromMail:=edFromMail.Text;
    FrmIERPPrincipal.POP3EMailTO:=edEmailTo.Text;
    FrmIERPPrincipal.EMailHotel:=EDHotelMail.Text;


    If chkAuth.checked then
     FrmIERPPrincipal.SMTPAuthenticationType:=1
    else
     FrmIERPPrincipal.SMTPAuthenticationType:=0;
    FrmIERPPrincipal.SMTPUSERAutenticacao:=EdUserAutenticacao.Text;
    FrmIERPPrincipal.SMTPServerPassword:=edtPassword.Text;


  end;
  MailIni.Free;
  showmessage('Dados gravados com sucesso');
  end
  else
  showmessage(merros);
end;


procedure TFrmERP_ContaMail.chkAuthClick(Sender: TObject);
begin
  if chkAuth.Checked then
  begin
   EdUserAutenticacao.Enabled:=true;
   edtPassword.Enabled:=true;
  end
  else
  begin
   EdUserAutenticacao.Enabled:=false;
   edtPassword.Enabled:=false;

  end;

end;

procedure TFrmERP_ContaMail.btverpassClick(Sender: TObject);
begin
  if UpperCase(sb.UtilizadorActual.Login) = 'MICRONET' then
  begin
    if btverpass.Tag = 1 then
    begin
      edtPassword.passwordchar := '*';
      btverpass.Tag := 0;
          btverpass.caption:='mostrar';
    end
    else
    begin
      edtPassword.passwordchar := #0;
      btverpass.Tag := 1;
      btverpass.caption:='Esconder';
    end;

  end
  else
  sb.Dialogos.SBMessage(0,'Utilizador sem acesso para esta operação');
end;

end.
