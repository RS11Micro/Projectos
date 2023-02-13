unit APITocOnline;

interface

Uses Data.Win.ADODB, REST.Client, REST.Authenticator.OAuth,SBBETabelaDados,IERPOGLOBAIS,
  System.JSON, REST.Types, System.SysUtils, System.Classes, REST.JSON,vcl.Dialogs;

  type
//Para insercao de produtos
  TAtributosProdutoTO = class
  private
    Ftype: string;
    Fitem_code: string;
    Fitem_description:string;
    Fsales_price:extended;
    Fsales_price_includes_vat:Boolean;
    Ftax_code:string;
  published
     property &type: string read Ftype write Ftype;
     property item_code: string  read Fitem_code write Fitem_code;
     property item_description: string read Fitem_description   write Fitem_description;
     property sales_price: extended read Fsales_price write Fsales_price;
     property sales_price_includes_vat: Boolean read  Fsales_price_includes_vat write Fsales_price_includes_vat;
     property tax_code : string read Ftax_code write Ftax_code;
  end;

   Titem_familie = Class
   private
     Ftype:string;
     Fid:string;
   published
     property &type: string read Ftype write Ftype;
     property id: string  read Fid write Fid;

   end;


   Titem_families = Class
   private
     FData:Titem_familie;
   published
     property Data:Titem_familie read FData write FData;
   end;


   TrelationshipsTO = Class
   private
    Fitem_families:Titem_families;
   published
     property item_families:Titem_families read Fitem_families write Fitem_families;
   end;

  Tattributes = class
  private
    Fcode: string;
    Fdocument_text: string;
    Fapplicable_legislation:string;
    Ftax_country_region: string;
    Ftax_code: string;
    Fdescription: string;
    Ftax_percentage: string;
    Ftax_expiration_date: string;
    Fvat_tax_id: string;

  published
     property code: string read Fcode write Fcode;
     property document_text: string  read Fdocument_text write Fdocument_text;
     property applicable_legislation: string read Fapplicable_legislation   write Fapplicable_legislation;
     property tax_country_region: string read Ftax_country_region write Ftax_country_region;
     property tax_code: string read Ftax_code write Ftax_code;
     property description: string read Fdescription write Fdescription;
     property tax_percentage: string read Ftax_percentage write Ftax_percentage;
     property tax_expiration_date: string read Ftax_expiration_date write Ftax_expiration_date;
     property vat_tax_id: string read Fvat_tax_id write Fvat_tax_id;

  end;

  TRespostaInsencao = Class
  private
    Ftype:string;
    Fid:integer;
    Fattributes: Tattributes;
  published
     property &type: string read Ftype write Ftype;
     property id: integer  read Fid write Fid;
     property attributes: Tattributes read Fattributes   write Fattributes;


  end;
  TArrayRespostaInsencao  =array of  TRespostaInsencao;

  TDataMinsencaoToc = class
  private
    Fdata:TArrayRespostaInsencao;
  published
    property data:TArrayRespostaInsencao read Fdata write Fdata;
  End;


  TRespostaTaxes = Class
  private
    Ftype:string;
    Fid:string;
    Fattributes: Tattributes;
  published
     property &type: string read Ftype write Ftype;
     property id: string  read Fid write Fid;
     property attributes: Tattributes read Fattributes   write Fattributes;


  end;
  TArrayRespostaTaxes  =array of  TRespostaTaxes;


  TDataTaxesToc = class
  private
    Fdata:TArrayRespostaTaxes;
  published
    property data:TArrayRespostaTaxes read Fdata write Fdata;
  End;


  TProdutoTO = Class
  private
    Ftype:string;
    Fattributes: TAtributosProdutoTO;
    Frelationships:TrelationshipsTO;
  published
    property &type: string read Ftype write Ftype;
    property attributes: TAtributosProdutoTO read Fattributes write Fattributes;
    property relationships: TrelationshipsTO read Frelationships write Frelationships;

  End;
  TInsereProdutoTO = Class
  private
    Fdata:TProdutoTO;
  published
    property data: TProdutoTO read Fdata write Fdata;
  End;

//fim de inserção de produtos
//inserir sub_familias

  TAtributosfamiliaTO = class
  private
    Fname: string;
  published
    property name: String read Fname write Fname;
  End;

  TFamiliaTO = Class
  private
    Ftype:string;
    Fattributes: TAtributosfamiliaTO;
  published
    property &type: string read Ftype write Ftype;
    property attributes: TAtributosfamiliaTO read Fattributes write Fattributes;

  End;

  TInsereFamiliaTO = Class
  private
    Fdata:TFamiliaTO;
  published
    property data: TFamiliaTO read Fdata write Fdata;
  End;


// Fim inserir sub_familias



//para inserção de serviços

  TAtributosServicoTO = class
  private
    Ftype: string;
    Fservice_group:string;
    Fitem_code: string;
    Fitem_description:string;
    Fsales_price:extended;
    Fsales_price_includes_vat:Boolean;
    Ftax_code:string;

  published
     property &type: string read Ftype write Ftype;
     property service_group: string  read Fservice_group write Fservice_group;
     property item_code: string  read Fitem_code write Fitem_code;
     property item_description: string read Fitem_description   write Fitem_description;
     property sales_price: extended read Fsales_price write Fsales_price;
     property sales_price_includes_vat: Boolean read  Fsales_price_includes_vat write Fsales_price_includes_vat;
     property tax_code : string read Ftax_code write Ftax_code;

  end;
  TServicoTO = Class
  private
    Ftype:string;
    Fattributes: TAtributosServicoTO;
  published
    property &type: string read Ftype write Ftype;
    property attributes: TAtributosServicoTO read Fattributes write Fattributes;

  End;

    TInsereServicoTO = Class
  private
    Fdata:TServicoTO;
  published
    property data: TServicoTO read Fdata write Fdata;
  End;

//fim de servico

// inicio vendas

  TLinhaVendaTO = Class
  private
   Fitem_type :string;
   Fitem_code :string;
   Fdescription :string;
   Fquantity :extended;
   Funit_price :extended;
   Fsettlement_expression :string;
   Funit_of_measure_id:String;
   Ftax_id:Integer;
   Ftax_code: string;
   Ftax_percentage:integer;
   Ftax_country_region:string;

  public
  published
    property item_type : string read Fitem_type write Fitem_type;
    property item_code : string read Fitem_code write Fitem_code;
    property description : string read Fdescription write Fdescription;
    property quantity : extended read Fquantity write Fquantity;
    property unit_price : extended read Funit_price write Funit_price;

    property settlement_expression : string read Fsettlement_expression write Fsettlement_expression;
    property unit_of_measure_id : String read Funit_of_measure_id write Funit_of_measure_id;

    property tax_id:Integer read Ftax_id write Ftax_id;
    property tax_code : string read Ftax_code write Ftax_code;
    property tax_percentage:integer read Ftax_percentage write Ftax_percentage;
    property tax_country_region:string read Ftax_country_region write Ftax_country_region;


    end;

  TArrayLinhasVendaTO = array of   TLinhaVendaTO;
  TCabecalhoVendaTO = Class
  private
   Fdocument_type : string;
   Fdate : string;
   Fdue_date : string;
   Fcustomer_tax_registration_number : string;
   Fcustomer_business_name : string;
   Fcustomer_address_detail : string;
   Fcustomer_postcode : string;
   Fcustomer_city : string;
   Fcustomer_country : string;
   Fsettlement_expression : string;
   Fvat_included_prices:boolean;
   Fcurrency_iso_code : string;
   Fcustomer_tax_country_region:string;
   Fcurrency_conversion_rate : extended;
   Fnotes : string;
   Fexternal_reference : string;
   Fpayment_mechanism : string;
   Fdocument_series_id :integer;
//   Fbank_account_id: integer;
   Ftax_exemption_reason_id : String;
   Ffinalize: boolean;
   Freturn_pdf:boolean;
   Fmanual_registration_number:String;
   Fmanual_registration_series:String;
   Flines:TArrayLinhasVendaTO;

  public
  published
    property    document_type : string read Fdocument_type write Fdocument_type;
    property    date : string read Fdate write Fdate;
    property    due_date : string read Fdue_date write Fdue_date;
    property    customer_tax_registration_number : string read Fcustomer_tax_registration_number write Fcustomer_tax_registration_number;
    property    customer_business_name : string read Fcustomer_business_name write Fcustomer_business_name;
    property    customer_address_detail : string read Fcustomer_address_detail write Fcustomer_address_detail;
    property    customer_postcode : string read Fcustomer_postcode write Fcustomer_postcode;
    property    customer_city : string read Fcustomer_city write Fcustomer_city;
    property    customer_country : string read Fcustomer_country write Fcustomer_country;
    property    settlement_expression : string read Fsettlement_expression write Fsettlement_expression;
    property    vat_included_prices:boolean read Fvat_included_prices write Fvat_included_prices;
    property    currency_iso_code : string read Fcurrency_iso_code write Fcurrency_iso_code;
    property    currency_conversion_rate : extended read Fcurrency_conversion_rate write Fcurrency_conversion_rate;
    property    notes : string read Fnotes write Fnotes;
    property    external_reference : string read Fexternal_reference write Fexternal_reference;
    property    payment_mechanism : string read Fpayment_mechanism write Fpayment_mechanism;
    property    document_series_id :integer read Fdocument_series_id write Fdocument_series_id;
//    property    bank_account_id: integer read Fbank_account_id write Fbank_account_id;
    property    tax_exemption_reason_id : String read Ftax_exemption_reason_id write Ftax_exemption_reason_id;

    property    manual_registration_number : string read Fmanual_registration_number write Fmanual_registration_number;
    property    manual_registration_series : string read Fmanual_registration_series write Fmanual_registration_series;
    property    finalize: boolean read Ffinalize write Ffinalize;
    property    return_pdf:boolean read Freturn_pdf write Freturn_pdf;

    property    customer_tax_country_region : string read Fcustomer_tax_country_region write Fcustomer_tax_country_region;
    property    lines:TArrayLinhasVendaTO read Flines write Flines;

  End;


 var
  FBaseURL, FDadosComunicacao: string;

  FRESTClient1: TRESTClient;
  FRESTRequest1: TRESTRequest;
  FRESTResponse1: TRESTResponse;
  FOAuth2PDF1: TOAuth2Authenticator;
  FstrToken, FstrRespostaPDF1, Frequestid: string;
  FBodyGeraToken: string;

  function GETCamposJsonString(JSON, value: String): String;
  function GETCamposJsonArrayString(JSON, value: String): String;
  function getData2(JsonString: String; User: String; Field: String): String;
  Function DaJsonProduto(pProdutos: TsbbeTabeladados): ansiString;
  Function DaJsonServico(pservicos: TsbbeTabeladados): ansiString;
  Function DaJsonFamilia(pFamilias: TsbbeTabeladados): ansiString;
  Function DaJsonVenda(pCabDoc,pLinhasDoc,pPagamentoDoc: TsbbeTabeladados;pID_SerieIntegrador,ptax_exemption_reason_id:string): ansiString;
  function DevolveIDMotivoTO(pcode:string):string;


// preenche tabelas de mapeamentos
  //servicos
  Procedure InsereServicoIntegrado(pID_Interno:string;pservicos: TsbbeTabeladados);
  //produtos
  Procedure InsereProdutoIntegrado(pID_Interno:string;pProdutos: TsbbeTabeladados);
  // familias
  Procedure InserefamiliaIntegrada(pID_Interno:string;pfamilias: TsbbeTabeladados);
// fim depreenche tabelas de mapeamentos
// validação de NIFS PT
Function ValidaNIF(pNIF:String):Boolean;

implementation


function getData2(JsonString: String; User: String; Field: String): String;
var
  JSonValue: TJSonValue;
  JsonArray: TJSONArray;
  ArrayElement: TJSonValue;
  FoundValue: TJSonValue;
begin
  Result :='';

  // create TJSonObject from string
  JsonValue := TJSonObject.ParseJSONValue(JsonString);

  // get the array
  JsonArray := JsonValue.GetValue<TJSONArray>('data');

  // iterate the array
  for ArrayElement in JsonArray do begin
      if ArrayElement.GetValue<String>('type') = User then begin
        Result := ArrayElement.GetValue<String>(Field);
        break;
      end;
  end;
end;
function GETCamposJsonArrayString(JSON, value: String): String;
var
  LJSONObject: TJSONObject;

  function TrataObjeto(jObj: TJSONObject): string;
  var
    i,j: integer;
    jPar: TJSONPair;
     vJsonValue:TJSONArray;
  begin
    result := '';
    for i := 0 to jObj.Size - 1 do
    begin
      jPar := jObj.Get(i);
      if jPar.JsonValue Is TJSONObject then
        result := TrataObjeto((jPar.JsonValue As TJSONObject))
      else if sametext(trim(jPar.JsonString.value), value) then
      begin
        result := jPar.JsonValue.value;

        vJsonValue := TJSONObject.ParseJSONValue('[data]') as TJSONArray;
      end;
      if result <> '' then
        break;
    end;
  end;

begin
  try
    LJSONObject := nil;
    LJSONObject := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(JSON), 0)
      as TJSONObject;
    result := TrataObjeto(LJSONObject);
  finally
    LJSONObject.Free;
  end;
end;
function GETCamposJsonString(JSON, value: String): String;
var
  LJSONObject: TJSONObject;
  function TrataObjeto(jObj: TJSONObject): string;
  var
    i: integer;
    jPar: TJSONPair;
  begin
    result := '';
    for i := 0 to jObj.Size - 1 do
    begin
      jPar := jObj.Get(i);
      if jPar.JsonValue Is TJSONObject then
        result := TrataObjeto((jPar.JsonValue As TJSONObject))
      else if sametext(trim(jPar.JsonString.value), value) then
      begin
        result := jPar.JsonValue.value;
        break;
      end;
      if result <> '' then
        break;
    end;
  end;

begin
  try
    LJSONObject := nil;
    LJSONObject := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(JSON), 0)
      as TJSONObject;
    result := TrataObjeto(LJSONObject);
  finally
    LJSONObject.Free;
  end;
end;

Function DaJsonProduto(pProdutos: TsbbeTabeladados): ansiString;
var
  JsonInsereProdutoTO:TInsereProdutoTO;
  JsonProdutoTO: TProdutoTO;
  mAtributosProdutoTO:TAtributosProdutoTO;

  mrelationships:TrelationshipsTO;
  mitem_familie:Titem_familie;
  mitem_families:Titem_families;

  JSON: TStringList;
  ljson: string;
  i: integer;
  objjson: TJSONObject;

  st,Body_Mail,FromMail,Subject,FromDisplayName,LanguageCode: string;
  Branch: string;
  ltxtFileR: textfile;
begin
  JSON := TStringList.Create;
  JsonInsereProdutoTO:=TInsereProdutoTO.Create;
  JsonProdutoTO := TProdutoTO.Create;
  try
    with JsonProdutoTO do
    begin
      &Type := 'products';

    end;


    mAtributosProdutoTO := TAtributosProdutoTO.Create;
    mitem_familie:=Titem_familie.create;
    mitem_families:=Titem_families.create;
    mrelationships := TrelationshipsTO.Create;

    mitem_familie.&type:='item_families';
    mitem_familie.id:=pProdutos.davalor('Id_Integrador').asstring;
    mitem_families.Data:=mitem_familie;
    mrelationships.item_families :=mitem_families;


    mAtributosProdutoTO.&type:= 'Product';
    mAtributosProdutoTO.item_code:=pProdutos.davalor('servico').asstring;
    mAtributosProdutoTO.item_description:=pProdutos.davalor('descritivo').asstring;
    mAtributosProdutoTO.sales_price:=0;
    mAtributosProdutoTO.sales_price_includes_vat:=False;
    mAtributosProdutoTO.tax_code:='NOR';


    JsonProdutoTO.attributes:=mAtributosProdutoTO;
    JsonProdutoTO.relationships:=mrelationships;

    JsonInsereProdutoTO.data:=JsonProdutoTO;

    JSON.text := tJson.ObjectToJsonString(JsonInsereProdutoTO);

    result := JSON.text;
  finally
    Freeandnil(JsonInsereProdutoTO);
    Freeandnil(JSON);
  end;
end;

Function DaJsonServico(pservicos: TsbbeTabeladados): ansiString;
var
  JsonInsereServicoTO:TInsereServicoTO;
  JsonServicoTO: TServicoTO;
  mAtributosServicoTO:TAtributosServicoTO;

  JSON: TStringList;
  ljson: string;
  i: integer;
  objjson: TJSONObject;

  st,Body_Mail,FromMail,Subject,FromDisplayName,LanguageCode: string;
  Branch: string;
  ltxtFileR: textfile;
begin
  JSON := TStringList.Create;
  JsonInsereServicoTO:=TInsereServicoTO.Create;
  JsonServicoTO := TServicoTO.Create;
  try
    with JsonServicoTO do
    begin
      &Type := 'services';
    end;
    mAtributosServicoTO := TAtributosServicoTO.Create;
    mAtributosServicoTO.&type:= 'Service';
    mAtributosServicoTO.service_group:=pservicos.davalor('ID_GrupoServico').asstring;
    mAtributosServicoTO.item_code:=pservicos.davalor('servico').asstring;
    mAtributosServicoTO.item_description:=pservicos.davalor('descritivo').asstring;
    mAtributosServicoTO.sales_price:=0;
    mAtributosServicoTO.sales_price_includes_vat:=False;
    mAtributosServicoTO.tax_code:='NOR';


    JsonServicoTO.attributes:=mAtributosServicoTO;

    JsonInsereServicoTO.data:=JsonServicoTO;
    JSON.text := tJson.ObjectToJsonString(JsonInsereServicoTO);

    result := JSON.text;
  finally
    Freeandnil(JsonInsereServicoTO);
    Freeandnil(JSON);
  end;
end;



Procedure InsereServicoIntegrado(pID_Interno:string;pservicos: TsbbeTabeladados);
Var strsql:string;
begin
  strsql:='INSERT INTO Erp_ServicosIntegrados(Id_Integrador,CodeIntegrador,GrupoCodeIntegrador)'
  +' values('+sb.UtilSQL.StrToSQLStr(pID_Interno)
  +','+sb.UtilSQL.StrToSQLStr(pservicos.davalor('servico').asstring)
  +','+sb.UtilSQL.StrToSQLStr(pservicos.davalor('ID_GrupoServico').asstring)
  +')';
 sb.sbbd.executa(strsql);
end;

Procedure InsereProdutoIntegrado(pID_Interno:string;pProdutos: TsbbeTabeladados);
Var strsql:string;
begin
  strsql:='INSERT INTO Erp_ProdutosIntegrados(Id_Integrador,CodeIntegrador)'
  +' values('+sb.UtilSQL.StrToSQLStr(pID_Interno)
  +','+sb.UtilSQL.StrToSQLStr(pProdutos.davalor('servico').asstring)
  +')';
 sb.sbbd.executa(strsql);
end;


Procedure InserefamiliaIntegrada(pID_Interno:string;pfamilias: TsbbeTabeladados);
Var strsql:string;
begin
  strsql:='INSERT INTO Erp_FamiliasIntegradas(Id_Integrador,CodeIntegrador)'
  +' values('+sb.UtilSQL.StrToSQLStr(pID_Interno)
  +','+sb.UtilSQL.StrToSQLStr(pfamilias.davalor('ID_FamiliaProduto').asstring)
  +')';
 sb.sbbd.executa(strsql);
end;



Function DaJsonFamilia(pFamilias: TsbbeTabeladados): ansiString;
var
  JsonInsereFamiliaTO:TInserefamiliaTO;
  JsonFamiliaTO: TFamiliaTO;
  mAtributosFamiliaTO:TAtributosFamiliaTO;

  JSON: TStringList;
  ljson: string;
  i: integer;
  objjson: TJSONObject;

  st,Body_Mail,FromMail,Subject,FromDisplayName,LanguageCode: string;
  Branch: string;
  ltxtFileR: textfile;
begin
  JSON := TStringList.Create;
  JsonInsereFamiliaTO:=TInserefamiliaTO.Create;
  JsonFamiliaTO := TFamiliaTO.Create;
  try
    with JsonFamiliaTO do
    begin
      &Type := 'item_families';

    end;


    mAtributosFamiliaTO := TAtributosFamiliaTO.Create;

    mAtributosFamiliaTO.name:=pFamilias.daValor('FamiliaProduto').AsString;

    JsonFamiliaTO.attributes:=mAtributosFamiliaTO;

    JsonInsereFamiliaTO.data:=JsonFamiliaTO;
    JSON.text := tJson.ObjectToJsonString(JsonInsereFamiliaTO);

    result := JSON.text;
  finally
    Freeandnil(JsonInsereFamiliaTO);
    Freeandnil(JSON);
  end;
end;

function DevolveIDMotivoTO(pcode:string):string;
var
strsql:string;
lst:tsbbeTabelaDados;
begin
   strsql:='select id from Erp_MotIsencaoToc where code='+sb.UtilSQL.StrToSQLStr(pcode);
   lst:=sb.SBBD.AbrirLV(strsql);
   result:='';
   if not lst.Vazia then
     Result:=lst.daValor('id').AsString;
   if assigned(lst) then
     freeandnil(lst);
end;
Function DaJsonVenda(pCabDoc,pLinhasDoc,pPagamentoDoc: TsbbeTabeladados;pID_SerieIntegrador,ptax_exemption_reason_id:string): ansiString;
var
  mLinhaVendaTO:TLinhaVendaTO;
  mCabecalhoVendaTO:TCabecalhoVendaTO;
  mArrayLinhasVendaTO:TArrayLinhasVendaTO;
  JSON: TStringList;
  ljson,strsql: string;
  i,NumLinhas: integer;
  objjson: TJSONObject;
  st,Body_Mail,FromMail,Subject,FromDisplayName,LanguageCode: string;
  Branch,mcpostal,mCodIsencao: string;
  ltxtFileR: textfile;
  mLstInfoTaxes:TsbbeTabeladados;
begin
  JSON := TStringList.Create;
  mCabecalhoVendaTO:=TCabecalhoVendaTO.Create;
  NumLinhas:=pLinhasDoc.NumLinhas;
  setlength(mArrayLinhasVendaTO,NumLinhas);


   mCabecalhoVendaTO.document_type :=pCabDoc.daValor('Invoicetype').AsString; //string
   mCabecalhoVendaTO.date :=formatdatetime('yyyy-mm-dd', pCabDoc.daValor('Data').asdatetime); // string;
   mCabecalhoVendaTO.due_date:=FormatDateTime('yyyy-mm-dd', pCabDoc.daValor('DataVenc').asdatetime); // string;

   mCabecalhoVendaTO.customer_business_name :=pCabDoc.daValor('Nome').AsString; // string;
   mCabecalhoVendaTO.customer_address_detail :=pCabDoc.daValor('Morada').AsString; // string;

   //toc online nao aceita para Pais PT codigo postal   Invalidos
   mCabecalhoVendaTO.customer_postcode :=''; // string;
//   mCabecalhoVendaTO.customer_postcode :=pCabDoc.daValor('codpostal').AsString; // string;
//   mCabecalhoVendaTO.customer_city :=pCabDoc.daValor('').AsString; // string;

   //está a dar erros de taxas de IVA para customers de italia
   if pCabDoc.daValor('CODPais').AsString='PT' then
   begin
      mCabecalhoVendaTO.customer_country :=pCabDoc.daValor('CODPais').AsString; // string;
      if pCabDoc.daValor('NIF').AsString<>'' then
      begin
        if  MotorFnt.Cliente.ValidaNIF(pCabDoc.daValor('NIF').AsString) then
           mCabecalhoVendaTO.customer_tax_registration_number :=pCabDoc.daValor('NIF').AsString
        else
           mCabecalhoVendaTO.customer_tax_registration_number :='';
      end
      else
        mCabecalhoVendaTO.customer_tax_registration_number :=pCabDoc.daValor('NIF').AsString;

   end
   else
   begin
      mCabecalhoVendaTO.customer_country :=pCabDoc.daValor('CODPais').AsString;// string;
      mCabecalhoVendaTO.customer_tax_registration_number :=pCabDoc.daValor('NIF').AsString; // string;
   end;
//   mCabecalhoVendaTO.settlement_expression : =pCabDoc.daValor('PT').AsString; //string;

   mCabecalhoVendaTO.customer_tax_country_region:=pCabDoc.daValor('CODPais').AsString; // string;
   mCabecalhoVendaTO.vat_included_prices:=true; //boolean;
   mCabecalhoVendaTO.currency_iso_code :='EUR'; // string;
   mCabecalhoVendaTO.currency_conversion_rate :=1; // extended;
   mCabecalhoVendaTO.notes :=''; // string;
   mCabecalhoVendaTO.external_reference :=pCabDoc.daValor('Serie').AsString; // string;
   mCabecalhoVendaTO.payment_mechanism :=pPagamentoDoc.davalor('ContaERP').asstring;// string;
   mCabecalhoVendaTO.document_series_id :=strtoint(pID_SerieIntegrador); //integer;

   mCabecalhoVendaTO.manual_registration_number:=pCabDoc.daValor('Numero').AsString; // string;
   mCabecalhoVendaTO.manual_registration_series:=pCabDoc.daValor('Serie').AsString; // string;


//   bank_account_id: integer;

   if ptax_exemption_reason_id<>'' then
     mCabecalhoVendaTO.Tax_exemption_reason_id :=ptax_exemption_reason_id
   ELSE
   mCabecalhoVendaTO.Tax_exemption_reason_id :='';
   mCabecalhoVendaTO.finalize:=true;
   mCabecalhoVendaTO.return_pdf:=false;

   pLinhasDoc.Inicio;
  i:=0;
  while not pLinhasDoc.NoFim do
  begin
     mLinhaVendaTO :=TLinhaVendaTO.Create;

     if pLinhasDoc.daValor('TipoArtigo').AsString='S' then
      mLinhaVendaTO.item_type :='Service';//string;
     if pLinhasDoc.daValor('TipoArtigo').AsString='P' then
      mLinhaVendaTO.item_type :='Product';//string;

     mLinhaVendaTO.item_code :=pLinhasDoc.daValor('servico').AsString;//string;
     mLinhaVendaTO.description :=pLinhasDoc.daValor('Descritivo').AsString;//string;
     mLinhaVendaTO.quantity :=pLinhasDoc.daValor('qnt').AsFloat;//extended;
     mLinhaVendaTO.unit_price :=pLinhasDoc.daValor('precounit').Asfloat;//extended;

     strsql :=' select * from Erp_TaxesTO where   '
     +' tax_country_region='+sb.UtilSQL.StrToSQLStr(pLinhasDoc.daValor('TaxCountryRegion').AsString)
     +' and tax_code='+sb.UtilSQL.StrToSQLStr(pLinhasDoc.daValor('taxcode').AsString);
     mLstInfoTaxes:=sb.SBBD.AbrirLV(strsql);

     mLinhaVendaTO.tax_id :=mLstInfoTaxes.daValor('id').asinteger;//extended;
     mLinhaVendaTO.tax_code :=mLstInfoTaxes.daValor('tax_code').AsString;//extended;
     mLinhaVendaTO.tax_percentage :=mLstInfoTaxes.daValor('tax_percentage').asinteger;//extended;
     mLinhaVendaTO.tax_country_region :=mLstInfoTaxes.daValor('tax_country_region').AsString;//extended;
     if assigned(mLstInfoTaxes) then
       freeandnil(mLstInfoTaxes);

     if uppercase(mLinhaVendaTO.tax_code)='ISE' then
     begin
       //toconline so aceita motivos de isenção no cabeçalho de venda
       //logo se tem leva com o ultimo percorridas as linhas
       mCodIsencao:=pLinhasDoc.daValor('CodIsencao').AsString;
       mCabecalhoVendaTO.Tax_exemption_reason_id:= DevolveIDMotivoTO(mCodIsencao);
     end;
     mLinhaVendaTO.settlement_expression :=pLinhasDoc.daValor('Descontoperc').AsString;//string;
     mLinhaVendaTO.unit_of_measure_id:='';
     mArrayLinhasVendaTO[i]:=mLinhaVendaTO;
     inc(i);
     pLinhasDoc.Seguinte;
  end;
    mCabecalhoVendaTO.lines:=mArrayLinhasVendaTO;
    JSON.text := tJson.ObjectToJsonString(mCabecalhoVendaTO,[joIgnoreEmptyStrings]);
    result := JSON.text;



  {try
    with JsonFamiliaTO do
    begin
      &Type := 'item_families';

    end;


    mAtributosFamiliaTO := TAtributosFamiliaTO.Create;

    mAtributosFamiliaTO.name:=pFamilias.daValor('FamiliaProduto').AsString;

    JsonFamiliaTO.attributes:=mAtributosFamiliaTO;

    JsonInsereFamiliaTO.data:=JsonFamiliaTO;
    JSON.text := tJson.ObjectToJsonString(JsonInsereFamiliaTO);

    result := JSON.text;
  finally
    Freeandnil(JsonInsereFamiliaTO);
    Freeandnil(JSON);
  end;}
end;


Function ValidaNIF(pNIF:String):Boolean;
var
    ClientNIFPT: TRESTClient;
    ReqNIFPT: TRESTRequest;
    RespNIFPT: TRESTResponse;
  param,  param1,  param2: TrestRequestParameter;
begin
    ClientNIFPT:= TRESTClient.Create(nil);
    ReqNIFPT:=TRESTRequest.Create(nil);
    RespNIFPT:= TRESTResponse.Create(nil);

  ReqNIFPT.Client := ClientNIFPT;
  ReqNIFPT.Method := rmGET;
  ReqNIFPT.Response := RespNIFPT;

   ClientNIFPT.BaseURL:='http://www.nif.pt/?';
 { param := ReqNIFPT.Params.AddItem;
  param.name := 'json';
  param.Kind := pkREQUESTBODY;
  param.ContentType := ctAPPLICATION_JSON;
  param.Value:='1';

  param := ReqNIFPT.Params.AddItem;
  param.name := 'q';
  param.Kind := pkREQUESTBODY;
  param.Value:=pNIF;
  param.ContentType := ctAPPLICATION_JSON;

  param := ReqNIFPT.Params.AddItem;
  param.name := 'key';
  param.Value:='key';
  param.Kind := pkREQUESTBODY;
  param.ContentType := ctAPPLICATION_JSON;
  }

     ClientNIFPT.BaseURL:='http://www.nif.pt/?json=1&q=509442013&key=key';
  ReqNIFPT.Execute;
  showmessage(ReqNIFPT.Response.Content);

  if assigned(ClientNIFPT) then
   freeandnil(ClientNIFPT);
  if assigned(ReqNIFPT) then
   freeandnil(ReqNIFPT);

  if assigned(RespNIFPT) then
   freeandnil(RespNIFPT);


  result:=true;
end;

end.
