unit CHILKATRSALib_TLB;

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
// File generated on 17/01/2023 12:29:20 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Projectos\chilkat_ativex\ChilkatRsa.dll (1)
// LIBID: {67172FE4-D401-4305-822B-C26F7F43A897}
// LCID: 0
// Helpfile: 
// HelpString: Chilkat RSA
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// SYS_KIND: SYS_WIN32
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
  CHILKATRSALibMajorVersion = 1;
  CHILKATRSALibMinorVersion = 0;

  LIBID_CHILKATRSALib: TGUID = '{67172FE4-D401-4305-822B-C26F7F43A897}';

  DIID__IChilkatRsaEvents: TGUID = '{68D89F5A-9FF2-4A5C-A57A-2A9884D405D6}';
  IID_IChilkatRsa: TGUID = '{133C8E30-1538-4832-BD58-C8B3CF6096F8}';
  CLASS_ChilkatRsa: TGUID = '{52C7AE02-787B-44F6-AC4B-AE690171AA58}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _IChilkatRsaEvents = dispinterface;
  IChilkatRsa = interface;
  IChilkatRsaDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  ChilkatRsa = IChilkatRsa;


// *********************************************************************//
// DispIntf:  _IChilkatRsaEvents
// Flags:     (4096) Dispatchable
// GUID:      {68D89F5A-9FF2-4A5C-A57A-2A9884D405D6}
// *********************************************************************//
  _IChilkatRsaEvents = dispinterface
    ['{68D89F5A-9FF2-4A5C-A57A-2A9884D405D6}']
  end;

// *********************************************************************//
// Interface: IChilkatRsa
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {133C8E30-1538-4832-BD58-C8B3CF6096F8}
// *********************************************************************//
  IChilkatRsa = interface(IDispatch)
    ['{133C8E30-1538-4832-BD58-C8B3CF6096F8}']
    function UnlockComponent(const unlockCode: WideString): Integer; safecall;
    function Get_LastErrorText: WideString; safecall;
    function Get_LastErrorXml: WideString; safecall;
    function Get_LastErrorHtml: WideString; safecall;
    function GenerateKey(numBits: Integer): Integer; safecall;
    function ExportPublicKey: WideString; safecall;
    function ExportPrivateKey: WideString; safecall;
    function ImportPublicKey(const xml: WideString): Integer; safecall;
    function ImportPrivateKey(const xml: WideString): Integer; safecall;
    function SnkToXml(const filename: WideString): WideString; safecall;
    function Get_numBits: Integer; safecall;
    function Get_OaepPadding: Integer; safecall;
    procedure Set_OaepPadding(bVal: Integer); safecall;
    function EncryptBytes(inData: OleVariant; usePrivateKey: Integer): OleVariant; safecall;
    function DecryptBytes(inData: OleVariant; usePrivateKey: Integer): OleVariant; safecall;
    function DecryptStringENC(const inStr: WideString; usePrivateKey: Integer): WideString; safecall;
    function DecryptString(inData: OleVariant; usePrivateKey: Integer): WideString; safecall;
    function DecryptBytesENC(const inStr: WideString; usePrivateKey: Integer): OleVariant; safecall;
    function EncryptStringENC(const inStr: WideString; usePrivateKey: Integer): WideString; safecall;
    function EncryptBytesENC(inData: OleVariant; usePrivateKey: Integer): WideString; safecall;
    function EncryptString(const inStr: WideString; usePrivateKey: Integer): OleVariant; safecall;
    function Get_EncodingMode: WideString; safecall;
    procedure Set_EncodingMode(const pVal: WideString); safecall;
    function Get_Charset: WideString; safecall;
    procedure Set_Charset(const pVal: WideString); safecall;
    function Get_Version: WideString; safecall;
    function VerifyStringENC(const contentStr: WideString; const hashAlg: WideString; 
                             const sigStr: WideString): Integer; safecall;
    function VerifyString(const contentStr: WideString; const hashAlg: WideString; 
                          sigData: OleVariant): Integer; safecall;
    function VerifyBytesENC(contentBytes: OleVariant; const hashAlg: WideString; 
                            const sigStr: WideString): Integer; safecall;
    function VerifyBytes(contentBytes: OleVariant; const hashAlg: WideString; sigBytes: OleVariant): Integer; safecall;
    function SignStringENC(const contentStr: WideString; const hashAlg: WideString): WideString; safecall;
    function SignBytesENC(contentBytes: OleVariant; const hashAlg: WideString): WideString; safecall;
    function SignString(const contentStr: WideString; const hashAlg: WideString): OleVariant; safecall;
    function SignBytes(contentBytes: OleVariant; const hashAlg: WideString): OleVariant; safecall;
    function Get_LittleEndian: Integer; safecall;
    procedure Set_LittleEndian(bVal: Integer); safecall;
    function SaveLastError(const logFilename: WideString): Integer; safecall;
    function OpenSslVerifyBytes(signature: OleVariant): OleVariant; safecall;
    function OpenSslSignBytes(data: OleVariant): OleVariant; safecall;
    function OpenSslSignBytesENC(data: OleVariant): WideString; safecall;
    function OpenSslSignString(const str: WideString): OleVariant; safecall;
    function OpenSslSignStringENC(const str: WideString): WideString; safecall;
    function OpenSslVerifyBytesENC(const str: WideString): OleVariant; safecall;
    function OpenSslVerifyString(data: OleVariant): WideString; safecall;
    function OpenSslVerifyStringENC(const str: WideString): WideString; safecall;
    function VerifyPrivateKey(const xml: WideString): Integer; safecall;
    function VerifyHash(hashBytes: OleVariant; const hashAlg: WideString; sigBytes: OleVariant): Integer; safecall;
    function VerifyHashENC(const encodedHash: WideString; const hashAlg: WideString; 
                           const encodedSig: WideString): Integer; safecall;
    function SignHash(hashBytes: OleVariant; const hashAlg: WideString): OleVariant; safecall;
    function SignHashENC(const encodedHash: WideString; const hashAlg: WideString): WideString; safecall;
    function Get_VerboseLogging: Integer; safecall;
    procedure Set_VerboseLogging(propVal: Integer); safecall;
    function Get_NoUnpad: Integer; safecall;
    procedure Set_NoUnpad(propVal: Integer); safecall;
    property LastErrorText: WideString read Get_LastErrorText;
    property LastErrorXml: WideString read Get_LastErrorXml;
    property LastErrorHtml: WideString read Get_LastErrorHtml;
    property numBits: Integer read Get_numBits;
    property OaepPadding: Integer read Get_OaepPadding write Set_OaepPadding;
    property EncodingMode: WideString read Get_EncodingMode write Set_EncodingMode;
    property Charset: WideString read Get_Charset write Set_Charset;
    property Version: WideString read Get_Version;
    property LittleEndian: Integer read Get_LittleEndian write Set_LittleEndian;
    property VerboseLogging: Integer read Get_VerboseLogging write Set_VerboseLogging;
    property NoUnpad: Integer read Get_NoUnpad write Set_NoUnpad;
  end;

// *********************************************************************//
// DispIntf:  IChilkatRsaDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {133C8E30-1538-4832-BD58-C8B3CF6096F8}
// *********************************************************************//
  IChilkatRsaDisp = dispinterface
    ['{133C8E30-1538-4832-BD58-C8B3CF6096F8}']
    function UnlockComponent(const unlockCode: WideString): Integer; dispid 1;
    property LastErrorText: WideString readonly dispid 2;
    property LastErrorXml: WideString readonly dispid 3;
    property LastErrorHtml: WideString readonly dispid 4;
    function GenerateKey(numBits: Integer): Integer; dispid 5;
    function ExportPublicKey: WideString; dispid 6;
    function ExportPrivateKey: WideString; dispid 7;
    function ImportPublicKey(const xml: WideString): Integer; dispid 8;
    function ImportPrivateKey(const xml: WideString): Integer; dispid 9;
    function SnkToXml(const filename: WideString): WideString; dispid 10;
    property numBits: Integer readonly dispid 11;
    property OaepPadding: Integer dispid 12;
    function EncryptBytes(inData: OleVariant; usePrivateKey: Integer): OleVariant; dispid 13;
    function DecryptBytes(inData: OleVariant; usePrivateKey: Integer): OleVariant; dispid 14;
    function DecryptStringENC(const inStr: WideString; usePrivateKey: Integer): WideString; dispid 15;
    function DecryptString(inData: OleVariant; usePrivateKey: Integer): WideString; dispid 16;
    function DecryptBytesENC(const inStr: WideString; usePrivateKey: Integer): OleVariant; dispid 17;
    function EncryptStringENC(const inStr: WideString; usePrivateKey: Integer): WideString; dispid 18;
    function EncryptBytesENC(inData: OleVariant; usePrivateKey: Integer): WideString; dispid 19;
    function EncryptString(const inStr: WideString; usePrivateKey: Integer): OleVariant; dispid 20;
    property EncodingMode: WideString dispid 21;
    property Charset: WideString dispid 22;
    property Version: WideString readonly dispid 23;
    function VerifyStringENC(const contentStr: WideString; const hashAlg: WideString; 
                             const sigStr: WideString): Integer; dispid 29;
    function VerifyString(const contentStr: WideString; const hashAlg: WideString; 
                          sigData: OleVariant): Integer; dispid 30;
    function VerifyBytesENC(contentBytes: OleVariant; const hashAlg: WideString; 
                            const sigStr: WideString): Integer; dispid 31;
    function VerifyBytes(contentBytes: OleVariant; const hashAlg: WideString; sigBytes: OleVariant): Integer; dispid 32;
    function SignStringENC(const contentStr: WideString; const hashAlg: WideString): WideString; dispid 34;
    function SignBytesENC(contentBytes: OleVariant; const hashAlg: WideString): WideString; dispid 35;
    function SignString(const contentStr: WideString; const hashAlg: WideString): OleVariant; dispid 36;
    function SignBytes(contentBytes: OleVariant; const hashAlg: WideString): OleVariant; dispid 37;
    property LittleEndian: Integer dispid 38;
    function SaveLastError(const logFilename: WideString): Integer; dispid 39;
    function OpenSslVerifyBytes(signature: OleVariant): OleVariant; dispid 40;
    function OpenSslSignBytes(data: OleVariant): OleVariant; dispid 41;
    function OpenSslSignBytesENC(data: OleVariant): WideString; dispid 42;
    function OpenSslSignString(const str: WideString): OleVariant; dispid 43;
    function OpenSslSignStringENC(const str: WideString): WideString; dispid 44;
    function OpenSslVerifyBytesENC(const str: WideString): OleVariant; dispid 45;
    function OpenSslVerifyString(data: OleVariant): WideString; dispid 46;
    function OpenSslVerifyStringENC(const str: WideString): WideString; dispid 47;
    function VerifyPrivateKey(const xml: WideString): Integer; dispid 48;
    function VerifyHash(hashBytes: OleVariant; const hashAlg: WideString; sigBytes: OleVariant): Integer; dispid 49;
    function VerifyHashENC(const encodedHash: WideString; const hashAlg: WideString; 
                           const encodedSig: WideString): Integer; dispid 50;
    function SignHash(hashBytes: OleVariant; const hashAlg: WideString): OleVariant; dispid 51;
    function SignHashENC(const encodedHash: WideString; const hashAlg: WideString): WideString; dispid 52;
    property VerboseLogging: Integer dispid 53;
    property NoUnpad: Integer dispid 54;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TChilkatRsa
// Help String      : Chilkat RSA
// Default Interface: IChilkatRsa
// Def. Intf. DISP? : No
// Event   Interface: _IChilkatRsaEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TChilkatRsa = class(TOleControl)
  private
    FIntf: IChilkatRsa;
    function  GetControlInterface: IChilkatRsa;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function UnlockComponent(const unlockCode: WideString): Integer;
    function GenerateKey(numBits: Integer): Integer;
    function ExportPublicKey: WideString;
    function ExportPrivateKey: WideString;
    function ImportPublicKey(const xml: WideString): Integer;
    function ImportPrivateKey(const xml: WideString): Integer;
    function SnkToXml(const filename: WideString): WideString;
    function EncryptBytes(inData: OleVariant; usePrivateKey: Integer): OleVariant;
    function DecryptBytes(inData: OleVariant; usePrivateKey: Integer): OleVariant;
    function DecryptStringENC(const inStr: WideString; usePrivateKey: Integer): WideString;
    function DecryptString(inData: OleVariant; usePrivateKey: Integer): WideString;
    function DecryptBytesENC(const inStr: WideString; usePrivateKey: Integer): OleVariant;
    function EncryptStringENC(const inStr: WideString; usePrivateKey: Integer): WideString;
    function EncryptBytesENC(inData: OleVariant; usePrivateKey: Integer): WideString;
    function EncryptString(const inStr: WideString; usePrivateKey: Integer): OleVariant;
    function VerifyStringENC(const contentStr: WideString; const hashAlg: WideString; 
                             const sigStr: WideString): Integer;
    function VerifyString(const contentStr: WideString; const hashAlg: WideString; 
                          sigData: OleVariant): Integer;
    function VerifyBytesENC(contentBytes: OleVariant; const hashAlg: WideString; 
                            const sigStr: WideString): Integer;
    function VerifyBytes(contentBytes: OleVariant; const hashAlg: WideString; sigBytes: OleVariant): Integer;
    function SignStringENC(const contentStr: WideString; const hashAlg: WideString): WideString;
    function SignBytesENC(contentBytes: OleVariant; const hashAlg: WideString): WideString;
    function SignString(const contentStr: WideString; const hashAlg: WideString): OleVariant;
    function SignBytes(contentBytes: OleVariant; const hashAlg: WideString): OleVariant;
    function SaveLastError(const logFilename: WideString): Integer;
    function OpenSslVerifyBytes(signature: OleVariant): OleVariant;
    function OpenSslSignBytes(data: OleVariant): OleVariant;
    function OpenSslSignBytesENC(data: OleVariant): WideString;
    function OpenSslSignString(const str: WideString): OleVariant;
    function OpenSslSignStringENC(const str: WideString): WideString;
    function OpenSslVerifyBytesENC(const str: WideString): OleVariant;
    function OpenSslVerifyString(data: OleVariant): WideString;
    function OpenSslVerifyStringENC(const str: WideString): WideString;
    function VerifyPrivateKey(const xml: WideString): Integer;
    function VerifyHash(hashBytes: OleVariant; const hashAlg: WideString; sigBytes: OleVariant): Integer;
    function VerifyHashENC(const encodedHash: WideString; const hashAlg: WideString; 
                           const encodedSig: WideString): Integer;
    function SignHash(hashBytes: OleVariant; const hashAlg: WideString): OleVariant;
    function SignHashENC(const encodedHash: WideString; const hashAlg: WideString): WideString;
    property  ControlInterface: IChilkatRsa read GetControlInterface;
    property  DefaultInterface: IChilkatRsa read GetControlInterface;
    property LastErrorText: WideString index 2 read GetWideStringProp;
    property LastErrorXml: WideString index 3 read GetWideStringProp;
    property LastErrorHtml: WideString index 4 read GetWideStringProp;
    property numBits: Integer index 11 read GetIntegerProp;
    property Version: WideString index 23 read GetWideStringProp;
  published
    property Anchors;
    property OaepPadding: Integer index 12 read GetIntegerProp write SetIntegerProp stored False;
    property EncodingMode: WideString index 21 read GetWideStringProp write SetWideStringProp stored False;
    property Charset: WideString index 22 read GetWideStringProp write SetWideStringProp stored False;
    property LittleEndian: Integer index 38 read GetIntegerProp write SetIntegerProp stored False;
    property VerboseLogging: Integer index 53 read GetIntegerProp write SetIntegerProp stored False;
    property NoUnpad: Integer index 54 read GetIntegerProp write SetIntegerProp stored False;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses System.Win.ComObj;

procedure TChilkatRsa.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID:      '{52C7AE02-787B-44F6-AC4B-AE690171AA58}';
    EventIID:     '';
    EventCount:   0;
    EventDispIDs: nil;
    LicenseKey:   nil (*HR:$80004002*);
    Flags:        $00000000;
    Version:      500);
begin
  ControlData := @CControlData;
end;

procedure TChilkatRsa.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IChilkatRsa;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TChilkatRsa.GetControlInterface: IChilkatRsa;
begin
  CreateControl;
  Result := FIntf;
end;

function TChilkatRsa.UnlockComponent(const unlockCode: WideString): Integer;
begin
  Result := DefaultInterface.UnlockComponent(unlockCode);
end;

function TChilkatRsa.GenerateKey(numBits: Integer): Integer;
begin
  Result := DefaultInterface.GenerateKey(numBits);
end;

function TChilkatRsa.ExportPublicKey: WideString;
begin
  Result := DefaultInterface.ExportPublicKey;
end;

function TChilkatRsa.ExportPrivateKey: WideString;
begin
  Result := DefaultInterface.ExportPrivateKey;
end;

function TChilkatRsa.ImportPublicKey(const xml: WideString): Integer;
begin
  Result := DefaultInterface.ImportPublicKey(xml);
end;

function TChilkatRsa.ImportPrivateKey(const xml: WideString): Integer;
begin
  Result := DefaultInterface.ImportPrivateKey(xml);
end;

function TChilkatRsa.SnkToXml(const filename: WideString): WideString;
begin
  Result := DefaultInterface.SnkToXml(filename);
end;

function TChilkatRsa.EncryptBytes(inData: OleVariant; usePrivateKey: Integer): OleVariant;
begin
  Result := DefaultInterface.EncryptBytes(inData, usePrivateKey);
end;

function TChilkatRsa.DecryptBytes(inData: OleVariant; usePrivateKey: Integer): OleVariant;
begin
  Result := DefaultInterface.DecryptBytes(inData, usePrivateKey);
end;

function TChilkatRsa.DecryptStringENC(const inStr: WideString; usePrivateKey: Integer): WideString;
begin
  Result := DefaultInterface.DecryptStringENC(inStr, usePrivateKey);
end;

function TChilkatRsa.DecryptString(inData: OleVariant; usePrivateKey: Integer): WideString;
begin
  Result := DefaultInterface.DecryptString(inData, usePrivateKey);
end;

function TChilkatRsa.DecryptBytesENC(const inStr: WideString; usePrivateKey: Integer): OleVariant;
begin
  Result := DefaultInterface.DecryptBytesENC(inStr, usePrivateKey);
end;

function TChilkatRsa.EncryptStringENC(const inStr: WideString; usePrivateKey: Integer): WideString;
begin
  Result := DefaultInterface.EncryptStringENC(inStr, usePrivateKey);
end;

function TChilkatRsa.EncryptBytesENC(inData: OleVariant; usePrivateKey: Integer): WideString;
begin
  Result := DefaultInterface.EncryptBytesENC(inData, usePrivateKey);
end;

function TChilkatRsa.EncryptString(const inStr: WideString; usePrivateKey: Integer): OleVariant;
begin
  Result := DefaultInterface.EncryptString(inStr, usePrivateKey);
end;

function TChilkatRsa.VerifyStringENC(const contentStr: WideString; const hashAlg: WideString; 
                                     const sigStr: WideString): Integer;
begin
  Result := DefaultInterface.VerifyStringENC(contentStr, hashAlg, sigStr);
end;

function TChilkatRsa.VerifyString(const contentStr: WideString; const hashAlg: WideString; 
                                  sigData: OleVariant): Integer;
begin
  Result := DefaultInterface.VerifyString(contentStr, hashAlg, sigData);
end;

function TChilkatRsa.VerifyBytesENC(contentBytes: OleVariant; const hashAlg: WideString; 
                                    const sigStr: WideString): Integer;
begin
  Result := DefaultInterface.VerifyBytesENC(contentBytes, hashAlg, sigStr);
end;

function TChilkatRsa.VerifyBytes(contentBytes: OleVariant; const hashAlg: WideString; 
                                 sigBytes: OleVariant): Integer;
begin
  Result := DefaultInterface.VerifyBytes(contentBytes, hashAlg, sigBytes);
end;

function TChilkatRsa.SignStringENC(const contentStr: WideString; const hashAlg: WideString): WideString;
begin
  Result := DefaultInterface.SignStringENC(contentStr, hashAlg);
end;

function TChilkatRsa.SignBytesENC(contentBytes: OleVariant; const hashAlg: WideString): WideString;
begin
  Result := DefaultInterface.SignBytesENC(contentBytes, hashAlg);
end;

function TChilkatRsa.SignString(const contentStr: WideString; const hashAlg: WideString): OleVariant;
begin
  Result := DefaultInterface.SignString(contentStr, hashAlg);
end;

function TChilkatRsa.SignBytes(contentBytes: OleVariant; const hashAlg: WideString): OleVariant;
begin
  Result := DefaultInterface.SignBytes(contentBytes, hashAlg);
end;

function TChilkatRsa.SaveLastError(const logFilename: WideString): Integer;
begin
  Result := DefaultInterface.SaveLastError(logFilename);
end;

function TChilkatRsa.OpenSslVerifyBytes(signature: OleVariant): OleVariant;
begin
  Result := DefaultInterface.OpenSslVerifyBytes(signature);
end;

function TChilkatRsa.OpenSslSignBytes(data: OleVariant): OleVariant;
begin
  Result := DefaultInterface.OpenSslSignBytes(data);
end;

function TChilkatRsa.OpenSslSignBytesENC(data: OleVariant): WideString;
begin
  Result := DefaultInterface.OpenSslSignBytesENC(data);
end;

function TChilkatRsa.OpenSslSignString(const str: WideString): OleVariant;
begin
  Result := DefaultInterface.OpenSslSignString(str);
end;

function TChilkatRsa.OpenSslSignStringENC(const str: WideString): WideString;
begin
  Result := DefaultInterface.OpenSslSignStringENC(str);
end;

function TChilkatRsa.OpenSslVerifyBytesENC(const str: WideString): OleVariant;
begin
  Result := DefaultInterface.OpenSslVerifyBytesENC(str);
end;

function TChilkatRsa.OpenSslVerifyString(data: OleVariant): WideString;
begin
  Result := DefaultInterface.OpenSslVerifyString(data);
end;

function TChilkatRsa.OpenSslVerifyStringENC(const str: WideString): WideString;
begin
  Result := DefaultInterface.OpenSslVerifyStringENC(str);
end;

function TChilkatRsa.VerifyPrivateKey(const xml: WideString): Integer;
begin
  Result := DefaultInterface.VerifyPrivateKey(xml);
end;

function TChilkatRsa.VerifyHash(hashBytes: OleVariant; const hashAlg: WideString; 
                                sigBytes: OleVariant): Integer;
begin
  Result := DefaultInterface.VerifyHash(hashBytes, hashAlg, sigBytes);
end;

function TChilkatRsa.VerifyHashENC(const encodedHash: WideString; const hashAlg: WideString; 
                                   const encodedSig: WideString): Integer;
begin
  Result := DefaultInterface.VerifyHashENC(encodedHash, hashAlg, encodedSig);
end;

function TChilkatRsa.SignHash(hashBytes: OleVariant; const hashAlg: WideString): OleVariant;
begin
  Result := DefaultInterface.SignHash(hashBytes, hashAlg);
end;

function TChilkatRsa.SignHashENC(const encodedHash: WideString; const hashAlg: WideString): WideString;
begin
  Result := DefaultInterface.SignHashENC(encodedHash, hashAlg);
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TChilkatRsa]);
end;

end.
