unit uFrmVendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, ACBrBase, ACBrSocket, ACBrCEP,
  Datasnap.DBClient;

type
  TfrmVendas = class(TForm)
    gpItens: TGroupBox;
    lcbProdutos: TDBLookupComboBox;
    Label8: TLabel;
    Label9: TLabel;
    edQuantidade: TDBEdit;
    gpClientes: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edNome_Cliente: TDBEdit;
    edLogradouro: TDBEdit;
    edBairro: TDBEdit;
    edNumero: TDBEdit;
    edCidade: TDBEdit;
    edEstado: TDBEdit;
    edCEP: TDBEdit;
    Panel1: TPanel;
    edPrecoUnit: TDBEdit;
    Label10: TLabel;
    btnIncluirItem: TButton;
    btnAlterarItem: TButton;
    btnExcluirItem: TButton;
    Panel2: TPanel;
    btnNovo: TButton;
    btnGravar: TButton;
    btnCancelar: TButton;
    btnAlterar: TButton;
    btnCancelarItem: TButton;
    ACBrCEP1: TACBrCEP;
    Label12: TLabel;
    edData: TDBEdit;
    Label13: TLabel;
    edCodigo: TDBEdit;
    btnExcluir: TButton;
    btnGravarItem: TButton;
    Label11: TLabel;
    dbgItemVenda: TDBGrid;
    Bevel2: TBevel;
    Bevel1: TBevel;
    edValorTotal: TDBEdit;
    procedure FormShow(Sender: TObject);
    procedure edCEPExit(Sender: TObject);
    procedure btnIncluirItemClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure lcbProdutosClick(Sender: TObject);
    procedure btnExcluirItemClick(Sender: TObject);
    procedure btnAlterarItemClick(Sender: TObject);
    procedure btnCancelarItemClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edNome_ClienteKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGravarItemClick(Sender: TObject);
  private
    { Private declarations }
    procedure LimparCamposItem;
    procedure AtualizarTotalVenda;
    procedure ApenasNumerosEDecimais(Sender: TObject; var Key: Char);
    procedure RecalcularTotalVenda;
  public
    { Public declarations }
    procedure ControlarInterface;
  end;

var
  frmVendas: TfrmVendas;

implementation

{$R *.dfm}

uses uDmDados;

procedure TfrmVendas.ApenasNumerosEDecimais(Sender: TObject; var Key: Char);
var
   SeparadorDecimal: Char;
begin
   SeparadorDecimal := FormatSettings.DecimalSeparator;

   if (Key = '.') or (Key = ',') then
      Key := SeparadorDecimal;

   if not (Key in ['0'..'9', #8, SeparadorDecimal]) then
   begin
      Key := #0;
      Exit;
   end;

   if (Key = SeparadorDecimal) and (Pos(SeparadorDecimal, TEdit(Sender).Text) > 0) then
   begin
      Key := #0;
   end;
end;

procedure TfrmVendas.AtualizarTotalVenda;
var
   vTotalAcumulado: Double;
   vClone: TClientDataSet;
begin
   vTotalAcumulado := 0;

   vClone := TClientDataSet.Create(nil);
   try
      vClone.CloneCursor(dmDados.cdsVendasItens, True);
      vClone.First;
      while not vClone.Eof do
      begin
         vTotalAcumulado := vTotalAcumulado + vClone.FieldByName('VALOR_TOTAL').AsFloat;
         vClone.Next;
      end;
    finally
       vClone.Free;
    end;

   if not (dmDados.cdsVendas.State in [dsEdit, dsInsert]) then
      dmDados.cdsVendas.Edit;

   dmDados.cdsVendas.FieldByName('VALOR_TOTAL').AsFloat := vTotalAcumulado;
end;

procedure TfrmVendas.btnAlterarClick(Sender: TObject);
begin
   if dmDados.cdsVendas.IsEmpty then
   begin
      ShowMessage('Não há nenhuma venda ativa para alterar.');
      Exit;
   end;

   if not (dmDados.cdsVendas.State in [dsEdit, dsInsert]) then
      dmDados.cdsVendas.Edit;

   edNome_Cliente.SetFocus;
end;

procedure TfrmVendas.btnAlterarItemClick(Sender: TObject);
begin
   if dmDados.cdsVendasItens.IsEmpty then
   begin
      ShowMessage('Nenhum item selecionado para alteração.');
      Exit;
   end;

   dmDados.cdsVendasItens.Edit;

   lcbProdutos.KeyValue := dmDados.cdsVendasItens.FieldByName('COD_PRODUTO').AsInteger;
   edQuantidade.Text    := FloatToStr(dmDados.cdsVendasItens.FieldByName('QUANTIDADE').AsFloat);
   edPrecoUnit.Text     := FormatFloat('0.00', dmDados.cdsVendasItens.FieldByName('PRECO_UNITARIO').AsFloat);

   lcbProdutos.SetFocus;
end;

procedure TfrmVendas.btnCancelarClick(Sender: TObject);
begin
   if MessageDlg('Deseja cancelar esta venda e perder todas as alterações?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
     if dmDados.cdsVendas.State in [dsInsert, dsEdit] then
        dmDados.cdsVendas.Cancel
     else
        dmDados.cdsVendas.CancelUpdates;

     edNome_Cliente.Text := '';
     edCEP.Clear;
     edLogradouro.Text   := '';
     edCidade.Text       := '';
     edEstado.Text       := '';
     edNumero.Text       := '';
     edBairro.Text       := '';

     LimparCamposItem;
     edCEP.Clear;

     ControlarInterface;
  end;
end;

procedure TfrmVendas.btnCancelarItemClick(Sender: TObject);
begin
   if dmDados.cdsVendasItens.State in [dsInsert, dsEdit] then
   begin
      dmDados.cdsVendasItens.Cancel;
      LimparCamposItem;
   end;
end;

procedure TfrmVendas.btnExcluirClick(Sender: TObject);
begin
   if dmDados.cdsVendas.IsEmpty then
   begin
      ShowMessage('Não há nenhuma venda ativa para excluir.');
      Exit;
   end;

   if MessageDlg('Deseja realmente EXCLUIR esta venda completa e TODOS os seus itens de forma definitiva?',
      mtWarning, [mbYes, mbNo], 0) = mrYes then
   begin
      try
         dmDados.cdsVendas.Delete;

         if dmDados.cdsVendas.ApplyUpdates(0) = 0 then
         begin
            ShowMessage('Venda e itens excluídos com sucesso!');

            dmDados.NovaVenda;
            LimparCamposItem;
            edCEP.Clear;
         end
         else
         begin
            dmDados.cdsVendas.CancelUpdates;
            ShowMessage('Erro ao tentar excluir a venda no banco de dados.');
         end;

         ControlarInterface;
      except
         on E: Exception do
         begin
            dmDados.cdsVendas.CancelUpdates;
            ShowMessage('Não foi possível realizar a exclusão. Detalhes: ' + E.Message);
         end;
      end;
  end;
end;

procedure TfrmVendas.btnExcluirItemClick(Sender: TObject);
begin
   if dmDados.cdsVendasItens.IsEmpty then
  begin
    ShowMessage('Não há nenhum item na lista para remover!');
    Exit;
  end;

  if MessageDlg('Deseja realmente remover o item selecionado?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dmDados.cdsVendasItens.Delete;
    RecalcularTotalVenda;
  end;
end;

procedure TfrmVendas.btnGravarClick(Sender: TObject);
begin
   if dmDados.cdsVendasItens.State in [dsInsert, dsEdit] then
      dmDados.cdsVendasItens.Post;

   if dmDados.cdsVendas.State in [dsInsert, dsEdit] then
      dmDados.cdsVendas.Post;

   if dmDados.cdsVendasItens.IsEmpty then
   begin
      ShowMessage('Não é possível gravar uma venda sem itens!');
      ControlarInterface;
      Exit;
   end;

   try
      if dmDados.cdsVendas.ApplyUpdates(0) = 0 then
      begin
         ShowMessage('Venda e itens gravados com sucesso!');

         edNome_Cliente.Text := '';
         edCEP.Text          := '';
         edLogradouro.Text   := '';
         edCidade.Text       := '';
         edEstado.Text       := '';
         LimparCamposItem;

         edValorTotal.Text := '0,00';

         dmDados.cdsVendasItens.Close;
         dmDados.cdsVendas.Close;

         ControlarInterface;
      end
      else
      begin
         ShowMessage('Erro interno ao aplicar atualizações no banco de dados.');
      end;
   except
       on E: Exception do
       begin
          ShowMessage('Erro crítico retornado pelo Banco de Dados: ' + E.Message);
       end;
   end;

end;

procedure TfrmVendas.btnGravarItemClick(Sender: TObject);
var
   vQtd, vPrecoUnit, vTotalItem: Double;
begin
   if lcbProdutos.KeyValue = Null then
   begin
      ShowMessage('Selecione um produto!');
      lcbProdutos.SetFocus;
      Exit;
   end;

   vQtd := StrToFloatDef(edQuantidade.Text, 0);
   if vQtd <= 0 then
   begin
      ShowMessage('A quantidade deve ser maior que zero!');
      edQuantidade.SetFocus;
      Exit;
   end;

   vPrecoUnit := StrToFloatDef(edPrecoUnit.Text, 0);
   if vPrecoUnit <= 0 then
   begin
      ShowMessage('O preço unitário deve ser maior que zero!');
      edPrecoUnit.SetFocus;
      Exit;
   end;

   vTotalItem := vQtd * vPrecoUnit;

   dmDados.cdsVendasItens.FieldByName('COD_PRODUTO').AsInteger := lcbProdutos.KeyValue;
   dmDados.cdsVendasItens.FieldByName('QUANTIDADE').AsFloat   := vQtd;
   dmDados.cdsVendasItens.FieldByName('PRECO_UNITARIO').AsFloat := vPrecoUnit;
   dmDados.cdsVendasItens.FieldByName('VALOR_TOTAL').AsFloat    := vTotalItem;

   dmDados.cdsVendasItens.Post;

   LimparCamposItem;

   RecalcularTotalVenda;

   btnIncluirItem.SetFocus;
end;

procedure TfrmVendas.btnIncluirItemClick(Sender: TObject);
begin
   LimparCamposItem;
   dmDados.cdsVendasItens.Append;
   lcbProdutos.SetFocus;
end;

procedure TfrmVendas.btnNovoClick(Sender: TObject);
begin
   dmDados.NovaVenda;
   LimparCamposItem;
   edCEP.Clear;
   edNome_Cliente.SetFocus;
end;

procedure TfrmVendas.ControlarInterface;
var
   VendaEmEdicao: Boolean;
   TemVendaAtiva: Boolean;
   TemItensNaVenda: Boolean;
   ClientePreenchido: Boolean;
   ItemEmEdicao: Boolean;
begin
   VendaEmEdicao     := dmDados.cdsVendas.State in [dsInsert, dsEdit];
   TemVendaAtiva     := not dmDados.cdsVendas.IsEmpty;
   TemItensNaVenda   := not dmDados.cdsVendasItens.IsEmpty;
   ItemEmEdicao      := dmDados.cdsVendasItens.State in [dsInsert, dsEdit];
   ClientePreenchido := Trim(edNome_Cliente.Text) <> '';

   gpClientes.Enabled := VendaEmEdicao and (not ItemEmEdicao);

   gpItens.Enabled    := VendaEmEdicao and ClientePreenchido;

   lcbProdutos.Enabled  := VendaEmEdicao and ItemEmEdicao;
   edQuantidade.Enabled := VendaEmEdicao and ItemEmEdicao;
   edPrecoUnit.Enabled  := VendaEmEdicao and ItemEmEdicao;
   edValorTotal.Enabled := VendaEmEdicao and ItemEmEdicao;

   btnIncluirItem.Enabled  := VendaEmEdicao and (not ItemEmEdicao);
   btnExcluirItem.Enabled  := VendaEmEdicao and TemItensNaVenda and (not ItemEmEdicao);
   btnAlterarItem.Enabled  := VendaEmEdicao and ItemEmEdicao;
   btnGravarItem.Enabled   := VendaEmEdicao and ItemEmEdicao;
   btnCancelarItem.Enabled := VendaEmEdicao and ItemEmEdicao;

   dbgItemVenda.Enabled := VendaEmEdicao and (not ItemEmEdicao);
   btnNovo.Enabled      := not VendaEmEdicao;
   btnAlterar.Enabled   := TemVendaAtiva and (not VendaEmEdicao);
   btnExcluir.Enabled   := TemVendaAtiva and (not VendaEmEdicao);
   btnGravar.Enabled    := VendaEmEdicao and (not ItemEmEdicao);
   btnCancelar.Enabled  := VendaEmEdicao and (not ItemEmEdicao);
end;

procedure TfrmVendas.edCEPExit(Sender: TObject);
var
   vCEP: string;
begin
   vCEP := Trim(dmDados.cdsVendas.FieldByName('CEP').AsString);

   vCEP := StringReplace(vCEP, '-', '', [rfReplaceAll]);
   vCEP := StringReplace(vCEP, '.', '', [rfReplaceAll]);
   vCEP := Trim(vCEP);

   if Length(vCEP) = 8 then
   begin
      try
         ACBrCEP1.WebService := wsViaCEP;
         ACBrCEP1.BuscarPorCEP(vCEP);

         if ACBrCEP1.Enderecos.Count > 0 then
         begin
            if not (dmDados.cdsVendas.State in [dsEdit, dsInsert]) then
               dmDados.cdsVendas.Edit;

            if ACBrCEP1.Enderecos.Count = 0 then


            dmDados.cdsVendas.FieldByName('CEP').AsString        := ACBrCEP1.Enderecos[0].CEP; // O Delphi já formata com a máscara na tela!
            dmDados.cdsVendas.FieldByName('LOGRADOURO').AsString := ACBrCEP1.Enderecos[0].Logradouro;
            dmDados.cdsVendas.FieldByName('BAIRRO').AsString     := ACBrCEP1.Enderecos[0].Bairro;
            dmDados.cdsVendas.FieldByName('CIDADE').AsString     := ACBrCEP1.Enderecos[0].Municipio;
            dmDados.cdsVendas.FieldByName('ESTADO').AsString     := ACBrCEP1.Enderecos[0].UF;

            edNumero.SetFocus;
         end
         else
            ShowMessage('CEP inexistente! Verifique o número digitado.');

      except
         on E: Exception do
         ShowMessage('Erro ao buscar o CEP: ' + E.Message);
      end;
   end;
end;

procedure TfrmVendas.edNome_ClienteKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   ControlarInterface;
end;

procedure TfrmVendas.FormShow(Sender: TObject);
begin
   dmDados.cdsProdutos.Open;
   dmDados.qryProdutos.Open;
   ControlarInterface;
end;

procedure TfrmVendas.lcbProdutosClick(Sender: TObject);
begin
   if lcbProdutos.KeyValue <> Null then
   begin
      if dmDados.cdsProdutos.Locate('COD_PRODUTO', lcbProdutos.KeyValue, []) then
      begin
         edPrecoUnit.Text := FormatFloat('0.00', dmDados.cdsProdutos.FieldByName('PRECO').AsFloat);
         edQuantidade.SetFocus;
      end;
   end;
end;

procedure TfrmVendas.LimparCamposItem;
begin
   lcbProdutos.KeyValue := Null;
   edQuantidade.Clear;
   edPrecoUnit.Clear;
   ControlarInterface;
end;

procedure TfrmVendas.RecalcularTotalVenda;
var
   SomaTotal: Double;
   BookMark: TBookmark;
begin
   SomaTotal := 0;

   dmDados.cdsVendasItens.DisableControls;
   try
      BookMark := dmDados.cdsVendasItens.GetBookmark;
      try
         dmDados.cdsVendasItens.First;

         while not dmDados.cdsVendasItens.Eof do
         begin
            SomaTotal := SomaTotal + dmDados.cdsVendasItens.FieldByName('VALOR_TOTAL').AsFloat;
            dmDados.cdsVendasItens.Next;
         end;
      finally
         if dmDados.cdsVendasItens.BookmarkValid(BookMark) then
            dmDados.cdsVendasItens.GotoBookmark(BookMark);

         dmDados.cdsVendasItens.FreeBookmark(BookMark);
      end;
   finally
      dmDados.cdsVendasItens.EnableControls;
   end;

   if not (dmDados.cdsVendas.State in [dsInsert, dsEdit]) then
      dmDados.cdsVendas.Edit;

   dmDados.cdsVendas.FieldByName('VALOR_TOTAL').AsFloat := SomaTotal;

   edValorTotal.Text := FormatFloat('#,##0.00', SomaTotal);
end;

end.
