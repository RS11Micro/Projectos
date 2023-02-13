unit FntUtilGrelha;

interface

Uses FntBEEntidadeBase, SBBEListaObjAbs, Contnrs, SysUtils, AdvGrid, StrUtils,
     Math, Graphics;

  Type
    TCoresNiveis = array [0..10] of string;

  Type TTreeNo = Class(TFntBEEntidadeBase)

  Public
    ID_Chave,
    ID_ChavePai: String;

    Descricao: String;
    Check: Boolean;
    Nivel: Integer;
    Coluna,
    Linha: Integer;
  End;

  Type TTreeNos = Class(TSBBEListaObjAbs)

  private
    function GetTreeNoIdx(i: LongInt): TTreeNo;
		function GetTreeNo(pLinha, pColuna: Integer): TTreeNo;
    function GetTreeNoChave(pID_Chave: String; pNivel: Integer): TTreeNo;

	public
    procedure Adiciona(pTreeNo: TTreeNO);
    procedure Remove(pNome: String);

    property Elem[i: LongInt]: TTreeNo read GetTreeNoIdx;
    property TreeNo[pLinha, pColuna: Integer]: TTreeNo read GetTreeNo;
    property TreeNoChave[pID_Chave: String; pNivel: Integer]: TTreeNo read GetTreeNoChave;
  End;

  Type TArvore = Class

  Private
    FPai : TArvore;
    FTexto,
    FChave : String;
    FCheck: Boolean;
    FCol: Integer;
    FPos: Integer;
    FColTexto: Integer;

    FFilhos : TObjectList;

    Cores: TCoresNiveis;

    function GetNo(pIndex: Integer): TArvore;
    function GetNo_1(pCol, pPos: Integer): TArvore;
    function GetNo_Pos(pPos: Integer): TArvore;
    Function GetNo_Chave(pChave: String): TArvore;
    Function NumFilhosSeleccionados_1: Integer;
    Function DaCor: TColor;
    Function DaNumNiveis: Integer;

  Public
    constructor Create; Virtual;
    destructor Destroy; Override;

    function Add(pChave: String; pColCheck: Integer; pTexto : String = ''; pColTexto: Integer = 0) : TArvore;
    procedure Delete(pIndex : Integer);
    function IndexOf(pChave : String) : Integer;
    Function ExisteNo(pChave: String): Boolean;
    Function NumFilhos: Integer;
    Function NumFilhosSeleccionados: Integer;
    Function NumFilhosNivel: Integer;
    Function NumFilhosNivelSeleccionados: Integer;
    procedure ActualizaFilhos;
    procedure RemoveSelecaoFilhos;
    procedure ActualizaPai;
    procedure RemoveSeleccaoPai;
    Function Imprimir: String;
    Procedure AlteraEstadoTodos(pEstado: Boolean);
    Procedure AlteraEstadoNos(pEstado: Boolean);    
    Procedure InverteSeleccao;

    Property Pai: TArvore Read FPai Write FPai;
    Property Texto: String Read FTexto Write FTexto;
    Property Chave: String Read FChave Write FChave;
    Property Check: Boolean Read FCheck Write FCheck;
    Property Col: Integer Read FCol Write FCol;
    Property Pos: Integer Read FPos Write FPos;
    Property ColTexto: Integer Read FColTexto Write FColTexto;

    Property Filhos: TObjectList Read FFilhos Write FFilhos;

    Property Node[pIndex : Integer] : TArvore Read GetNo;
    Property Node_1[pCol, pPos : integer] : TArvore Read GetNo_1;
    Property Node_Pos[pPos : integer] : TArvore Read GetNo_Pos;
    Property Node_Chave[pChave : String] : TArvore Read GetNo_Chave;
  End;


type
  TDadoNO = Class(TFntBEEntidadeBase)

  Public
    Nome: String;
    Posicao: Integer;
    NumFilhos: Integer;
    Descricao: String;
    Tipo: String;
    Valor,
    Valor1,
    Valor2: Extended;
  End;

 type TDadosNos = Class(TSBBEListaObjAbs)
  private
    function GetDadoIdx(i: LongInt): TDadoNO;
		function GetDado(pNome: String): TDadoNO;

	public
    procedure Adiciona(pDado: TDadoNO);
    procedure Remove(pNome: String);

    property Elem[i: LongInt]: TDadoNo read GetDadoIdx;
    property dado[pNome: String]: TDadoNo read GetDado;
  End;


  Function IncrementaNos(pNome: String; pPosicoes: Integer; var pDadosNos: TDadosNos):integer; overload;
  Function IncrementaNos(pNome: String; pPosicoes: Integer; pValor: Extended; var pDadosNos: TDadosNos):integer;overload;
  Procedure IncrementaNos(pNome: String; pPosicoes: Integer; pValor,pValor1,pValor2: Extended; var pDadosNos: TDadosNos); overload;
  Function ExisteNo(pNome: String; pDadosNos: TDadosNos): Boolean;

  Function PreencheGrelha(Var pArv: TArvore; pGrelha: TAdvStringGrid; pPos: Integer; pColCheck: Integer = 0; pUsaCores: Boolean = False): Integer;
  Procedure ActualizaChecks(Var pArv: TArvore; pGrelha: TAdvStringGrid; pUsaCores: Boolean = False);

  Procedure ListaDeNos(pNome: String; pPosicao: Integer; pDescricao, pTipo: string; var pDadosNos: TDadosNos);

implementation

Function TArvore.NumFilhosSeleccionados_1: Integer;
Var
  i, j : Integer;
Begin
  i := 0;
  Result := IfThen(Check, 1, 0);

  While (i < Filhos.Count) Do
  Begin
    Result := Result + IfThen(Node[i].Check, 1, 0);

    j:=0;
    While (j < Node[i].Filhos.Count) Do
    Begin
      Result := Result + Node[i].Node[j].NumFilhosSeleccionados_1;
      Inc(j);
    End;

    Inc(i);
  End;
End;

Function TArvore.DaCor: TColor;
Var
  NumNiveis: Integer;
Begin
  NumNiveis := Self.DaNumNiveis - 1;

  Case NumNiveis Of
    0: Result := StringToColor(Self.Cores[0]);
    1: Result := StringToColor(Self.Cores[1]);
    2: Result := StringToColor(Self.Cores[2]);
    3: Result := StringToColor(Self.Cores[3]);
  End;
End;

Function TArvore.DaNumNiveis: Integer;
Var
  i, NNiveis: Integer;
Begin
  i := 0;
  NNiveis := 0;
  Result := 0;

  If Filhos.Count > 0 Then
  Begin
    Inc(Result);

    While (i < Filhos.Count) Do
    Begin
      NNiveis := Max(NNiveis, Node[i].DaNumNiveis);
      Inc(i);
    End;

    Result := NNiveis + 1;
  End;
End;

function TArvore.Add(pChave: String; pColCheck: Integer; pTexto : String = ''; pColTexto: Integer = 0) : TArvore;
var
  Arvore_Nova : TArvore;
begin
  Arvore_Nova := TArvore.Create;
  Arvore_Nova.Chave := pChave;
  Arvore_Nova.Texto := pTexto;
  Arvore_Nova.Pai := Self;
  Arvore_Nova.Col := pColCheck;
  Arvore_Nova.ColTexto := pColTexto;

  Filhos.Add(Arvore_Nova);
  Result := Arvore_Nova;
end;

constructor TArvore.Create;
begin
  FFilhos := TObjectList.Create;

  Cores[0] := ColorToString(clWindow);
  Cores[1] := ColorToString(clInfoBk);
  Cores[2] := ColorToString(clMoneyGreen);
  Cores[3] := ColorToString($00B0B5FD);
end;

Function TArvore.NumFilhos: Integer;
Var
  i : integer;
Begin
  i := 0;
  Result := Filhos.Count;

  While (i < Filhos.Count) Do
  Begin
    Result := Result + Node[i].NumFilhos;
    Inc(i);
  End;
End;

Function TArvore.NumFilhosSeleccionados: Integer;
Begin
  Result := Self.NumFilhosSeleccionados_1 - 1;
End;

Function TArvore.NumFilhosNivelSeleccionados: Integer;
Var
  i : Integer;
Begin
  i := 0;
  Result := 0;

  While (i < Filhos.Count) Do
  Begin
    Result := Result + IfThen(Node[i].Check, 1, 0);
    Inc(i);
  End;
End;

Function TArvore.NumFilhosNivel: Integer;
begin
  Result := Filhos.Count;
End;

procedure TArvore.Delete(pIndex: integer);
begin
  Filhos.Delete(pIndex);
end;

procedure TArvore.ActualizaFilhos;
Var
  i, j: Integer;
  Estado: Boolean;
Begin
  i := 0;
  Estado := FCheck;

  While (i < Filhos.Count) Do
  Begin
    Node[i].Check := Estado;

    j:=0;
    While (j < Node[i].Filhos.Count) Do
    Begin
      Node[i].Node[j].Check := Estado;
      Node[i].Node[j].ActualizaFilhos;
      Inc(j);
    End;

    Inc(i);
  End;
End;

procedure TArvore.RemoveSelecaoFilhos;
Var
  i, j: Integer;
  Estado: Boolean;
Begin
  i := 0;
  Estado := FCheck;

  While (i < Filhos.Count) Do
  Begin
    If Estado then
    begin
    Node[i].Check := not(Estado);

    j:=0;
    While (j < Node[i].Filhos.Count) Do
    Begin
      Node[i].Node[j].Check := Estado;
      Node[i].Node[j].ActualizaFilhos;
      Inc(j);
    End;
    end;

    Inc(i);
  End;
End;


Procedure TArvore.AlteraEstadoTodos(pEstado: Boolean);
Var
  i, j: Integer;
Begin
  i := 0;
  Check := pEstado;

  While (i < Filhos.Count) Do
  Begin
    Node[i].Check := pEstado;

    j:=0;
    While (j < Node[i].Filhos.Count) Do
    Begin
      Node[i].Node[j].AlteraEstadoTodos(pEstado);
      Inc(j);
    End;

    inc(i);
  End;
End;

Procedure TArvore.InverteSeleccao;
Var
  i, j: Integer;
Begin
  i := 0;

  If Filhos.Count = 0 Then
  Begin
    Check := Not Check;

    If Assigned(Self.Pai) Then
      Self.ActualizaPai;
      
  End
  Else
  Begin
    While (i < Filhos.Count) Do
    Begin
      Node[i].InverteSeleccao;
      inc(i);
    End;
  End;
End;

procedure TArvore.ActualizaPai;
Var
  No: TArvore;
  i, j: Integer;
  Estado: Boolean;
Begin
  i := 0;
  No := Pai;
  Estado := False;

  If Assigned(No) Then
  Begin
    While (i < No.Filhos.Count) And Not Estado Do
    Begin
      Estado := No.Node[i].Check;
      inc(i);
    End;

    No.Check := Estado;

    If Assigned(No.Pai) Then
      No.ActualizaPai;
      
  End;
End;

procedure TArvore.RemoveSeleccaoPai;
Var
  No: TArvore;
  i, j: Integer;
  Estado: Boolean;
Begin
  i := 0;
  No := Pai;
  Estado := False;

  If Assigned(No) Then
  Begin
    While (i < No.Filhos.Count) And Not Estado Do
    Begin
      Estado := No.Node[i].Check;
      inc(i);
    End;
    If  Estado then
    begin
      No.Check := Not(Estado);

      If Assigned(No.Pai) Then
        No.ActualizaPai;
    end;

  End;
End;

destructor TArvore.Destroy;
begin
  FreeAndNil(FFilhos);
  inherited;
end;

function TArvore.GetNo(pIndex: integer): TArvore;
Begin
  Result := Filhos[pIndex] as TArvore;
End;

function TArvore.GetNo_1(pCol, pPos: integer): TArvore;
Var
  Nodo: TArvore;
  i, j : Integer;
  Found : Boolean;
begin
  i := 0;
  Nodo := Nil;

  Found := (Col = pCol) And (Pos = pPos);
  If Found Then
    Nodo := Self;

  While Not Found And (i < Filhos.Count) Do
  Begin
    Found := (Node[i].Col = pCol) And (Node[i].Pos = pPos);

    If Found Then
      Nodo := Node[i];

    j := 0;
    While (j < Node[i].Filhos.Count) And Not Found Do
    Begin
      Nodo := Node[i].Node[j].GetNo_1(pCol, pPos);
      Found := (Nodo <> Nil);

      If Not Found Then
       Inc(j);

    End;

    If Not Found then
      Inc(i);

  End;

  Result := Nodo;
End;

function TArvore.GetNo_Pos(pPos: Integer): TArvore;
Var
  Nodo: TArvore;
  i, j : Integer;
  Found : Boolean;
begin
  i := 0;
  Nodo := Nil;

  //PARA EXCLUIR A RAIZ..
  Found := (Pos = pPos) And (Self.Chave <> '');

  If Found Then
    Nodo := Self;

  While Not Found And (i < Filhos.Count) Do
  Begin
    Found := (Node[i].Pos = pPos);

    If Found Then
      Nodo := Node[i];

    j := 0;
    While (j < Node[i].Filhos.Count) And Not Found Do
    Begin
      Nodo := Node[i].Node[j].GetNo_Pos(pPos);
      Found := (Nodo <> Nil);

      If Not Found Then
       Inc(j);

    End;

    If Not Found then
      Inc(i);

  End;

  Result := Nodo;
End;

Function TArvore.GetNo_Chave(pChave: String): TArvore;
Var
  i, j: Integer;
  Found : Boolean;
Begin
  i := 0;
  Result := Nil;
  Found := False;

  While Not Found And (i < Filhos.Count) Do
  Begin
    Found := Node[i].Chave = pChave;

    If Not Found Then
    Begin
      j:=0;

      While Not Assigned(Result) And (j < Node[i].Filhos.Count) Do
      Begin
        If Node[i].Node[j].Chave = pChave Then
          Result := Node[i].Node[j];

        If Not Assigned(Result) Then
          Result := Node[i].Node[j].GetNo_Chave(pChave);
          
        Inc(j);
      End;
    End;

    If Not Found Then
      Inc(i)
    Else
      Result := Node[i];
  End;
End;

function TArvore.IndexOf(pChave: String): Integer;
Var
  i : Integer;
  Found : Boolean;
Begin
  Result := -1;

  i := 0;
  Found := False;
  While Not Found And (i < Filhos.Count) Do
  Begin
    Found := Node[i].Chave = pChave;

    If Not Found Then
      Inc(i);

  End;

  If Found Then
    Result := i;

End;

procedure TDadosNos.Adiciona(pDado: TDadoNO);
begin
  Self.AdicionaObj(pDado);
end;

Function TDadosNos.GetDado(pNome: String): TDadoNO;
Var
  i: LongInt;
  Enc: Boolean;
  ObjDado : TDadoNO;
Begin
  i := 0;
  Enc := False;
  Result := Nil;

  While (Not Enc) And (i < Self.Num) Do
  Begin
    ObjDado := TDadoNO(Elemento[i]);

    If ObjDado.Nome = pNome Then
    Begin
      Enc := True;
      Result := ObjDado;
    End;

    Inc(i);
  End;
End;

procedure TDadosNos.Remove(pNome: String);
var
  i: LongInt;
  enc: Boolean;
  ObjDado: TDadoNO;
begin
  i := 0;
  enc := false;

  while (not enc) and (i < Num) do
  begin
    ObjDado := TDadoNO(Elemento[i]);

    if ObjDado.Nome = pNome then
    begin
      enc := true;
      RemoveObj(i);
    end;

    Inc(i);
  end;
end;

function TDadosNos.GetDadoIdx(i: LongInt): TDadoNo;
begin
  If i < Self.Num  Then
  Begin
    result := TDadoNO(self.Elemento[i]);
  End
  Else
  Begin
    result := nil;
  End;
end;


Function ExisteNo(pNome: String; pDadosNos: TDadosNos): Boolean;
var
  Dado: TDadoNO;
Begin
  Dado := pDadosNos.dado[pNome];
  Result := Assigned(Dado);
End;

Function TArvore.ExisteNo(pChave: String): Boolean;
Var
  i, j: Integer;
  Found: Boolean;
Begin
  i := 0;
  Result := False;

  While Not Result And (i < Filhos.Count) Do
  Begin
    Result := Node[i].Chave = pChave;

    If Not Result Then
    Begin
      j:=0;

      While Not Result And (j < Node[i].Filhos.Count) Do
      Begin
        Result := Node[i].Node[j].Chave = pChave;

        If Not Result Then
          Result := Node[i].Node[j].ExisteNo(pChave);

        Inc(j);
      End;
    End;

    inc(i);
  End;
End;

Function TArvore.Imprimir: String;
Var
  i, j: Integer;
Begin
  I := 0;
  Result := Texto + '(' + IntToStr(Pos) + ')';

  while (I < Filhos.Count) do
  begin
    Result := Result + ' ' + Node[I].Texto+ '(' + IntToStr(Node[I].Pos) + ')';

    j:=0;
    While (j < Node[i].Filhos.Count) Do
    Begin
      Result := Result + ' ' + Node[i].Node[j].Imprimir;
      Inc(j);
    End;

    inc(I);
  end;
End;

procedure TTreeNos.Adiciona(pTreeNo: TTreeNo);
begin
  Self.AdicionaObj(pTreeNo);
end;

function TTreeNos.GetTreeNo(pLinha, pColuna: Integer): TTreeNo;
var
  i: LongInt;
  enc: Boolean;
  ObjDado : TTreeNo;
begin
  i := 0;
  enc := false;
  result := nil;

  while (not enc) and (i<self.Num) do
  begin
    ObjDado := TTreeNo(Elemento[i]);

    if (ObjDado.Linha = pLinha) And (ObjDado.Coluna = pColuna) then
    begin
      enc := true;
      result := ObjDado;
    end;

    Inc(i);
  end;
end;

function TTreeNos.GetTreeNoChave(pID_Chave: String; pNivel: Integer): TTreeNo;
var
  i: LongInt;
  enc: Boolean;
  ObjDado : TTreeNo;
begin
  i := 0;
  enc := false;
  result := nil;

  while (not enc) and (i<self.Num) do
  begin
    ObjDado := TTreeNo(Elemento[i]);

    if (ObjDado.ID_Chave = pID_Chave) And (ObjDado.Nivel = pNivel) then
    begin
      enc := true;
      result := ObjDado;
    end;

    Inc(i);
  end;
end;

procedure TTreeNos.Remove(pNome: String);
var
  i: LongInt;
  enc: Boolean;
  ObjDado: TTreeNo;
begin
  i := 0;
  enc := false;

  while (not enc) and (i < Num) do
  begin
    ObjDado := TTreeNo(Elemento[i]);

    if ObjDado.Descricao = pNome then
    begin
      enc := true;
      RemoveObj(i);
    end;

    Inc(i);
  end;
end;

function TTreeNos.GetTreeNoIdx(i: LongInt): TTreeNo;
begin
  If i < Self.Num  Then
  Begin
    result := TTreeNo(self.Elemento[i]);
  End
  Else
  Begin
    result := nil;
  End;
end;

Function IncrementaNos(pNome: String; pPosicoes: Integer; pValor: Extended; var pDadosNos: TDadosNos):integer;
var
  Dado:TDadoNO;
Begin
  Dado:=pDadosNos.dado[pNome];
  If Assigned(Dado) then
  begin
    Dado.NumFilhos:=Dado.NumFilhos+1;
    Dado.valor:=Dado.valor+pValor;

  end
  Else
  Begin
    Dado:=TDadoNo.Create;
    Dado.Nome:=pNome;
    Dado.Posicao:=pPosicoes;
    Dado.NumFilhos:=1;
    Dado.valor:= pValor;
    pDadosNos.Adiciona(Dado);
  end;
  Result:= Dado.posicao;
End;

Procedure IncrementaNos(pNome: String; pPosicoes: Integer; pValor,pValor1,pValor2: Extended; var pDadosNos: TDadosNos);
var
  Dado:TDadoNO;
Begin
  Dado:=pDadosNos.dado[pNome];
  If Assigned(Dado) then
  begin
    Dado.NumFilhos:=Dado.NumFilhos+1;
    Dado.valor:=Dado.valor+pValor;
    Dado.valor1:=Dado.valor1+pValor1;
    Dado.valor2:=Dado.valor2+pValor2;

  end
  Else
  Begin
    Dado:=TDadoNo.Create;
    Dado.Nome:=pNome;
    Dado.Posicao:=pPosicoes;
    Dado.NumFilhos:=1;
    Dado.valor:= pValor;
    Dado.valor1:= pValor1;
    Dado.valor2:= pValor2;
    pDadosNos.Adiciona(Dado);
  end;
End;


function IncrementaNos(pNome: String; pPosicoes: Integer; var pDadosNos: TDadosNos):integer;
var
  Dado: TDadoNO;
Begin
  Dado := pDadosNos.dado[pNome];

  If Assigned(Dado) Then
    Inc(Dado.NumFilhos)
  Else
  Begin
    Dado := TDadoNo.Create;

    Dado.Nome := pNome;
    Dado.Posicao := pPosicoes;
    Dado.NumFilhos := 1;
    pDadosNos.Adiciona(Dado);
 end;
 Result:=Dado.Posicao;
End;

Function PreencheGrelha(Var pArv: TArvore; pGrelha: TAdvStringGrid; pPos: Integer; pColCheck: Integer = 0; pUsaCores: Boolean = False): Integer;
Var
  Arv: TArvore;
  i, j, PosInicial, NumFilhos: Integer;
Begin
  With pGrelha Do
  Begin
    BeginUpdate;
    PosInicial := pPos;

    For i:=0 To pArv.NumFilhosNivel - 1 Do
    Begin
      RowCount := RowCount + 1;

      If pArv.Node[i].Texto <> '' Then
        AllCells[pArv.Node[i].ColTexto, pPos] := pArv.Node[i].Texto;
        
      pArv.Node[i].Pos := pPos;

      //PARA  QUANDO NAO ESPECIFIQUEI A COLUNA DAS CHECKS..
      If pArv.Node[i].Col < 0 Then
        pArv.Node[i].Col := pColCheck;

      //PARA QUANDO NÂO QUERO APRESENTAR NENHUMA CHECK..
      If pArv.Node[i].Col >= 0 Then
      Begin
        AddCheckBox(pArv.Node[i].Col, pPos, False, True);
        AllCells[pArv.Node[i].Col, pPos] := IfThen(pArv.Node[i].Check, '1', '0');
      End;
      
      If pArv.Node[i].NumFilhosNivel > 0 Then
      Begin
        j := pPos;
        Arv := pArv.Node[i];
        NumFilhos := (PreencheGrelha(Arv, pGrelha, pPos + 1, pColCheck, pUsaCores) - j);

        If NumFilhos > 0 Then
        Begin
          AddNode(pArv.Node[i].Pos, NumFilhos);
          PosInicial := PosInicial + NumFilhos;

          //ATRIBUIR UMA COR A LINHA..
          If pUsaCores Then
            RowColor[pArv.Node[i].Pos] := pArv.DaCor;

          If pUsaCores And (pArv.Node[i].NumFilhosSeleccionados = pArv.Node[i].NumFilhos) Then
            FontStyles[pArv.Node[i].ColTexto, pGrelha.DisplRowIndex(pArv.Node[i].Pos)] := [fsBold]
          Else
            FontStyles[pArv.Node[i].Col + 1, pGrelha.DisplRowIndex(pArv.Node[i].Pos)] := [];
        End;
      End;

      Inc(pPos, IfThen(pArv.Node[i].NumFilhos > 0, pArv.Node[i].NumFilhos + 1, 1));
    End;

    Result := pPos;
    RowCount := pPos;
    EndUpdate;
  End;
End;

Procedure ActualizaChecks(Var pArv: TArvore; pGrelha: TAdvStringGrid; pUsaCores: Boolean = False);
Var
  Arv: TArvore;
  i, j, PosInicial, NumFilhos: Integer;
Begin
  With pGrelha Do
  Begin
    BeginUpdate;

    For i:=0 To pArv.NumFilhosNivel - 1 Do
    Begin
      AllCells[pArv.Node[i].Col, pArv.Node[i].Pos] := IfThen(pArv.Node[i].Check, '1', '0');

      If pArv.Node[i].NumFilhosNivel > 0 Then
      Begin
        Arv := pArv.Node[i];
        ActualizaChecks(Arv, pGrelha, pUsaCores);

        If pUsaCores And (pArv.Node[i].NumFilhosSeleccionados = pArv.Node[i].NumFilhos) Then
          FontStyles[pArv.Node[i].ColTexto, pGrelha.DisplRowIndex(pArv.Node[i].Pos)] := [fsBold]
        Else
          FontStyles[pArv.Node[i].ColTexto, pGrelha.DisplRowIndex(pArv.Node[i].Pos)] := [];
      End;
    End;

    EndUpdate;
  End;
End;

Procedure TArvore.AlteraEstadoNos(pEstado: Boolean);
Var
  i, j: Integer;
Begin
  i := 0;
  Check := pEstado;

  While (i < Filhos.Count) Do
  Begin
    Node[i].Check := pEstado;


    inc(i);
  End;
End;

Procedure ListaDeNos(pNome: String; pPosicao: Integer; pDescricao, pTipo: string; var pDadosNos: TDadosNos);
var
  Dado:TDadoNO;
Begin
  Dado:=pDadosNos.dado[pNome];

  If Assigned(Dado) then
    Dado.NumFilhos := Dado.NumFilhos + 1
  Else
  Begin
    Dado := TDadoNo.Create;
    Dado.Nome := pNome;
    Dado.Posicao := pPosicao;
    Dado.NumFilhos := 1;
    Dado.Tipo := pTipo;

    If Length(pDescricao)>0 then
      Dado.Descricao := pDescricao;

    pDadosNos.Adiciona(Dado);
  End;
End;

end.
