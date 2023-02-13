library DataHoraOnLine;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  System.SysUtils,
  System.Classes,
  IDSntp;

{$R *.res}



Function ObterDataHoraInternet(var pDataReal:TDateTime; var pHoraReal:Integer):integer;export ;stdcall;
var
  IDSntp: TIDSntp;
  pDataHora:TDatetime;
     Hora,min,sec,msec:Word;
begin
  IDSntp := TIDSntp.Create(nil);
  try
    IDSntp.Host := 'ntp04.oal.ul.pt';
    pDataHora := IDSntp.DateTime;
    pDataReal:=pDataHora;
    DecodeTime(pDataHora,Hora,min,sec,msec);
    pHoraReal:=Hora;
  finally
      result:=-1;
      IDSntp.Free;
  end;

end;

Function ObterDataHoraInternet1:Tdatetime;export ;stdcall;
var
  IDSntp: TIDSntp;
  pDataHora:TDatetime;
     Hora,min,sec,msec:Word;
begin
  IDSntp := TIDSntp.Create(nil);
  try
    IDSntp.Host := 'ntp04.oal.ul.pt';
    result:=IDSntp.DateTime;
  finally

      IDSntp.Free;
  end;

end;
 exports ObterDataHoraInternet1,ObterDataHoraInternet;
end.
