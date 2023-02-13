unit CHILKATCERTIFICATELib_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// $Rev: 98336 $
// File generated on 17/01/2023 12:30:03 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Projectos\chilkat_ativex\ChilkatCert.dll (1)
// LIBID: {2138BF27-7383-435B-A6F5-89B1DEAB2130}
// LCID: 0
// Helpfile: 
// HelpString: Chilkat Certificate
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// SYS_KIND: SYS_WIN32
// Errors:
//   Hint: Parameter 'array' of ICkStringArray.Union changed to 'array_'
//   Hint: Parameter 'array' of ICkStringArray.Intersect changed to 'array_'
//   Hint: Parameter 'array' of ICkStringArray.Subtract changed to 'array_'
//   Error creating palette bitmap of (TChilkatCSP) : Error reading control bitmap
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Winapi.Windows, System.Classes, System.Variants, System.Win.StdVCL, Vcl.Graphics, Vcl.OleCtrls, Vcl.OleServer, Winapi.ActiveX;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  CHILKATCERTIFICATELibMajorVersion = 1;
  CHILKATCERTIFICATELibMinorVersion = 0;

  LIBID_CHILKATCERTIFICATELib: TGUID = '{2138BF27-7383-435B-A6F5-89B1DEAB2130}';

  IID_IChilkatCert: TGUID = '{D56C1AF1-3FDE-471C-9BC2-C52515F260C1}';
  CLASS_ChilkatCert: TGUID = '{E2A74106-0416-43D8-8FE8-833E9AD098EA}';
  IID_IPublicKey: TGUID = '{06544919-F559-4AE5-9001-F903BD8A84E6}';
  IID_IPrivateKey: TGUID = '{C4C23B78-DB98-444C-B601-DCAC6EBBEC54}';
  IID_IChilkatCertStore: TGUID = '{5CE8D2B6-FDE7-41D1-B563-B8E03EE008B9}';
  CLASS_ChilkatCertStore: TGUID = '{83C7431A-035A-4D1E-8BD8-7FD2F78EE762}';
  IID_IChilkatCreateCS: TGUID = '{AC4A4CB2-140B-402B-822B-455EEA0A9976}';
  CLASS_ChilkatCreateCS: TGUID = '{7455CC38-FC70-4785-9551-15FA0F5DBC98}';
  IID_IChilkatCertChain: TGUID = '{811AA1E0-4C88-4274-AABB-F8D171444D52}';
  CLASS_ChilkatCertChain: TGUID = '{2A9A3D40-2F32-45BF-9A89-AC9ED6C2FEDF}';
  IID_IChilkatCertColl: TGUID = '{3296199A-B3A0-4AF1-8673-3F76C5FD6FD5}';
  CLASS_ChilkatCertColl: TGUID = '{53A95719-7741-457D-8811-519C106E7B92}';
  CLASS_privateKey: TGUID = '{A934AEE3-8896-485F-8A55-ACF2A87BD010}';
  IID_IKeyContainer: TGUID = '{D338B7B4-0478-448E-AFC3-D005E6DFE790}';
  CLASS_KeyContainer: TGUID = '{695FB128-85C1-4DF3-A2BE-3123D13E2564}';
  CLASS_publicKey: TGUID = '{51435758-75D7-45FC-A91A-C84DF4ECF725}';
  IID_IChilkatCSP: TGUID = '{D12FB216-99DA-4EB3-9CC0-C0F760B174A0}';
  CLASS_ChilkatCSP: TGUID = '{71D98090-5725-48E6-96A3-2A0AFBC3BC54}';
  IID_ICkStringArray: TGUID = '{4340DF8E-D7A3-4675-BE74-80077B2B3E81}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IChilkatCert = interface;
  IChilkatCertDisp = dispinterface;
  IPublicKey = interface;
  IPublicKeyDisp = dispinterface;
  IPrivateKey = interface;
  IPrivateKeyDisp = dispinterface;
  IChilkatCertStore = interface;
  IChilkatCertStoreDisp = dispinterface;
  IChilkatCreateCS = interface;
  IChilkatCreateCSDisp = dispinterface;
  IChilkatCertChain = interface;
  IChilkatCertChainDisp = dispinterface;
  IChilkatCertColl = interface;
  IChilkatCertCollDisp = dispinterface;
  IKeyContainer = interface;
  IKeyContainerDisp = dispinterface;
  IChilkatCSP = interface;
  IChilkatCSPDisp = dispinterface;
  ICkStringArray = interface;
  ICkStringArrayDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  ChilkatCert = IChilkatCert;
  ChilkatCertStore = IChilkatCertStore;
  ChilkatCreateCS = IChilkatCreateCS;
  ChilkatCertChain = IChilkatCertChain;
  ChilkatCertColl = IChilkatCertColl;
  privateKey = IPrivateKey;
  KeyContainer = IKeyContainer;
  publicKey = IPublicKey;
  ChilkatCSP = IChilkatCSP;


// *********************************************************************//
// Interface: IChilkatCert
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D56C1AF1-3FDE-471C-9BC2-C52515F260C1}
// *********************************************************************//
  IChilkatCert = interface(IDispatch)
    ['{D56C1AF1-3FDE-471C-9BC2-C52515F260C1}']
    function Get_Version: WideString; safecall;
    function Get_ForSecureEmail: Integer; safecall;
    function Get_ForServerAuthentication: Integer; safecall;
    function Get_ForClientAuthentication: Integer; safecall;
    function Get_ForCodeSigning: Integer; safecall;
    function Get_ForTimeStamping: Integer; safecall;
    function Get_SerialNumber: WideString; safecall;
    function Get_ValidFrom: TDateTime; safecall;
    function Get_ValidTo: TDateTime; safecall;
    function Get_SubjectCN: WideString; safecall;
    function Get_SubjectOU: WideString; safecall;
    function Get_SubjectO: WideString; safecall;
    function Get_SubjectL: WideString; safecall;
    function Get_SubjectS: WideString; safecall;
    function Get_SubjectC: WideString; safecall;
    function Get_SubjectE: WideString; safecall;
    function Get_IssuerCN: WideString; safecall;
    function Get_IssuerOU: WideString; safecall;
    function Get_IssuerO: WideString; safecall;
    function Get_IssuerL: WideString; safecall;
    function Get_IssuerS: WideString; safecall;
    function Get_IssuerC: WideString; safecall;
    function Get_IssuerE: WideString; safecall;
    function GetEncoded: WideString; safecall;
    function SetFromEncoded(const encodedCert: WideString): Integer; safecall;
    procedure SaveLastError(const filename: WideString); safecall;
    function LoadFromFile(const filename: WideString): Integer; safecall;
    function LoadFromBase64(const encodedCert: WideString): Integer; safecall;
    function LoadFromBinary(binaryBlob: OleVariant): Integer; safecall;
    function Get_SubjectDN: WideString; safecall;
    function Get_IssuerDN: WideString; safecall;
    function Get_LastErrorHtml: WideString; safecall;
    function Get_LastErrorXml: WideString; safecall;
    function Get_LastErrorText: WideString; safecall;
    function IsExpired: Integer; safecall;
    function Get_Rfc822Name: WideString; safecall;
    function Get_Expired: Integer; safecall;
    function Get_SignatureVerified: Integer; safecall;
    function Get_Revoked: Integer; safecall;
    function Get_TrustedRoot: Integer; safecall;
    function HasPrivateKey: Integer; safecall;
    function SaveToFile(const filename: WideString): Integer; safecall;
    function Get_Sha1Thumbprint: WideString; safecall;
    function ExportPublicKey: IPublicKey; safecall;
    function ExportPrivateKey: IPrivateKey; safecall;
    function Get_HasKeyContainer: Integer; safecall;
    function Get_KeyContainerName: WideString; safecall;
    function Get_CspName: WideString; safecall;
    function Get_MachineKeyset: Integer; safecall;
    function Get_Silent: Integer; safecall;
    function LoadByEmailAddress(const emailAddress: WideString): Integer; safecall;
    function LoadByCommonName(const name: WideString): Integer; safecall;
    function PemFileToDerFile(const pemFilename: WideString; const derFilename: WideString): Integer; safecall;
    function LinkPrivateKey(const KeyContainerName: WideString; MachineKeyset: Integer; 
                            forSigning: Integer): Integer; safecall;
    function ExportCertPem: WideString; safecall;
    function ExportCertDer: OleVariant; safecall;
    function ExportCertPemFile(const filename: WideString): Integer; safecall;
    function ExportCertDerFile(const filename: WideString): Integer; safecall;
    function Get_IntendedKeyUsage: Integer; safecall;
    function LoadPfxFile(const pfxFilename: WideString; const password: WideString): Integer; safecall;
    function LoadPfxData(pfxData: OleVariant; const password: WideString): Integer; safecall;
    function ExportToPfxFile(const pfxFilename: WideString; const password: WideString; 
                             includeChain: Integer): Integer; safecall;
    function Get_IsRoot: Integer; safecall;
    function CheckRevoked: Integer; safecall;
    function ExportCertXml: WideString; safecall;
    function Get_VerboseLogging: Integer; safecall;
    procedure Set_VerboseLogging(propVal: Integer); safecall;
    function Get_CertVersion: Integer; safecall;
    function SetPrivateKey(const privKey: IPrivateKey): Integer; safecall;
    function Get_OcspUrl: WideString; safecall;
    function FindIssuer: IChilkatCert; safecall;
    function LoadByIssuerAndSerialNumber(const IssuerCN: WideString; const serialNum: WideString): Integer; safecall;
    function Get_SelfSigned: Integer; safecall;
    function SetPrivateKeyPem(const privKeyPem: WideString): Integer; safecall;
    function GetPrivateKeyPem: WideString; safecall;
    property Version: WideString read Get_Version;
    property ForSecureEmail: Integer read Get_ForSecureEmail;
    property ForServerAuthentication: Integer read Get_ForServerAuthentication;
    property ForClientAuthentication: Integer read Get_ForClientAuthentication;
    property ForCodeSigning: Integer read Get_ForCodeSigning;
    property ForTimeStamping: Integer read Get_ForTimeStamping;
    property SerialNumber: WideString read Get_SerialNumber;
    property ValidFrom: TDateTime read Get_ValidFrom;
    property ValidTo: TDateTime read Get_ValidTo;
    property SubjectCN: WideString read Get_SubjectCN;
    property SubjectOU: WideString read Get_SubjectOU;
    property SubjectO: WideString read Get_SubjectO;
    property SubjectL: WideString read Get_SubjectL;
    property SubjectS: WideString read Get_SubjectS;
    property SubjectC: WideString read Get_SubjectC;
    property SubjectE: WideString read Get_SubjectE;
    property IssuerCN: WideString read Get_IssuerCN;
    property IssuerOU: WideString read Get_IssuerOU;
    property IssuerO: WideString read Get_IssuerO;
    property IssuerL: WideString read Get_IssuerL;
    property IssuerS: WideString read Get_IssuerS;
    property IssuerC: WideString read Get_IssuerC;
    property IssuerE: WideString read Get_IssuerE;
    property SubjectDN: WideString read Get_SubjectDN;
    property IssuerDN: WideString read Get_IssuerDN;
    property LastErrorHtml: WideString read Get_LastErrorHtml;
    property LastErrorXml: WideString read Get_LastErrorXml;
    property LastErrorText: WideString read Get_LastErrorText;
    property Rfc822Name: WideString read Get_Rfc822Name;
    property Expired: Integer read Get_Expired;
    property SignatureVerified: Integer read Get_SignatureVerified;
    property Revoked: Integer read Get_Revoked;
    property TrustedRoot: Integer read Get_TrustedRoot;
    property Sha1Thumbprint: WideString read Get_Sha1Thumbprint;
    property HasKeyContainer: Integer read Get_HasKeyContainer;
    property KeyContainerName: WideString read Get_KeyContainerName;
    property CspName: WideString read Get_CspName;
    property MachineKeyset: Integer read Get_MachineKeyset;
    property Silent: Integer read Get_Silent;
    property IntendedKeyUsage: Integer read Get_IntendedKeyUsage;
    property IsRoot: Integer read Get_IsRoot;
    property VerboseLogging: Integer read Get_VerboseLogging write Set_VerboseLogging;
    property CertVersion: Integer read Get_CertVersion;
    property OcspUrl: WideString read Get_OcspUrl;
    property SelfSigned: Integer read Get_SelfSigned;
  end;

// *********************************************************************//
// DispIntf:  IChilkatCertDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D56C1AF1-3FDE-471C-9BC2-C52515F260C1}
// *********************************************************************//
  IChilkatCertDisp = dispinterface
    ['{D56C1AF1-3FDE-471C-9BC2-C52515F260C1}']
    property Version: WideString readonly dispid 1;
    property ForSecureEmail: Integer readonly dispid 3;
    property ForServerAuthentication: Integer readonly dispid 4;
    property ForClientAuthentication: Integer readonly dispid 5;
    property ForCodeSigning: Integer readonly dispid 6;
    property ForTimeStamping: Integer readonly dispid 7;
    property SerialNumber: WideString readonly dispid 8;
    property ValidFrom: TDateTime readonly dispid 9;
    property ValidTo: TDateTime readonly dispid 10;
    property SubjectCN: WideString readonly dispid 11;
    property SubjectOU: WideString readonly dispid 12;
    property SubjectO: WideString readonly dispid 13;
    property SubjectL: WideString readonly dispid 14;
    property SubjectS: WideString readonly dispid 15;
    property SubjectC: WideString readonly dispid 16;
    property SubjectE: WideString readonly dispid 17;
    property IssuerCN: WideString readonly dispid 18;
    property IssuerOU: WideString readonly dispid 19;
    property IssuerO: WideString readonly dispid 20;
    property IssuerL: WideString readonly dispid 21;
    property IssuerS: WideString readonly dispid 22;
    property IssuerC: WideString readonly dispid 23;
    property IssuerE: WideString readonly dispid 24;
    function GetEncoded: WideString; dispid 26;
    function SetFromEncoded(const encodedCert: WideString): Integer; dispid 27;
    procedure SaveLastError(const filename: WideString); dispid 28;
    function LoadFromFile(const filename: WideString): Integer; dispid 29;
    function LoadFromBase64(const encodedCert: WideString): Integer; dispid 30;
    function LoadFromBinary(binaryBlob: OleVariant): Integer; dispid 31;
    property SubjectDN: WideString readonly dispid 32;
    property IssuerDN: WideString readonly dispid 33;
    property LastErrorHtml: WideString readonly dispid 34;
    property LastErrorXml: WideString readonly dispid 35;
    property LastErrorText: WideString readonly dispid 36;
    function IsExpired: Integer; dispid 38;
    property Rfc822Name: WideString readonly dispid 39;
    property Expired: Integer readonly dispid 40;
    property SignatureVerified: Integer readonly dispid 41;
    property Revoked: Integer readonly dispid 42;
    property TrustedRoot: Integer readonly dispid 43;
    function HasPrivateKey: Integer; dispid 44;
    function SaveToFile(const filename: WideString): Integer; dispid 45;
    property Sha1Thumbprint: WideString readonly dispid 46;
    function ExportPublicKey: IPublicKey; dispid 47;
    function ExportPrivateKey: IPrivateKey; dispid 48;
    property HasKeyContainer: Integer readonly dispid 49;
    property KeyContainerName: WideString readonly dispid 50;
    property CspName: WideString readonly dispid 51;
    property MachineKeyset: Integer readonly dispid 52;
    property Silent: Integer readonly dispid 53;
    function LoadByEmailAddress(const emailAddress: WideString): Integer; dispid 54;
    function LoadByCommonName(const name: WideString): Integer; dispid 55;
    function PemFileToDerFile(const pemFilename: WideString; const derFilename: WideString): Integer; dispid 56;
    function LinkPrivateKey(const KeyContainerName: WideString; MachineKeyset: Integer; 
                            forSigning: Integer): Integer; dispid 57;
    function ExportCertPem: WideString; dispid 58;
    function ExportCertDer: OleVariant; dispid 59;
    function ExportCertPemFile(const filename: WideString): Integer; dispid 60;
    function ExportCertDerFile(const filename: WideString): Integer; dispid 61;
    property IntendedKeyUsage: Integer readonly dispid 62;
    function LoadPfxFile(const pfxFilename: WideString; const password: WideString): Integer; dispid 63;
    function LoadPfxData(pfxData: OleVariant; const password: WideString): Integer; dispid 64;
    function ExportToPfxFile(const pfxFilename: WideString; const password: WideString; 
                             includeChain: Integer): Integer; dispid 65;
    property IsRoot: Integer readonly dispid 66;
    function CheckRevoked: Integer; dispid 67;
    function ExportCertXml: WideString; dispid 68;
    property VerboseLogging: Integer dispid 69;
    property CertVersion: Integer readonly dispid 70;
    function SetPrivateKey(const privKey: IPrivateKey): Integer; dispid 71;
    property OcspUrl: WideString readonly dispid 72;
    function FindIssuer: IChilkatCert; dispid 73;
    function LoadByIssuerAndSerialNumber(const IssuerCN: WideString; const serialNum: WideString): Integer; dispid 74;
    property SelfSigned: Integer readonly dispid 75;
    function SetPrivateKeyPem(const privKeyPem: WideString): Integer; dispid 76;
    function GetPrivateKeyPem: WideString; dispid 77;
  end;

// *********************************************************************//
// Interface: IPublicKey
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {06544919-F559-4AE5-9001-F903BD8A84E6}
// *********************************************************************//
  IPublicKey = interface(IDispatch)
    ['{06544919-F559-4AE5-9001-F903BD8A84E6}']
    function LoadRsaDerFile(const filename: WideString): Integer; safecall;
    function LoadOpenSslDerFile(const filename: WideString): Integer; safecall;
    function LoadOpenSslPemFile(const filename: WideString): Integer; safecall;
    function LoadXmlFile(const filename: WideString): Integer; safecall;
    function SaveRsaDerFile(const filename: WideString): Integer; safecall;
    function SaveOpenSslDerFile(const filename: WideString): Integer; safecall;
    function SaveOpenSslPemFile(const filename: WideString): Integer; safecall;
    function SaveXmlFile(const filename: WideString): Integer; safecall;
    function LoadOpenSslPem(const pemStr: WideString): Integer; safecall;
    function LoadOpenSslDer(derData: OleVariant): Integer; safecall;
    function LoadRsaDer(derData: OleVariant): Integer; safecall;
    function LoadXml(const xml: WideString): Integer; safecall;
    function GetRsaDer: OleVariant; safecall;
    function GetOpenSslDer: OleVariant; safecall;
    function GetOpenSslPem: WideString; safecall;
    function GetXml: WideString; safecall;
    function SaveLastError(const filename: WideString): Integer; safecall;
    function Get_LastErrorText: WideString; safecall;
    function Get_LastErrorHtml: WideString; safecall;
    function Get_LastErrorXml: WideString; safecall;
    function LoadPkcs1Pem(const str: WideString): Integer; safecall;
    property LastErrorText: WideString read Get_LastErrorText;
    property LastErrorHtml: WideString read Get_LastErrorHtml;
    property LastErrorXml: WideString read Get_LastErrorXml;
  end;

// *********************************************************************//
// DispIntf:  IPublicKeyDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {06544919-F559-4AE5-9001-F903BD8A84E6}
// *********************************************************************//
  IPublicKeyDisp = dispinterface
    ['{06544919-F559-4AE5-9001-F903BD8A84E6}']
    function LoadRsaDerFile(const filename: WideString): Integer; dispid 1;
    function LoadOpenSslDerFile(const filename: WideString): Integer; dispid 2;
    function LoadOpenSslPemFile(const filename: WideString): Integer; dispid 3;
    function LoadXmlFile(const filename: WideString): Integer; dispid 4;
    function SaveRsaDerFile(const filename: WideString): Integer; dispid 5;
    function SaveOpenSslDerFile(const filename: WideString): Integer; dispid 6;
    function SaveOpenSslPemFile(const filename: WideString): Integer; dispid 7;
    function SaveXmlFile(const filename: WideString): Integer; dispid 8;
    function LoadOpenSslPem(const pemStr: WideString): Integer; dispid 9;
    function LoadOpenSslDer(derData: OleVariant): Integer; dispid 10;
    function LoadRsaDer(derData: OleVariant): Integer; dispid 11;
    function LoadXml(const xml: WideString): Integer; dispid 12;
    function GetRsaDer: OleVariant; dispid 13;
    function GetOpenSslDer: OleVariant; dispid 14;
    function GetOpenSslPem: WideString; dispid 15;
    function GetXml: WideString; dispid 16;
    function SaveLastError(const filename: WideString): Integer; dispid 17;
    property LastErrorText: WideString readonly dispid 18;
    property LastErrorHtml: WideString readonly dispid 19;
    property LastErrorXml: WideString readonly dispid 20;
    function LoadPkcs1Pem(const str: WideString): Integer; dispid 21;
  end;

// *********************************************************************//
// Interface: IPrivateKey
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C4C23B78-DB98-444C-B601-DCAC6EBBEC54}
// *********************************************************************//
  IPrivateKey = interface(IDispatch)
    ['{C4C23B78-DB98-444C-B601-DCAC6EBBEC54}']
    function LoadRsaDerFile(const filename: WideString): Integer; safecall;
    function LoadPkcs8File(const filename: WideString): Integer; safecall;
    function LoadPemFile(const filename: WideString): Integer; safecall;
    function LoadXmlFile(const filename: WideString): Integer; safecall;
    function LoadPem(const str: WideString): Integer; safecall;
    function LoadRsaDer(derData: OleVariant): Integer; safecall;
    function LoadPkcs8(pkcs8Data: OleVariant): Integer; safecall;
    function LoadXml(const xmlDoc: WideString): Integer; safecall;
    function SaveRsaDerFile(const filename: WideString): Integer; safecall;
    function SavePkcs8File(const filename: WideString): Integer; safecall;
    function SaveRsaPemFile(const filename: WideString): Integer; safecall;
    function SavePkcs8PemFile(const filename: WideString): Integer; safecall;
    function SaveXmlFile(const filename: WideString): Integer; safecall;
    function GetRsaDer: OleVariant; safecall;
    function GetPkcs8: OleVariant; safecall;
    function GetRsaPem: WideString; safecall;
    function GetPkcs8Pem: WideString; safecall;
    function GetXml: WideString; safecall;
    function SaveLastError(const filename: WideString): Integer; safecall;
    function Get_LastErrorXml: WideString; safecall;
    function Get_LastErrorText: WideString; safecall;
    function Get_LastErrorHtml: WideString; safecall;
    function LoadPvkFile(const filename: WideString; const password: WideString): Integer; safecall;
    function LoadPvk(pvkData: OleVariant; const password: WideString): Integer; safecall;
    function LoadEncryptedPem(const pemStr: WideString; const password: WideString): Integer; safecall;
    function LoadEncryptedPemFile(const filename: WideString; const password: WideString): Integer; safecall;
    function LoadPkcs8Encrypted(data: OleVariant; const password: WideString): Integer; safecall;
    function LoadPkcs8EncryptedFile(const filename: WideString; const password: WideString): Integer; safecall;
    function GetPkcs8Encrypted(const password: WideString): OleVariant; safecall;
    function GetPkcs8EncryptedPem(const password: WideString): WideString; safecall;
    function SavePkcs8EncryptedFile(const password: WideString; const filename: WideString): Integer; safecall;
    function SavePkcs8EncryptedPemFile(const password: WideString; const filename: WideString): Integer; safecall;
    property LastErrorXml: WideString read Get_LastErrorXml;
    property LastErrorText: WideString read Get_LastErrorText;
    property LastErrorHtml: WideString read Get_LastErrorHtml;
  end;

// *********************************************************************//
// DispIntf:  IPrivateKeyDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C4C23B78-DB98-444C-B601-DCAC6EBBEC54}
// *********************************************************************//
  IPrivateKeyDisp = dispinterface
    ['{C4C23B78-DB98-444C-B601-DCAC6EBBEC54}']
    function LoadRsaDerFile(const filename: WideString): Integer; dispid 1;
    function LoadPkcs8File(const filename: WideString): Integer; dispid 2;
    function LoadPemFile(const filename: WideString): Integer; dispid 3;
    function LoadXmlFile(const filename: WideString): Integer; dispid 4;
    function LoadPem(const str: WideString): Integer; dispid 5;
    function LoadRsaDer(derData: OleVariant): Integer; dispid 6;
    function LoadPkcs8(pkcs8Data: OleVariant): Integer; dispid 7;
    function LoadXml(const xmlDoc: WideString): Integer; dispid 8;
    function SaveRsaDerFile(const filename: WideString): Integer; dispid 9;
    function SavePkcs8File(const filename: WideString): Integer; dispid 10;
    function SaveRsaPemFile(const filename: WideString): Integer; dispid 11;
    function SavePkcs8PemFile(const filename: WideString): Integer; dispid 12;
    function SaveXmlFile(const filename: WideString): Integer; dispid 13;
    function GetRsaDer: OleVariant; dispid 14;
    function GetPkcs8: OleVariant; dispid 15;
    function GetRsaPem: WideString; dispid 16;
    function GetPkcs8Pem: WideString; dispid 17;
    function GetXml: WideString; dispid 18;
    function SaveLastError(const filename: WideString): Integer; dispid 19;
    property LastErrorXml: WideString readonly dispid 20;
    property LastErrorText: WideString readonly dispid 21;
    property LastErrorHtml: WideString readonly dispid 22;
    function LoadPvkFile(const filename: WideString; const password: WideString): Integer; dispid 23;
    function LoadPvk(pvkData: OleVariant; const password: WideString): Integer; dispid 24;
    function LoadEncryptedPem(const pemStr: WideString; const password: WideString): Integer; dispid 25;
    function LoadEncryptedPemFile(const filename: WideString; const password: WideString): Integer; dispid 26;
    function LoadPkcs8Encrypted(data: OleVariant; const password: WideString): Integer; dispid 27;
    function LoadPkcs8EncryptedFile(const filename: WideString; const password: WideString): Integer; dispid 28;
    function GetPkcs8Encrypted(const password: WideString): OleVariant; dispid 29;
    function GetPkcs8EncryptedPem(const password: WideString): WideString; dispid 30;
    function SavePkcs8EncryptedFile(const password: WideString; const filename: WideString): Integer; dispid 31;
    function SavePkcs8EncryptedPemFile(const password: WideString; const filename: WideString): Integer; dispid 32;
  end;

// *********************************************************************//
// Interface: IChilkatCertStore
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5CE8D2B6-FDE7-41D1-B563-B8E03EE008B9}
// *********************************************************************//
  IChilkatCertStore = interface(IDispatch)
    ['{5CE8D2B6-FDE7-41D1-B563-B8E03EE008B9}']
    function Get_Version: WideString; safecall;
    function Get_NumCertificates: Integer; safecall;
    function GetCertificate(index: Integer): IChilkatCert; safecall;
    function FindCertForEmail(const emailAddress: WideString): IChilkatCert; safecall;
    procedure AddCertificate(const cert: IChilkatCert); safecall;
    procedure RemoveCertificate(const cert: IChilkatCert); safecall;
    function Get_NumEmailCerts: Integer; safecall;
    function GetEmailCert(index: Integer): IChilkatCert; safecall;
    function FindCertBySubject(const str: WideString): IChilkatCert; safecall;
    function FindCertBySubjectCN(const commonName: WideString): IChilkatCert; safecall;
    function FindCertBySubjectO(const organization: WideString): IChilkatCert; safecall;
    function FindCertBySubjectE(const emailAddress: WideString): IChilkatCert; safecall;
    function FindCertBySerial(const SerialNumber: WideString): IChilkatCert; safecall;
    procedure SaveLastError(const filename: WideString); safecall;
    function Get_LastErrorHtml: WideString; safecall;
    function Get_LastErrorXml: WideString; safecall;
    function Get_LastErrorText: WideString; safecall;
    function FindCertByRfc822Name(const name: WideString): IChilkatCert; safecall;
    function OpenCurrentUserStore(readOnly: Integer): Integer; safecall;
    function OpenLocalSystemStore(readOnly: Integer): Integer; safecall;
    function OpenOutlookStore(readOnly: Integer): Integer; safecall;
    function OpenChilkatStore(readOnly: Integer): Integer; safecall;
    function CreateMemoryStore: Integer; safecall;
    function OpenFileStore(const filename: WideString; readOnly: Integer): Integer; safecall;
    function CreateFileStore(const filename: WideString): Integer; safecall;
    function OpenRegistryStore(const regRoot: WideString; const regPath: WideString; 
                               readOnly: Integer): Integer; safecall;
    function CreateRegistryStore(const regRoot: WideString; const regPath: WideString): Integer; safecall;
    function LoadPfxFile(const pfxFilename: WideString; const password: WideString): Integer; safecall;
    function LoadPfxData(pfxData: OleVariant; const password: WideString): Integer; safecall;
    function Get_LinkForSigning: Integer; safecall;
    procedure Set_LinkForSigning(bVal: Integer); safecall;
    function FindCertBySha1Thumbprint(const str: WideString): IChilkatCert; safecall;
    function Get_VerboseLogging: Integer; safecall;
    procedure Set_VerboseLogging(propVal: Integer); safecall;
    function GetCertStoreSpec: WideString; safecall;
    property Version: WideString read Get_Version;
    property NumCertificates: Integer read Get_NumCertificates;
    property NumEmailCerts: Integer read Get_NumEmailCerts;
    property LastErrorHtml: WideString read Get_LastErrorHtml;
    property LastErrorXml: WideString read Get_LastErrorXml;
    property LastErrorText: WideString read Get_LastErrorText;
    property LinkForSigning: Integer read Get_LinkForSigning write Set_LinkForSigning;
    property VerboseLogging: Integer read Get_VerboseLogging write Set_VerboseLogging;
  end;

// *********************************************************************//
// DispIntf:  IChilkatCertStoreDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5CE8D2B6-FDE7-41D1-B563-B8E03EE008B9}
// *********************************************************************//
  IChilkatCertStoreDisp = dispinterface
    ['{5CE8D2B6-FDE7-41D1-B563-B8E03EE008B9}']
    property Version: WideString readonly dispid 1;
    property NumCertificates: Integer readonly dispid 3;
    function GetCertificate(index: Integer): IChilkatCert; dispid 4;
    function FindCertForEmail(const emailAddress: WideString): IChilkatCert; dispid 5;
    procedure AddCertificate(const cert: IChilkatCert); dispid 6;
    procedure RemoveCertificate(const cert: IChilkatCert); dispid 7;
    property NumEmailCerts: Integer readonly dispid 8;
    function GetEmailCert(index: Integer): IChilkatCert; dispid 9;
    function FindCertBySubject(const str: WideString): IChilkatCert; dispid 10;
    function FindCertBySubjectCN(const commonName: WideString): IChilkatCert; dispid 11;
    function FindCertBySubjectO(const organization: WideString): IChilkatCert; dispid 12;
    function FindCertBySubjectE(const emailAddress: WideString): IChilkatCert; dispid 13;
    function FindCertBySerial(const SerialNumber: WideString): IChilkatCert; dispid 14;
    procedure SaveLastError(const filename: WideString); dispid 16;
    property LastErrorHtml: WideString readonly dispid 17;
    property LastErrorXml: WideString readonly dispid 18;
    property LastErrorText: WideString readonly dispid 19;
    function FindCertByRfc822Name(const name: WideString): IChilkatCert; dispid 20;
    function OpenCurrentUserStore(readOnly: Integer): Integer; dispid 21;
    function OpenLocalSystemStore(readOnly: Integer): Integer; dispid 22;
    function OpenOutlookStore(readOnly: Integer): Integer; dispid 23;
    function OpenChilkatStore(readOnly: Integer): Integer; dispid 24;
    function CreateMemoryStore: Integer; dispid 25;
    function OpenFileStore(const filename: WideString; readOnly: Integer): Integer; dispid 26;
    function CreateFileStore(const filename: WideString): Integer; dispid 27;
    function OpenRegistryStore(const regRoot: WideString; const regPath: WideString; 
                               readOnly: Integer): Integer; dispid 28;
    function CreateRegistryStore(const regRoot: WideString; const regPath: WideString): Integer; dispid 29;
    function LoadPfxFile(const pfxFilename: WideString; const password: WideString): Integer; dispid 30;
    function LoadPfxData(pfxData: OleVariant; const password: WideString): Integer; dispid 31;
    property LinkForSigning: Integer dispid 32;
    function FindCertBySha1Thumbprint(const str: WideString): IChilkatCert; dispid 33;
    property VerboseLogging: Integer dispid 34;
    function GetCertStoreSpec: WideString; dispid 15;
  end;

// *********************************************************************//
// Interface: IChilkatCreateCS
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {AC4A4CB2-140B-402B-822B-455EEA0A9976}
// *********************************************************************//
  IChilkatCreateCS = interface(IDispatch)
    ['{AC4A4CB2-140B-402B-822B-455EEA0A9976}']
    function OpenCurrentUserStore: IChilkatCertStore; safecall;
    function OpenLocalSystemStore: IChilkatCertStore; safecall;
    function OpenOutlookStore: IChilkatCertStore; safecall;
    function OpenChilkatStore: IChilkatCertStore; safecall;
    function CreateMemoryStore: IChilkatCertStore; safecall;
    function Get_Version: WideString; safecall;
    function OpenFileStore(const filename: WideString; readOnly: Integer): IChilkatCertStore; safecall;
    function CreateFileStore(const filename: WideString): IChilkatCertStore; safecall;
    function OpenRegistryStore(const regRoot: WideString; const regPath: WideString; 
                               readOnly: Integer): IChilkatCertStore; safecall;
    function CreateRegistryStore(const regRoot: WideString; const regPath: WideString): IChilkatCertStore; safecall;
    procedure SaveLastError(const filename: WideString); safecall;
    function Get_readOnly: Integer; safecall;
    procedure Set_readOnly(bVal: Integer); safecall;
    function Get_LastErrorHtml: WideString; safecall;
    function Get_LastErrorXml: WideString; safecall;
    function Get_LastErrorText: WideString; safecall;
    property Version: WideString read Get_Version;
    property readOnly: Integer read Get_readOnly write Set_readOnly;
    property LastErrorHtml: WideString read Get_LastErrorHtml;
    property LastErrorXml: WideString read Get_LastErrorXml;
    property LastErrorText: WideString read Get_LastErrorText;
  end;

// *********************************************************************//
// DispIntf:  IChilkatCreateCSDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {AC4A4CB2-140B-402B-822B-455EEA0A9976}
// *********************************************************************//
  IChilkatCreateCSDisp = dispinterface
    ['{AC4A4CB2-140B-402B-822B-455EEA0A9976}']
    function OpenCurrentUserStore: IChilkatCertStore; dispid 1;
    function OpenLocalSystemStore: IChilkatCertStore; dispid 2;
    function OpenOutlookStore: IChilkatCertStore; dispid 3;
    function OpenChilkatStore: IChilkatCertStore; dispid 4;
    function CreateMemoryStore: IChilkatCertStore; dispid 5;
    property Version: WideString readonly dispid 7;
    function OpenFileStore(const filename: WideString; readOnly: Integer): IChilkatCertStore; dispid 9;
    function CreateFileStore(const filename: WideString): IChilkatCertStore; dispid 10;
    function OpenRegistryStore(const regRoot: WideString; const regPath: WideString; 
                               readOnly: Integer): IChilkatCertStore; dispid 11;
    function CreateRegistryStore(const regRoot: WideString; const regPath: WideString): IChilkatCertStore; dispid 12;
    procedure SaveLastError(const filename: WideString); dispid 15;
    property readOnly: Integer dispid 16;
    property LastErrorHtml: WideString readonly dispid 17;
    property LastErrorXml: WideString readonly dispid 18;
    property LastErrorText: WideString readonly dispid 19;
  end;

// *********************************************************************//
// Interface: IChilkatCertChain
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {811AA1E0-4C88-4274-AABB-F8D171444D52}
// *********************************************************************//
  IChilkatCertChain = interface(IDispatch)
    ['{811AA1E0-4C88-4274-AABB-F8D171444D52}']
    function Get_NumCerts: Integer; safecall;
    function BuildChain(const iCert: IChilkatCert; const iExtraCerts: IChilkatCertColl): Integer; safecall;
    function GetCert(index: Integer): IChilkatCert; safecall;
    function Get_LastErrorHtml: WideString; safecall;
    function Get_LastErrorXml: WideString; safecall;
    function Get_LastErrorText: WideString; safecall;
    procedure SaveLastError(const filename: WideString); safecall;
    property NumCerts: Integer read Get_NumCerts;
    property LastErrorHtml: WideString read Get_LastErrorHtml;
    property LastErrorXml: WideString read Get_LastErrorXml;
    property LastErrorText: WideString read Get_LastErrorText;
  end;

// *********************************************************************//
// DispIntf:  IChilkatCertChainDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {811AA1E0-4C88-4274-AABB-F8D171444D52}
// *********************************************************************//
  IChilkatCertChainDisp = dispinterface
    ['{811AA1E0-4C88-4274-AABB-F8D171444D52}']
    property NumCerts: Integer readonly dispid 1;
    function BuildChain(const iCert: IChilkatCert; const iExtraCerts: IChilkatCertColl): Integer; dispid 2;
    function GetCert(index: Integer): IChilkatCert; dispid 3;
    property LastErrorHtml: WideString readonly dispid 4;
    property LastErrorXml: WideString readonly dispid 5;
    property LastErrorText: WideString readonly dispid 6;
    procedure SaveLastError(const filename: WideString); dispid 7;
  end;

// *********************************************************************//
// Interface: IChilkatCertColl
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3296199A-B3A0-4AF1-8673-3F76C5FD6FD5}
// *********************************************************************//
  IChilkatCertColl = interface(IDispatch)
    ['{3296199A-B3A0-4AF1-8673-3F76C5FD6FD5}']
    function LoadPkcs7File(const filename: WideString): Integer; safecall;
    function Get_NumCerts: Integer; safecall;
    function GetCert(index: Integer): IChilkatCert; safecall;
    function Get_LastErrorHtml: WideString; safecall;
    function Get_LastErrorXml: WideString; safecall;
    function Get_LastErrorText: WideString; safecall;
    procedure SaveLastError(const filename: WideString); safecall;
    property NumCerts: Integer read Get_NumCerts;
    property LastErrorHtml: WideString read Get_LastErrorHtml;
    property LastErrorXml: WideString read Get_LastErrorXml;
    property LastErrorText: WideString read Get_LastErrorText;
  end;

// *********************************************************************//
// DispIntf:  IChilkatCertCollDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3296199A-B3A0-4AF1-8673-3F76C5FD6FD5}
// *********************************************************************//
  IChilkatCertCollDisp = dispinterface
    ['{3296199A-B3A0-4AF1-8673-3F76C5FD6FD5}']
    function LoadPkcs7File(const filename: WideString): Integer; dispid 1;
    property NumCerts: Integer readonly dispid 2;
    function GetCert(index: Integer): IChilkatCert; dispid 3;
    property LastErrorHtml: WideString readonly dispid 4;
    property LastErrorXml: WideString readonly dispid 5;
    property LastErrorText: WideString readonly dispid 6;
    procedure SaveLastError(const filename: WideString); dispid 7;
  end;

// *********************************************************************//
// Interface: IKeyContainer
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D338B7B4-0478-448E-AFC3-D005E6DFE790}
// *********************************************************************//
  IKeyContainer = interface(IDispatch)
    ['{D338B7B4-0478-448E-AFC3-D005E6DFE790}']
    function Get_IsOpen: Integer; safecall;
    function Get_IsMachineKeyset: Integer; safecall;
    function Get_containerName: WideString; safecall;
    function GenerateUuid: WideString; safecall;
    function CreateContainer(const name: WideString; MachineKeyset: Integer): Integer; safecall;
    function OpenContainer(const name: WideString; needPrivateKeyAccess: Integer; 
                           MachineKeyset: Integer): Integer; safecall;
    function DeleteContainer: Integer; safecall;
    procedure CloseContainer; safecall;
    function GenerateKeyPair(forKeyExchange: Integer; keyLengthInBits: Integer): Integer; safecall;
    function GetPrivateKey(forKeyExchange: Integer): IPrivateKey; safecall;
    function GetPublicKey(forKeyExchange: Integer): IPublicKey; safecall;
    function ImportPublicKey(const key: IPublicKey; forKeyExchange: Integer): Integer; safecall;
    function ImportPrivateKey(const key: IPrivateKey; forKeyExchange: Integer): Integer; safecall;
    function SaveLastError(const filename: WideString): Integer; safecall;
    function Get_LastErrorText: WideString; safecall;
    function Get_LastErrorHtml: WideString; safecall;
    function Get_LastErrorXml: WideString; safecall;
    function FetchContainerNames(MachineKeyset: Integer): Integer; safecall;
    function GetNumContainers(MachineKeyset: Integer): Integer; safecall;
    function GetContainerName(MachineKeyset: Integer; index: Integer): WideString; safecall;
    property IsOpen: Integer read Get_IsOpen;
    property IsMachineKeyset: Integer read Get_IsMachineKeyset;
    property containerName: WideString read Get_containerName;
    property LastErrorText: WideString read Get_LastErrorText;
    property LastErrorHtml: WideString read Get_LastErrorHtml;
    property LastErrorXml: WideString read Get_LastErrorXml;
  end;

// *********************************************************************//
// DispIntf:  IKeyContainerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D338B7B4-0478-448E-AFC3-D005E6DFE790}
// *********************************************************************//
  IKeyContainerDisp = dispinterface
    ['{D338B7B4-0478-448E-AFC3-D005E6DFE790}']
    property IsOpen: Integer readonly dispid 1;
    property IsMachineKeyset: Integer readonly dispid 2;
    property containerName: WideString readonly dispid 3;
    function GenerateUuid: WideString; dispid 4;
    function CreateContainer(const name: WideString; MachineKeyset: Integer): Integer; dispid 5;
    function OpenContainer(const name: WideString; needPrivateKeyAccess: Integer; 
                           MachineKeyset: Integer): Integer; dispid 6;
    function DeleteContainer: Integer; dispid 7;
    procedure CloseContainer; dispid 8;
    function GenerateKeyPair(forKeyExchange: Integer; keyLengthInBits: Integer): Integer; dispid 9;
    function GetPrivateKey(forKeyExchange: Integer): IPrivateKey; dispid 10;
    function GetPublicKey(forKeyExchange: Integer): IPublicKey; dispid 11;
    function ImportPublicKey(const key: IPublicKey; forKeyExchange: Integer): Integer; dispid 12;
    function ImportPrivateKey(const key: IPrivateKey; forKeyExchange: Integer): Integer; dispid 13;
    function SaveLastError(const filename: WideString): Integer; dispid 14;
    property LastErrorText: WideString readonly dispid 15;
    property LastErrorHtml: WideString readonly dispid 16;
    property LastErrorXml: WideString readonly dispid 17;
    function FetchContainerNames(MachineKeyset: Integer): Integer; dispid 18;
    function GetNumContainers(MachineKeyset: Integer): Integer; dispid 19;
    function GetContainerName(MachineKeyset: Integer; index: Integer): WideString; dispid 20;
  end;

// *********************************************************************//
// Interface: IChilkatCSP
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D12FB216-99DA-4EB3-9CC0-C0F760B174A0}
// *********************************************************************//
  IChilkatCSP = interface(IDispatch)
    ['{D12FB216-99DA-4EB3-9CC0-C0F760B174A0}']
    function Get_NumHashAlgorithms: Integer; safecall;
    function Get_NumEncryptAlgorithms: Integer; safecall;
    function Get_ProviderName: WideString; safecall;
    procedure Set_ProviderName(const pVal: WideString); safecall;
    function Get_KeyContainerName: WideString; safecall;
    procedure Set_KeyContainerName(const pVal: WideString); safecall;
    function GetEncryptionAlgorithm(index: Integer): WideString; safecall;
    function GetEncryptionNumBits(index: Integer): Integer; safecall;
    function GetHashAlgorithm(index: Integer): WideString; safecall;
    function GetHashNumBits(index: Integer): Integer; safecall;
    function Get_EncryptAlgorithm: WideString; safecall;
    function Get_HashAlgorithm: WideString; safecall;
    function Get_EncryptNumBits: Integer; safecall;
    function Get_HashNumBits: Integer; safecall;
    function Get_EncryptAlgorithmID: Integer; safecall;
    function Get_HashAlgorithmID: Integer; safecall;
    function HasEncryptAlgorithm(const name: WideString; numBits: Integer): Integer; safecall;
    function SetEncryptAlgorithm(const name: WideString): Integer; safecall;
    function HasHashAlgorithm(const name: WideString; numBits: Integer): Integer; safecall;
    function SetHashAlgorithm(const name: WideString): Integer; safecall;
    function GetKeyContainerNames: ICkStringArray; safecall;
    function Get_ProviderType: Integer; safecall;
    procedure SetProviderMicrosoftBase; safecall;
    procedure SetProviderMicrosoftEnhanced; safecall;
    procedure SetProviderMicrosoftStrong; safecall;
    procedure SetProviderMicrosoftRsaAes; safecall;
    function Get_LastErrorHtml: WideString; safecall;
    function Get_LastErrorXml: WideString; safecall;
    function Get_LastErrorText: WideString; safecall;
    function Serialize: WideString; safecall;
    function Get_MachineKeyset: Integer; safecall;
    procedure Set_MachineKeyset(bVal: Integer); safecall;
    function Get_NumKeyContainers: Integer; safecall;
    function Get_NumKeyExchangeAlgorithms: Integer; safecall;
    function Get_NumSignatureAlgorithms: Integer; safecall;
    function GetKeyContainerName(index: Integer): WideString; safecall;
    function GetKeyExchangeAlgorithm(index: Integer): WideString; safecall;
    function GetKeyExchangeNumBits(index: Integer): Integer; safecall;
    function GetSignatureAlgorithm(index: Integer): WideString; safecall;
    function GetSignatureNumBits(index: Integer): Integer; safecall;
    property NumHashAlgorithms: Integer read Get_NumHashAlgorithms;
    property NumEncryptAlgorithms: Integer read Get_NumEncryptAlgorithms;
    property ProviderName: WideString read Get_ProviderName write Set_ProviderName;
    property KeyContainerName: WideString read Get_KeyContainerName write Set_KeyContainerName;
    property EncryptAlgorithm: WideString read Get_EncryptAlgorithm;
    property HashAlgorithm: WideString read Get_HashAlgorithm;
    property EncryptNumBits: Integer read Get_EncryptNumBits;
    property HashNumBits: Integer read Get_HashNumBits;
    property EncryptAlgorithmID: Integer read Get_EncryptAlgorithmID;
    property HashAlgorithmID: Integer read Get_HashAlgorithmID;
    property ProviderType: Integer read Get_ProviderType;
    property LastErrorHtml: WideString read Get_LastErrorHtml;
    property LastErrorXml: WideString read Get_LastErrorXml;
    property LastErrorText: WideString read Get_LastErrorText;
    property MachineKeyset: Integer read Get_MachineKeyset write Set_MachineKeyset;
    property NumKeyContainers: Integer read Get_NumKeyContainers;
    property NumKeyExchangeAlgorithms: Integer read Get_NumKeyExchangeAlgorithms;
    property NumSignatureAlgorithms: Integer read Get_NumSignatureAlgorithms;
  end;

// *********************************************************************//
// DispIntf:  IChilkatCSPDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D12FB216-99DA-4EB3-9CC0-C0F760B174A0}
// *********************************************************************//
  IChilkatCSPDisp = dispinterface
    ['{D12FB216-99DA-4EB3-9CC0-C0F760B174A0}']
    property NumHashAlgorithms: Integer readonly dispid 2;
    property NumEncryptAlgorithms: Integer readonly dispid 3;
    property ProviderName: WideString dispid 4;
    property KeyContainerName: WideString dispid 5;
    function GetEncryptionAlgorithm(index: Integer): WideString; dispid 6;
    function GetEncryptionNumBits(index: Integer): Integer; dispid 7;
    function GetHashAlgorithm(index: Integer): WideString; dispid 8;
    function GetHashNumBits(index: Integer): Integer; dispid 9;
    property EncryptAlgorithm: WideString readonly dispid 10;
    property HashAlgorithm: WideString readonly dispid 11;
    property EncryptNumBits: Integer readonly dispid 12;
    property HashNumBits: Integer readonly dispid 13;
    property EncryptAlgorithmID: Integer readonly dispid 14;
    property HashAlgorithmID: Integer readonly dispid 15;
    function HasEncryptAlgorithm(const name: WideString; numBits: Integer): Integer; dispid 16;
    function SetEncryptAlgorithm(const name: WideString): Integer; dispid 17;
    function HasHashAlgorithm(const name: WideString; numBits: Integer): Integer; dispid 18;
    function SetHashAlgorithm(const name: WideString): Integer; dispid 19;
    function GetKeyContainerNames: ICkStringArray; dispid 20;
    property ProviderType: Integer readonly dispid 21;
    procedure SetProviderMicrosoftBase; dispid 22;
    procedure SetProviderMicrosoftEnhanced; dispid 23;
    procedure SetProviderMicrosoftStrong; dispid 24;
    procedure SetProviderMicrosoftRsaAes; dispid 25;
    property LastErrorHtml: WideString readonly dispid 26;
    property LastErrorXml: WideString readonly dispid 27;
    property LastErrorText: WideString readonly dispid 28;
    function Serialize: WideString; dispid 29;
    property MachineKeyset: Integer dispid 30;
    property NumKeyContainers: Integer readonly dispid 31;
    property NumKeyExchangeAlgorithms: Integer readonly dispid 32;
    property NumSignatureAlgorithms: Integer readonly dispid 33;
    function GetKeyContainerName(index: Integer): WideString; dispid 34;
    function GetKeyExchangeAlgorithm(index: Integer): WideString; dispid 35;
    function GetKeyExchangeNumBits(index: Integer): Integer; dispid 36;
    function GetSignatureAlgorithm(index: Integer): WideString; dispid 37;
    function GetSignatureNumBits(index: Integer): Integer; dispid 38;
  end;

// *********************************************************************//
// Interface: ICkStringArray
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {4340DF8E-D7A3-4675-BE74-80077B2B3E81}
// *********************************************************************//
  ICkStringArray = interface(IDispatch)
    ['{4340DF8E-D7A3-4675-BE74-80077B2B3E81}']
    function Get_count: Integer; safecall;
    procedure Append(const str: WideString); safecall;
    procedure Clear; safecall;
    function Contains(const str: WideString): Integer; safecall;
    procedure Remove(const str: WideString); safecall;
    function GetString(index: Integer): WideString; safecall;
    function Serialize: WideString; safecall;
    procedure AppendSerialized(const encodedStr: WideString); safecall;
    function Get_Unique: Integer; safecall;
    procedure Set_Unique(bVal: Integer); safecall;
    function Get_Trim: Integer; safecall;
    procedure Set_Trim(bVal: Integer); safecall;
    function Get_Crlf: Integer; safecall;
    procedure Set_Crlf(bVal: Integer); safecall;
    procedure Prepend(const str: WideString); safecall;
    function Find(const str: WideString; beginIndex: Integer): Integer; safecall;
    procedure InsertAt(index: Integer; const str: WideString); safecall;
    procedure RemoveAt(index: Integer); safecall;
    function LastString: WideString; safecall;
    function Pop: WideString; safecall;
    function LoadFromFile(const filename: WideString): Integer; safecall;
    function SaveToFile(const filename: WideString): Integer; safecall;
    procedure Sort(ascending: Integer); safecall;
    procedure Union(const array_: ICkStringArray); safecall;
    procedure Intersect(const array_: ICkStringArray); safecall;
    procedure Subtract(const array_: ICkStringArray); safecall;
    procedure SplitAndAppend(const str: WideString; const boundary: WideString); safecall;
    function SaveNthToFile(index: Integer; const filename: WideString): Integer; safecall;
    procedure LoadFromText(const txt: WideString); safecall;
    function SaveToText: WideString; safecall;
    function FindFirstMatch(const str: WideString; beginIndex: Integer): Integer; safecall;
    property count: Integer read Get_count;
    property Unique: Integer read Get_Unique write Set_Unique;
    property Trim: Integer read Get_Trim write Set_Trim;
    property Crlf: Integer read Get_Crlf write Set_Crlf;
  end;

// *********************************************************************//
// DispIntf:  ICkStringArrayDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {4340DF8E-D7A3-4675-BE74-80077B2B3E81}
// *********************************************************************//
  ICkStringArrayDisp = dispinterface
    ['{4340DF8E-D7A3-4675-BE74-80077B2B3E81}']
    property count: Integer readonly dispid 1;
    procedure Append(const str: WideString); dispid 2;
    procedure Clear; dispid 3;
    function Contains(const str: WideString): Integer; dispid 4;
    procedure Remove(const str: WideString); dispid 5;
    function GetString(index: Integer): WideString; dispid 6;
    function Serialize: WideString; dispid 7;
    procedure AppendSerialized(const encodedStr: WideString); dispid 8;
    property Unique: Integer dispid 9;
    property Trim: Integer dispid 10;
    property Crlf: Integer dispid 11;
    procedure Prepend(const str: WideString); dispid 12;
    function Find(const str: WideString; beginIndex: Integer): Integer; dispid 13;
    procedure InsertAt(index: Integer; const str: WideString); dispid 14;
    procedure RemoveAt(index: Integer); dispid 15;
    function LastString: WideString; dispid 16;
    function Pop: WideString; dispid 17;
    function LoadFromFile(const filename: WideString): Integer; dispid 18;
    function SaveToFile(const filename: WideString): Integer; dispid 19;
    procedure Sort(ascending: Integer); dispid 20;
    procedure Union(const array_: ICkStringArray); dispid 21;
    procedure Intersect(const array_: ICkStringArray); dispid 22;
    procedure Subtract(const array_: ICkStringArray); dispid 23;
    procedure SplitAndAppend(const str: WideString; const boundary: WideString); dispid 24;
    function SaveNthToFile(index: Integer; const filename: WideString): Integer; dispid 25;
    procedure LoadFromText(const txt: WideString); dispid 26;
    function SaveToText: WideString; dispid 27;
    function FindFirstMatch(const str: WideString; beginIndex: Integer): Integer; dispid 28;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TChilkatCert
// Help String      : ChilkatCert Class
// Default Interface: IChilkatCert
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TChilkatCert = class(TOleControl)
  private
    FIntf: IChilkatCert;
    function  GetControlInterface: IChilkatCert;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function GetEncoded: WideString;
    function SetFromEncoded(const encodedCert: WideString): Integer;
    procedure SaveLastError(const filename: WideString);
    function LoadFromFile(const filename: WideString): Integer;
    function LoadFromBase64(const encodedCert: WideString): Integer;
    function LoadFromBinary(binaryBlob: OleVariant): Integer;
    function IsExpired: Integer;
    function HasPrivateKey: Integer;
    function SaveToFile(const filename: WideString): Integer;
    function ExportPublicKey: IPublicKey;
    function ExportPrivateKey: IPrivateKey;
    function LoadByEmailAddress(const emailAddress: WideString): Integer;
    function LoadByCommonName(const name: WideString): Integer;
    function PemFileToDerFile(const pemFilename: WideString; const derFilename: WideString): Integer;
    function LinkPrivateKey(const KeyContainerName: WideString; MachineKeyset: Integer; 
                            forSigning: Integer): Integer;
    function ExportCertPem: WideString;
    function ExportCertDer: OleVariant;
    function ExportCertPemFile(const filename: WideString): Integer;
    function ExportCertDerFile(const filename: WideString): Integer;
    function LoadPfxFile(const pfxFilename: WideString; const password: WideString): Integer;
    function LoadPfxData(pfxData: OleVariant; const password: WideString): Integer;
    function ExportToPfxFile(const pfxFilename: WideString; const password: WideString; 
                             includeChain: Integer): Integer;
    function CheckRevoked: Integer;
    function ExportCertXml: WideString;
    function SetPrivateKey(const privKey: IPrivateKey): Integer;
    function FindIssuer: IChilkatCert;
    function LoadByIssuerAndSerialNumber(const IssuerCN: WideString; const serialNum: WideString): Integer;
    function SetPrivateKeyPem(const privKeyPem: WideString): Integer;
    function GetPrivateKeyPem: WideString;
    property  ControlInterface: IChilkatCert read GetControlInterface;
    property  DefaultInterface: IChilkatCert read GetControlInterface;
    property Version: WideString index 1 read GetWideStringProp;
    property ForSecureEmail: Integer index 3 read GetIntegerProp;
    property ForServerAuthentication: Integer index 4 read GetIntegerProp;
    property ForClientAuthentication: Integer index 5 read GetIntegerProp;
    property ForCodeSigning: Integer index 6 read GetIntegerProp;
    property ForTimeStamping: Integer index 7 read GetIntegerProp;
    property SerialNumber: WideString index 8 read GetWideStringProp;
    property ValidFrom: TDateTime index 9 read GetTDateTimeProp;
    property ValidTo: TDateTime index 10 read GetTDateTimeProp;
    property SubjectCN: WideString index 11 read GetWideStringProp;
    property SubjectOU: WideString index 12 read GetWideStringProp;
    property SubjectO: WideString index 13 read GetWideStringProp;
    property SubjectL: WideString index 14 read GetWideStringProp;
    property SubjectS: WideString index 15 read GetWideStringProp;
    property SubjectC: WideString index 16 read GetWideStringProp;
    property SubjectE: WideString index 17 read GetWideStringProp;
    property IssuerCN: WideString index 18 read GetWideStringProp;
    property IssuerOU: WideString index 19 read GetWideStringProp;
    property IssuerO: WideString index 20 read GetWideStringProp;
    property IssuerL: WideString index 21 read GetWideStringProp;
    property IssuerS: WideString index 22 read GetWideStringProp;
    property IssuerC: WideString index 23 read GetWideStringProp;
    property IssuerE: WideString index 24 read GetWideStringProp;
    property SubjectDN: WideString index 32 read GetWideStringProp;
    property IssuerDN: WideString index 33 read GetWideStringProp;
    property LastErrorHtml: WideString index 34 read GetWideStringProp;
    property LastErrorXml: WideString index 35 read GetWideStringProp;
    property LastErrorText: WideString index 36 read GetWideStringProp;
    property Rfc822Name: WideString index 39 read GetWideStringProp;
    property Expired: Integer index 40 read GetIntegerProp;
    property SignatureVerified: Integer index 41 read GetIntegerProp;
    property Revoked: Integer index 42 read GetIntegerProp;
    property TrustedRoot: Integer index 43 read GetIntegerProp;
    property Sha1Thumbprint: WideString index 46 read GetWideStringProp;
    property HasKeyContainer: Integer index 49 read GetIntegerProp;
    property KeyContainerName: WideString index 50 read GetWideStringProp;
    property CspName: WideString index 51 read GetWideStringProp;
    property MachineKeyset: Integer index 52 read GetIntegerProp;
    property Silent: Integer index 53 read GetIntegerProp;
    property IntendedKeyUsage: Integer index 62 read GetIntegerProp;
    property IsRoot: Integer index 66 read GetIntegerProp;
    property CertVersion: Integer index 70 read GetIntegerProp;
    property OcspUrl: WideString index 72 read GetWideStringProp;
    property SelfSigned: Integer index 75 read GetIntegerProp;
  published
    property Anchors;
    property VerboseLogging: Integer index 69 read GetIntegerProp write SetIntegerProp stored False;
  end;

// *********************************************************************//
// The Class CoChilkatCertStore provides a Create and CreateRemote method to          
// create instances of the default interface IChilkatCertStore exposed by              
// the CoClass ChilkatCertStore. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoChilkatCertStore = class
    class function Create: IChilkatCertStore;
    class function CreateRemote(const MachineName: string): IChilkatCertStore;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TChilkatCreateCS
// Help String      : ChilkatCreateCS Class
// Default Interface: IChilkatCreateCS
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TChilkatCreateCS = class(TOleControl)
  private
    FIntf: IChilkatCreateCS;
    function  GetControlInterface: IChilkatCreateCS;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function OpenCurrentUserStore: IChilkatCertStore;
    function OpenLocalSystemStore: IChilkatCertStore;
    function OpenOutlookStore: IChilkatCertStore;
    function OpenChilkatStore: IChilkatCertStore;
    function CreateMemoryStore: IChilkatCertStore;
    function OpenFileStore(const filename: WideString; readOnly: Integer): IChilkatCertStore;
    function CreateFileStore(const filename: WideString): IChilkatCertStore;
    function OpenRegistryStore(const regRoot: WideString; const regPath: WideString; 
                               readOnly: Integer): IChilkatCertStore;
    function CreateRegistryStore(const regRoot: WideString; const regPath: WideString): IChilkatCertStore;
    procedure SaveLastError(const filename: WideString);
    property  ControlInterface: IChilkatCreateCS read GetControlInterface;
    property  DefaultInterface: IChilkatCreateCS read GetControlInterface;
    property Version: WideString index 7 read GetWideStringProp;
    property LastErrorHtml: WideString index 17 read GetWideStringProp;
    property LastErrorXml: WideString index 18 read GetWideStringProp;
    property LastErrorText: WideString index 19 read GetWideStringProp;
  published
    property Anchors;
    property readOnly: Integer index 16 read GetIntegerProp write SetIntegerProp stored False;
  end;

// *********************************************************************//
// The Class CoChilkatCertChain provides a Create and CreateRemote method to          
// create instances of the default interface IChilkatCertChain exposed by              
// the CoClass ChilkatCertChain. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoChilkatCertChain = class
    class function Create: IChilkatCertChain;
    class function CreateRemote(const MachineName: string): IChilkatCertChain;
  end;

// *********************************************************************//
// The Class CoChilkatCertColl provides a Create and CreateRemote method to          
// create instances of the default interface IChilkatCertColl exposed by              
// the CoClass ChilkatCertColl. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoChilkatCertColl = class
    class function Create: IChilkatCertColl;
    class function CreateRemote(const MachineName: string): IChilkatCertColl;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TprivateKey
// Help String      : PrivateKey Class
// Default Interface: IPrivateKey
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TprivateKey = class(TOleControl)
  private
    FIntf: IPrivateKey;
    function  GetControlInterface: IPrivateKey;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function LoadRsaDerFile(const filename: WideString): Integer;
    function LoadPkcs8File(const filename: WideString): Integer;
    function LoadPemFile(const filename: WideString): Integer;
    function LoadXmlFile(const filename: WideString): Integer;
    function LoadPem(const str: WideString): Integer;
    function LoadRsaDer(derData: OleVariant): Integer;
    function LoadPkcs8(pkcs8Data: OleVariant): Integer;
    function LoadXml(const xmlDoc: WideString): Integer;
    function SaveRsaDerFile(const filename: WideString): Integer;
    function SavePkcs8File(const filename: WideString): Integer;
    function SaveRsaPemFile(const filename: WideString): Integer;
    function SavePkcs8PemFile(const filename: WideString): Integer;
    function SaveXmlFile(const filename: WideString): Integer;
    function GetRsaDer: OleVariant;
    function GetPkcs8: OleVariant;
    function GetRsaPem: WideString;
    function GetPkcs8Pem: WideString;
    function GetXml: WideString;
    function SaveLastError(const filename: WideString): Integer;
    function LoadPvkFile(const filename: WideString; const password: WideString): Integer;
    function LoadPvk(pvkData: OleVariant; const password: WideString): Integer;
    function LoadEncryptedPem(const pemStr: WideString; const password: WideString): Integer;
    function LoadEncryptedPemFile(const filename: WideString; const password: WideString): Integer;
    function LoadPkcs8Encrypted(data: OleVariant; const password: WideString): Integer;
    function LoadPkcs8EncryptedFile(const filename: WideString; const password: WideString): Integer;
    function GetPkcs8Encrypted(const password: WideString): OleVariant;
    function GetPkcs8EncryptedPem(const password: WideString): WideString;
    function SavePkcs8EncryptedFile(const password: WideString; const filename: WideString): Integer;
    function SavePkcs8EncryptedPemFile(const password: WideString; const filename: WideString): Integer;
    property  ControlInterface: IPrivateKey read GetControlInterface;
    property  DefaultInterface: IPrivateKey read GetControlInterface;
    property LastErrorXml: WideString index 20 read GetWideStringProp;
    property LastErrorText: WideString index 21 read GetWideStringProp;
    property LastErrorHtml: WideString index 22 read GetWideStringProp;
  published
    property Anchors;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TKeyContainer
// Help String      : KeyContainer Class
// Default Interface: IKeyContainer
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TKeyContainer = class(TOleControl)
  private
    FIntf: IKeyContainer;
    function  GetControlInterface: IKeyContainer;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function GenerateUuid: WideString;
    function CreateContainer(const name: WideString; MachineKeyset: Integer): Integer;
    function OpenContainer(const name: WideString; needPrivateKeyAccess: Integer; 
                           MachineKeyset: Integer): Integer;
    function DeleteContainer: Integer;
    procedure CloseContainer;
    function GenerateKeyPair(forKeyExchange: Integer; keyLengthInBits: Integer): Integer;
    function GetPrivateKey(forKeyExchange: Integer): IPrivateKey;
    function GetPublicKey(forKeyExchange: Integer): IPublicKey;
    function ImportPublicKey(const key: IPublicKey; forKeyExchange: Integer): Integer;
    function ImportPrivateKey(const key: IPrivateKey; forKeyExchange: Integer): Integer;
    function SaveLastError(const filename: WideString): Integer;
    function FetchContainerNames(MachineKeyset: Integer): Integer;
    function GetNumContainers(MachineKeyset: Integer): Integer;
    function GetContainerName(MachineKeyset: Integer; index: Integer): WideString;
    property  ControlInterface: IKeyContainer read GetControlInterface;
    property  DefaultInterface: IKeyContainer read GetControlInterface;
    property IsOpen: Integer index 1 read GetIntegerProp;
    property IsMachineKeyset: Integer index 2 read GetIntegerProp;
    property containerName: WideString index 3 read GetWideStringProp;
    property LastErrorText: WideString index 15 read GetWideStringProp;
    property LastErrorHtml: WideString index 16 read GetWideStringProp;
    property LastErrorXml: WideString index 17 read GetWideStringProp;
  published
    property Anchors;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TpublicKey
// Help String      : PublicKey Class
// Default Interface: IPublicKey
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TpublicKey = class(TOleControl)
  private
    FIntf: IPublicKey;
    function  GetControlInterface: IPublicKey;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function LoadRsaDerFile(const filename: WideString): Integer;
    function LoadOpenSslDerFile(const filename: WideString): Integer;
    function LoadOpenSslPemFile(const filename: WideString): Integer;
    function LoadXmlFile(const filename: WideString): Integer;
    function SaveRsaDerFile(const filename: WideString): Integer;
    function SaveOpenSslDerFile(const filename: WideString): Integer;
    function SaveOpenSslPemFile(const filename: WideString): Integer;
    function SaveXmlFile(const filename: WideString): Integer;
    function LoadOpenSslPem(const pemStr: WideString): Integer;
    function LoadOpenSslDer(derData: OleVariant): Integer;
    function LoadRsaDer(derData: OleVariant): Integer;
    function LoadXml(const xml: WideString): Integer;
    function GetRsaDer: OleVariant;
    function GetOpenSslDer: OleVariant;
    function GetOpenSslPem: WideString;
    function GetXml: WideString;
    function SaveLastError(const filename: WideString): Integer;
    function LoadPkcs1Pem(const str: WideString): Integer;
    property  ControlInterface: IPublicKey read GetControlInterface;
    property  DefaultInterface: IPublicKey read GetControlInterface;
    property LastErrorText: WideString index 18 read GetWideStringProp;
    property LastErrorHtml: WideString index 19 read GetWideStringProp;
    property LastErrorXml: WideString index 20 read GetWideStringProp;
  published
    property Anchors;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TChilkatCSP
// Help String      : ChilkatCSP Class
// Default Interface: IChilkatCSP
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TChilkatCSP = class(TOleControl)
  private
    FIntf: IChilkatCSP;
    function  GetControlInterface: IChilkatCSP;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function GetEncryptionAlgorithm(index: Integer): WideString;
    function GetEncryptionNumBits(index: Integer): Integer;
    function GetHashAlgorithm(index: Integer): WideString;
    function GetHashNumBits(index: Integer): Integer;
    function HasEncryptAlgorithm(const name: WideString; numBits: Integer): Integer;
    function SetEncryptAlgorithm(const name: WideString): Integer;
    function HasHashAlgorithm(const name: WideString; numBits: Integer): Integer;
    function SetHashAlgorithm(const name: WideString): Integer;
    function GetKeyContainerNames: ICkStringArray;
    procedure SetProviderMicrosoftBase;
    procedure SetProviderMicrosoftEnhanced;
    procedure SetProviderMicrosoftStrong;
    procedure SetProviderMicrosoftRsaAes;
    function Serialize: WideString;
    function GetKeyContainerName(index: Integer): WideString;
    function GetKeyExchangeAlgorithm(index: Integer): WideString;
    function GetKeyExchangeNumBits(index: Integer): Integer;
    function GetSignatureAlgorithm(index: Integer): WideString;
    function GetSignatureNumBits(index: Integer): Integer;
    property  ControlInterface: IChilkatCSP read GetControlInterface;
    property  DefaultInterface: IChilkatCSP read GetControlInterface;
    property NumHashAlgorithms: Integer index 2 read GetIntegerProp;
    property NumEncryptAlgorithms: Integer index 3 read GetIntegerProp;
    property EncryptAlgorithm: WideString index 10 read GetWideStringProp;
    property HashAlgorithm: WideString index 11 read GetWideStringProp;
    property EncryptNumBits: Integer index 12 read GetIntegerProp;
    property HashNumBits: Integer index 13 read GetIntegerProp;
    property EncryptAlgorithmID: Integer index 14 read GetIntegerProp;
    property HashAlgorithmID: Integer index 15 read GetIntegerProp;
    property ProviderType: Integer index 21 read GetIntegerProp;
    property LastErrorHtml: WideString index 26 read GetWideStringProp;
    property LastErrorXml: WideString index 27 read GetWideStringProp;
    property LastErrorText: WideString index 28 read GetWideStringProp;
    property NumKeyContainers: Integer index 31 read GetIntegerProp;
    property NumKeyExchangeAlgorithms: Integer index 32 read GetIntegerProp;
    property NumSignatureAlgorithms: Integer index 33 read GetIntegerProp;
  published
    property Anchors;
    property ProviderName: WideString index 4 read GetWideStringProp write SetWideStringProp stored False;
    property KeyContainerName: WideString index 5 read GetWideStringProp write SetWideStringProp stored False;
    property MachineKeyset: Integer index 30 read GetIntegerProp write SetIntegerProp stored False;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses System.Win.ComObj;

procedure TChilkatCert.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID:      '{E2A74106-0416-43D8-8FE8-833E9AD098EA}';
    EventIID:     '';
    EventCount:   0;
    EventDispIDs: nil;
    LicenseKey:   nil (*HR:$80004002*);
    Flags:        $00000000;
    Version:      500);
begin
  ControlData := @CControlData;
end;

procedure TChilkatCert.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IChilkatCert;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TChilkatCert.GetControlInterface: IChilkatCert;
begin
  CreateControl;
  Result := FIntf;
end;

function TChilkatCert.GetEncoded: WideString;
begin
  Result := DefaultInterface.GetEncoded;
end;

function TChilkatCert.SetFromEncoded(const encodedCert: WideString): Integer;
begin
  Result := DefaultInterface.SetFromEncoded(encodedCert);
end;

procedure TChilkatCert.SaveLastError(const filename: WideString);
begin
  DefaultInterface.SaveLastError(filename);
end;

function TChilkatCert.LoadFromFile(const filename: WideString): Integer;
begin
  Result := DefaultInterface.LoadFromFile(filename);
end;

function TChilkatCert.LoadFromBase64(const encodedCert: WideString): Integer;
begin
  Result := DefaultInterface.LoadFromBase64(encodedCert);
end;

function TChilkatCert.LoadFromBinary(binaryBlob: OleVariant): Integer;
begin
  Result := DefaultInterface.LoadFromBinary(binaryBlob);
end;

function TChilkatCert.IsExpired: Integer;
begin
  Result := DefaultInterface.IsExpired;
end;

function TChilkatCert.HasPrivateKey: Integer;
begin
  Result := DefaultInterface.HasPrivateKey;
end;

function TChilkatCert.SaveToFile(const filename: WideString): Integer;
begin
  Result := DefaultInterface.SaveToFile(filename);
end;

function TChilkatCert.ExportPublicKey: IPublicKey;
begin
  Result := DefaultInterface.ExportPublicKey;
end;

function TChilkatCert.ExportPrivateKey: IPrivateKey;
begin
  Result := DefaultInterface.ExportPrivateKey;
end;

function TChilkatCert.LoadByEmailAddress(const emailAddress: WideString): Integer;
begin
  Result := DefaultInterface.LoadByEmailAddress(emailAddress);
end;

function TChilkatCert.LoadByCommonName(const name: WideString): Integer;
begin
  Result := DefaultInterface.LoadByCommonName(name);
end;

function TChilkatCert.PemFileToDerFile(const pemFilename: WideString; const derFilename: WideString): Integer;
begin
  Result := DefaultInterface.PemFileToDerFile(pemFilename, derFilename);
end;

function TChilkatCert.LinkPrivateKey(const KeyContainerName: WideString; MachineKeyset: Integer; 
                                     forSigning: Integer): Integer;
begin
  Result := DefaultInterface.LinkPrivateKey(KeyContainerName, MachineKeyset, forSigning);
end;

function TChilkatCert.ExportCertPem: WideString;
begin
  Result := DefaultInterface.ExportCertPem;
end;

function TChilkatCert.ExportCertDer: OleVariant;
begin
  Result := DefaultInterface.ExportCertDer;
end;

function TChilkatCert.ExportCertPemFile(const filename: WideString): Integer;
begin
  Result := DefaultInterface.ExportCertPemFile(filename);
end;

function TChilkatCert.ExportCertDerFile(const filename: WideString): Integer;
begin
  Result := DefaultInterface.ExportCertDerFile(filename);
end;

function TChilkatCert.LoadPfxFile(const pfxFilename: WideString; const password: WideString): Integer;
begin
  Result := DefaultInterface.LoadPfxFile(pfxFilename, password);
end;

function TChilkatCert.LoadPfxData(pfxData: OleVariant; const password: WideString): Integer;
begin
  Result := DefaultInterface.LoadPfxData(pfxData, password);
end;

function TChilkatCert.ExportToPfxFile(const pfxFilename: WideString; const password: WideString; 
                                      includeChain: Integer): Integer;
begin
  Result := DefaultInterface.ExportToPfxFile(pfxFilename, password, includeChain);
end;

function TChilkatCert.CheckRevoked: Integer;
begin
  Result := DefaultInterface.CheckRevoked;
end;

function TChilkatCert.ExportCertXml: WideString;
begin
  Result := DefaultInterface.ExportCertXml;
end;

function TChilkatCert.SetPrivateKey(const privKey: IPrivateKey): Integer;
begin
  Result := DefaultInterface.SetPrivateKey(privKey);
end;

function TChilkatCert.FindIssuer: IChilkatCert;
begin
  Result := DefaultInterface.FindIssuer;
end;

function TChilkatCert.LoadByIssuerAndSerialNumber(const IssuerCN: WideString; 
                                                  const serialNum: WideString): Integer;
begin
  Result := DefaultInterface.LoadByIssuerAndSerialNumber(IssuerCN, serialNum);
end;

function TChilkatCert.SetPrivateKeyPem(const privKeyPem: WideString): Integer;
begin
  Result := DefaultInterface.SetPrivateKeyPem(privKeyPem);
end;

function TChilkatCert.GetPrivateKeyPem: WideString;
begin
  Result := DefaultInterface.GetPrivateKeyPem;
end;

class function CoChilkatCertStore.Create: IChilkatCertStore;
begin
  Result := CreateComObject(CLASS_ChilkatCertStore) as IChilkatCertStore;
end;

class function CoChilkatCertStore.CreateRemote(const MachineName: string): IChilkatCertStore;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ChilkatCertStore) as IChilkatCertStore;
end;

procedure TChilkatCreateCS.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID:      '{7455CC38-FC70-4785-9551-15FA0F5DBC98}';
    EventIID:     '';
    EventCount:   0;
    EventDispIDs: nil;
    LicenseKey:   nil (*HR:$80004002*);
    Flags:        $00000000;
    Version:      500);
begin
  ControlData := @CControlData;
end;

procedure TChilkatCreateCS.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IChilkatCreateCS;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TChilkatCreateCS.GetControlInterface: IChilkatCreateCS;
begin
  CreateControl;
  Result := FIntf;
end;

function TChilkatCreateCS.OpenCurrentUserStore: IChilkatCertStore;
begin
  Result := DefaultInterface.OpenCurrentUserStore;
end;

function TChilkatCreateCS.OpenLocalSystemStore: IChilkatCertStore;
begin
  Result := DefaultInterface.OpenLocalSystemStore;
end;

function TChilkatCreateCS.OpenOutlookStore: IChilkatCertStore;
begin
  Result := DefaultInterface.OpenOutlookStore;
end;

function TChilkatCreateCS.OpenChilkatStore: IChilkatCertStore;
begin
  Result := DefaultInterface.OpenChilkatStore;
end;

function TChilkatCreateCS.CreateMemoryStore: IChilkatCertStore;
begin
  Result := DefaultInterface.CreateMemoryStore;
end;

function TChilkatCreateCS.OpenFileStore(const filename: WideString; readOnly: Integer): IChilkatCertStore;
begin
  Result := DefaultInterface.OpenFileStore(filename, readOnly);
end;

function TChilkatCreateCS.CreateFileStore(const filename: WideString): IChilkatCertStore;
begin
  Result := DefaultInterface.CreateFileStore(filename);
end;

function TChilkatCreateCS.OpenRegistryStore(const regRoot: WideString; const regPath: WideString; 
                                            readOnly: Integer): IChilkatCertStore;
begin
  Result := DefaultInterface.OpenRegistryStore(regRoot, regPath, readOnly);
end;

function TChilkatCreateCS.CreateRegistryStore(const regRoot: WideString; const regPath: WideString): IChilkatCertStore;
begin
  Result := DefaultInterface.CreateRegistryStore(regRoot, regPath);
end;

procedure TChilkatCreateCS.SaveLastError(const filename: WideString);
begin
  DefaultInterface.SaveLastError(filename);
end;

class function CoChilkatCertChain.Create: IChilkatCertChain;
begin
  Result := CreateComObject(CLASS_ChilkatCertChain) as IChilkatCertChain;
end;

class function CoChilkatCertChain.CreateRemote(const MachineName: string): IChilkatCertChain;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ChilkatCertChain) as IChilkatCertChain;
end;

class function CoChilkatCertColl.Create: IChilkatCertColl;
begin
  Result := CreateComObject(CLASS_ChilkatCertColl) as IChilkatCertColl;
end;

class function CoChilkatCertColl.CreateRemote(const MachineName: string): IChilkatCertColl;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ChilkatCertColl) as IChilkatCertColl;
end;

procedure TprivateKey.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID:      '{A934AEE3-8896-485F-8A55-ACF2A87BD010}';
    EventIID:     '';
    EventCount:   0;
    EventDispIDs: nil;
    LicenseKey:   nil (*HR:$80004002*);
    Flags:        $00000000;
    Version:      500);
begin
  ControlData := @CControlData;
end;

procedure TprivateKey.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IPrivateKey;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TprivateKey.GetControlInterface: IPrivateKey;
begin
  CreateControl;
  Result := FIntf;
end;

function TprivateKey.LoadRsaDerFile(const filename: WideString): Integer;
begin
  Result := DefaultInterface.LoadRsaDerFile(filename);
end;

function TprivateKey.LoadPkcs8File(const filename: WideString): Integer;
begin
  Result := DefaultInterface.LoadPkcs8File(filename);
end;

function TprivateKey.LoadPemFile(const filename: WideString): Integer;
begin
  Result := DefaultInterface.LoadPemFile(filename);
end;

function TprivateKey.LoadXmlFile(const filename: WideString): Integer;
begin
  Result := DefaultInterface.LoadXmlFile(filename);
end;

function TprivateKey.LoadPem(const str: WideString): Integer;
begin
  Result := DefaultInterface.LoadPem(str);
end;

function TprivateKey.LoadRsaDer(derData: OleVariant): Integer;
begin
  Result := DefaultInterface.LoadRsaDer(derData);
end;

function TprivateKey.LoadPkcs8(pkcs8Data: OleVariant): Integer;
begin
  Result := DefaultInterface.LoadPkcs8(pkcs8Data);
end;

function TprivateKey.LoadXml(const xmlDoc: WideString): Integer;
begin
  Result := DefaultInterface.LoadXml(xmlDoc);
end;

function TprivateKey.SaveRsaDerFile(const filename: WideString): Integer;
begin
  Result := DefaultInterface.SaveRsaDerFile(filename);
end;

function TprivateKey.SavePkcs8File(const filename: WideString): Integer;
begin
  Result := DefaultInterface.SavePkcs8File(filename);
end;

function TprivateKey.SaveRsaPemFile(const filename: WideString): Integer;
begin
  Result := DefaultInterface.SaveRsaPemFile(filename);
end;

function TprivateKey.SavePkcs8PemFile(const filename: WideString): Integer;
begin
  Result := DefaultInterface.SavePkcs8PemFile(filename);
end;

function TprivateKey.SaveXmlFile(const filename: WideString): Integer;
begin
  Result := DefaultInterface.SaveXmlFile(filename);
end;

function TprivateKey.GetRsaDer: OleVariant;
begin
  Result := DefaultInterface.GetRsaDer;
end;

function TprivateKey.GetPkcs8: OleVariant;
begin
  Result := DefaultInterface.GetPkcs8;
end;

function TprivateKey.GetRsaPem: WideString;
begin
  Result := DefaultInterface.GetRsaPem;
end;

function TprivateKey.GetPkcs8Pem: WideString;
begin
  Result := DefaultInterface.GetPkcs8Pem;
end;

function TprivateKey.GetXml: WideString;
begin
  Result := DefaultInterface.GetXml;
end;

function TprivateKey.SaveLastError(const filename: WideString): Integer;
begin
  Result := DefaultInterface.SaveLastError(filename);
end;

function TprivateKey.LoadPvkFile(const filename: WideString; const password: WideString): Integer;
begin
  Result := DefaultInterface.LoadPvkFile(filename, password);
end;

function TprivateKey.LoadPvk(pvkData: OleVariant; const password: WideString): Integer;
begin
  Result := DefaultInterface.LoadPvk(pvkData, password);
end;

function TprivateKey.LoadEncryptedPem(const pemStr: WideString; const password: WideString): Integer;
begin
  Result := DefaultInterface.LoadEncryptedPem(pemStr, password);
end;

function TprivateKey.LoadEncryptedPemFile(const filename: WideString; const password: WideString): Integer;
begin
  Result := DefaultInterface.LoadEncryptedPemFile(filename, password);
end;

function TprivateKey.LoadPkcs8Encrypted(data: OleVariant; const password: WideString): Integer;
begin
  Result := DefaultInterface.LoadPkcs8Encrypted(data, password);
end;

function TprivateKey.LoadPkcs8EncryptedFile(const filename: WideString; const password: WideString): Integer;
begin
  Result := DefaultInterface.LoadPkcs8EncryptedFile(filename, password);
end;

function TprivateKey.GetPkcs8Encrypted(const password: WideString): OleVariant;
begin
  Result := DefaultInterface.GetPkcs8Encrypted(password);
end;

function TprivateKey.GetPkcs8EncryptedPem(const password: WideString): WideString;
begin
  Result := DefaultInterface.GetPkcs8EncryptedPem(password);
end;

function TprivateKey.SavePkcs8EncryptedFile(const password: WideString; const filename: WideString): Integer;
begin
  Result := DefaultInterface.SavePkcs8EncryptedFile(password, filename);
end;

function TprivateKey.SavePkcs8EncryptedPemFile(const password: WideString; 
                                               const filename: WideString): Integer;
begin
  Result := DefaultInterface.SavePkcs8EncryptedPemFile(password, filename);
end;

procedure TKeyContainer.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID:      '{695FB128-85C1-4DF3-A2BE-3123D13E2564}';
    EventIID:     '';
    EventCount:   0;
    EventDispIDs: nil;
    LicenseKey:   nil (*HR:$80004002*);
    Flags:        $00000000;
    Version:      500);
begin
  ControlData := @CControlData;
end;

procedure TKeyContainer.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IKeyContainer;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TKeyContainer.GetControlInterface: IKeyContainer;
begin
  CreateControl;
  Result := FIntf;
end;

function TKeyContainer.GenerateUuid: WideString;
begin
  Result := DefaultInterface.GenerateUuid;
end;

function TKeyContainer.CreateContainer(const name: WideString; MachineKeyset: Integer): Integer;
begin
  Result := DefaultInterface.CreateContainer(name, MachineKeyset);
end;

function TKeyContainer.OpenContainer(const name: WideString; needPrivateKeyAccess: Integer; 
                                     MachineKeyset: Integer): Integer;
begin
  Result := DefaultInterface.OpenContainer(name, needPrivateKeyAccess, MachineKeyset);
end;

function TKeyContainer.DeleteContainer: Integer;
begin
  Result := DefaultInterface.DeleteContainer;
end;

procedure TKeyContainer.CloseContainer;
begin
  DefaultInterface.CloseContainer;
end;

function TKeyContainer.GenerateKeyPair(forKeyExchange: Integer; keyLengthInBits: Integer): Integer;
begin
  Result := DefaultInterface.GenerateKeyPair(forKeyExchange, keyLengthInBits);
end;

function TKeyContainer.GetPrivateKey(forKeyExchange: Integer): IPrivateKey;
begin
  Result := DefaultInterface.GetPrivateKey(forKeyExchange);
end;

function TKeyContainer.GetPublicKey(forKeyExchange: Integer): IPublicKey;
begin
  Result := DefaultInterface.GetPublicKey(forKeyExchange);
end;

function TKeyContainer.ImportPublicKey(const key: IPublicKey; forKeyExchange: Integer): Integer;
begin
  Result := DefaultInterface.ImportPublicKey(key, forKeyExchange);
end;

function TKeyContainer.ImportPrivateKey(const key: IPrivateKey; forKeyExchange: Integer): Integer;
begin
  Result := DefaultInterface.ImportPrivateKey(key, forKeyExchange);
end;

function TKeyContainer.SaveLastError(const filename: WideString): Integer;
begin
  Result := DefaultInterface.SaveLastError(filename);
end;

function TKeyContainer.FetchContainerNames(MachineKeyset: Integer): Integer;
begin
  Result := DefaultInterface.FetchContainerNames(MachineKeyset);
end;

function TKeyContainer.GetNumContainers(MachineKeyset: Integer): Integer;
begin
  Result := DefaultInterface.GetNumContainers(MachineKeyset);
end;

function TKeyContainer.GetContainerName(MachineKeyset: Integer; index: Integer): WideString;
begin
  Result := DefaultInterface.GetContainerName(MachineKeyset, index);
end;

procedure TpublicKey.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID:      '{51435758-75D7-45FC-A91A-C84DF4ECF725}';
    EventIID:     '';
    EventCount:   0;
    EventDispIDs: nil;
    LicenseKey:   nil (*HR:$80004002*);
    Flags:        $00000000;
    Version:      500);
begin
  ControlData := @CControlData;
end;

procedure TpublicKey.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IPublicKey;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TpublicKey.GetControlInterface: IPublicKey;
begin
  CreateControl;
  Result := FIntf;
end;

function TpublicKey.LoadRsaDerFile(const filename: WideString): Integer;
begin
  Result := DefaultInterface.LoadRsaDerFile(filename);
end;

function TpublicKey.LoadOpenSslDerFile(const filename: WideString): Integer;
begin
  Result := DefaultInterface.LoadOpenSslDerFile(filename);
end;

function TpublicKey.LoadOpenSslPemFile(const filename: WideString): Integer;
begin
  Result := DefaultInterface.LoadOpenSslPemFile(filename);
end;

function TpublicKey.LoadXmlFile(const filename: WideString): Integer;
begin
  Result := DefaultInterface.LoadXmlFile(filename);
end;

function TpublicKey.SaveRsaDerFile(const filename: WideString): Integer;
begin
  Result := DefaultInterface.SaveRsaDerFile(filename);
end;

function TpublicKey.SaveOpenSslDerFile(const filename: WideString): Integer;
begin
  Result := DefaultInterface.SaveOpenSslDerFile(filename);
end;

function TpublicKey.SaveOpenSslPemFile(const filename: WideString): Integer;
begin
  Result := DefaultInterface.SaveOpenSslPemFile(filename);
end;

function TpublicKey.SaveXmlFile(const filename: WideString): Integer;
begin
  Result := DefaultInterface.SaveXmlFile(filename);
end;

function TpublicKey.LoadOpenSslPem(const pemStr: WideString): Integer;
begin
  Result := DefaultInterface.LoadOpenSslPem(pemStr);
end;

function TpublicKey.LoadOpenSslDer(derData: OleVariant): Integer;
begin
  Result := DefaultInterface.LoadOpenSslDer(derData);
end;

function TpublicKey.LoadRsaDer(derData: OleVariant): Integer;
begin
  Result := DefaultInterface.LoadRsaDer(derData);
end;

function TpublicKey.LoadXml(const xml: WideString): Integer;
begin
  Result := DefaultInterface.LoadXml(xml);
end;

function TpublicKey.GetRsaDer: OleVariant;
begin
  Result := DefaultInterface.GetRsaDer;
end;

function TpublicKey.GetOpenSslDer: OleVariant;
begin
  Result := DefaultInterface.GetOpenSslDer;
end;

function TpublicKey.GetOpenSslPem: WideString;
begin
  Result := DefaultInterface.GetOpenSslPem;
end;

function TpublicKey.GetXml: WideString;
begin
  Result := DefaultInterface.GetXml;
end;

function TpublicKey.SaveLastError(const filename: WideString): Integer;
begin
  Result := DefaultInterface.SaveLastError(filename);
end;

function TpublicKey.LoadPkcs1Pem(const str: WideString): Integer;
begin
  Result := DefaultInterface.LoadPkcs1Pem(str);
end;

procedure TChilkatCSP.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID:      '{71D98090-5725-48E6-96A3-2A0AFBC3BC54}';
    EventIID:     '';
    EventCount:   0;
    EventDispIDs: nil;
    LicenseKey:   nil (*HR:$80004002*);
    Flags:        $00000000;
    Version:      500);
begin
  ControlData := @CControlData;
end;

procedure TChilkatCSP.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IChilkatCSP;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TChilkatCSP.GetControlInterface: IChilkatCSP;
begin
  CreateControl;
  Result := FIntf;
end;

function TChilkatCSP.GetEncryptionAlgorithm(index: Integer): WideString;
begin
  Result := DefaultInterface.GetEncryptionAlgorithm(index);
end;

function TChilkatCSP.GetEncryptionNumBits(index: Integer): Integer;
begin
  Result := DefaultInterface.GetEncryptionNumBits(index);
end;

function TChilkatCSP.GetHashAlgorithm(index: Integer): WideString;
begin
  Result := DefaultInterface.GetHashAlgorithm(index);
end;

function TChilkatCSP.GetHashNumBits(index: Integer): Integer;
begin
  Result := DefaultInterface.GetHashNumBits(index);
end;

function TChilkatCSP.HasEncryptAlgorithm(const name: WideString; numBits: Integer): Integer;
begin
  Result := DefaultInterface.HasEncryptAlgorithm(name, numBits);
end;

function TChilkatCSP.SetEncryptAlgorithm(const name: WideString): Integer;
begin
  Result := DefaultInterface.SetEncryptAlgorithm(name);
end;

function TChilkatCSP.HasHashAlgorithm(const name: WideString; numBits: Integer): Integer;
begin
  Result := DefaultInterface.HasHashAlgorithm(name, numBits);
end;

function TChilkatCSP.SetHashAlgorithm(const name: WideString): Integer;
begin
  Result := DefaultInterface.SetHashAlgorithm(name);
end;

function TChilkatCSP.GetKeyContainerNames: ICkStringArray;
begin
  Result := DefaultInterface.GetKeyContainerNames;
end;

procedure TChilkatCSP.SetProviderMicrosoftBase;
begin
  DefaultInterface.SetProviderMicrosoftBase;
end;

procedure TChilkatCSP.SetProviderMicrosoftEnhanced;
begin
  DefaultInterface.SetProviderMicrosoftEnhanced;
end;

procedure TChilkatCSP.SetProviderMicrosoftStrong;
begin
  DefaultInterface.SetProviderMicrosoftStrong;
end;

procedure TChilkatCSP.SetProviderMicrosoftRsaAes;
begin
  DefaultInterface.SetProviderMicrosoftRsaAes;
end;

function TChilkatCSP.Serialize: WideString;
begin
  Result := DefaultInterface.Serialize;
end;

function TChilkatCSP.GetKeyContainerName(index: Integer): WideString;
begin
  Result := DefaultInterface.GetKeyContainerName(index);
end;

function TChilkatCSP.GetKeyExchangeAlgorithm(index: Integer): WideString;
begin
  Result := DefaultInterface.GetKeyExchangeAlgorithm(index);
end;

function TChilkatCSP.GetKeyExchangeNumBits(index: Integer): Integer;
begin
  Result := DefaultInterface.GetKeyExchangeNumBits(index);
end;

function TChilkatCSP.GetSignatureAlgorithm(index: Integer): WideString;
begin
  Result := DefaultInterface.GetSignatureAlgorithm(index);
end;

function TChilkatCSP.GetSignatureNumBits(index: Integer): Integer;
begin
  Result := DefaultInterface.GetSignatureNumBits(index);
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TChilkatCert, TChilkatCreateCS, TprivateKey, TKeyContainer, 
    TpublicKey, TChilkatCSP]);
end;

end.
