unit uFrmCadastroProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Mask;

type
  TfrmCadastroProdutos = class(TForm)
    Panel1: TPanel;
    dbgProdutos: TDBGrid;
    Panel2: TPanel;
    btnNovo: TButton;
    btnAlterar: TButton;
    btnCancelar: TButton;
    btnGravar: TButton;
    btnExcluir: TButton;
    pnlCampos: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edCodigo: TDBEdit;
    edDescricao: TDBEdit;
    edPreco: TDBEdit;
    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    procedure ApenasNumerosEDecimais(Sender: TObject; var Key: Char);
  public
    { Public declarations }
    procedure ControlarInterface;
  end;

var
  frmCadastroProdutos: TfrmCadastroProdutos;

implementation

uses
  uDmDados;

{$R *.dfm}

procedure TfrmCadastroProdutos.ApenasNumerosEDecimais(Sender: TObject; var Key: Char);
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

procedure TfrmCadastroProdutos.btnAlterarClick(Sender: TObject);
begin
   if dmDados.cdsProdutos.IsEmpty then
   begin
      ShowMessage('Não há nenhum produto selecionado para alterar.');
      Exit;
   end;

   dmDados.cdsProdutos.Edit;
   edDescricao.SetFocus;
end;

procedure TfrmCadastroProdutos.btnCancelarClick(Sender: TObject);
begin
   if dmDados.cdsProdutos.State in [dsInsert, dsEdit] then
   begin
      dmDados.cdsProdutos.Cancel;
      ShowMessage('Operação cancelada.');
   end;
end;

procedure TfrmCadastroProdutos.btnExcluirClick(Sender: TObject);
begin
   if dmDados.cdsProdutos.IsEmpty then
   begin
      ShowMessage('Não há produtos cadastrados para excluir.');
      Exit;
   end;

   if MessageDlg('Deseja realmente excluir o produto selecionado?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
      try
         dmDados.cdsProdutos.Delete;

         if dmDados.cdsProdutos.ApplyUpdates(0) = 0 then
            ShowMessage('Produto excluído com sucesso!')
         else
            dmDados.cdsProdutos.CancelUpdates;
      except
         on E: Exception do
         begin
            dmDados.cdsProdutos.CancelUpdates;
            ShowMessage('Erro ao excluir produto. Ele pode estar associado a uma venda existente. Detalhes: ' + E.Message);
         end;
      end;
   end;
end;

procedure TfrmCadastroProdutos.btnGravarClick(Sender: TObject);
begin
   if Trim(dmDados.cdsProdutos.FieldByName('DESCRICAO').AsString) = '' then
   begin
      ShowMessage('A Descrição do produto é obrigatória!');
      edDescricao.SetFocus;
      Exit;
   end;

   if dmDados.cdsProdutos.FieldByName('PRECO').AsFloat <= 0 then
   begin
      ShowMessage('O Preço do produto deve ser maior que zero!');
      edPreco.SetFocus;
      Exit;
   end;

   if dmDados.cdsProdutos.State in [dsInsert, dsEdit] then
      dmDados.cdsProdutos.Post;

   if dmDados.cdsProdutos.ApplyUpdates(0) = 0 then
   begin
      dmDados.cdsProdutos.Refresh;
      ShowMessage('Produto gravado com sucesso!');
   end;
end;

procedure TfrmCadastroProdutos.btnNovoClick(Sender: TObject);
begin
   dmDados.cdsProdutos.Append;
   edDescricao.SetFocus;
end;

procedure TfrmCadastroProdutos.ControlarInterface;
var
   EmEdicao: Boolean;
begin
   EmEdicao := dmDados.cdsProdutos.State in [dsInsert, dsEdit];

   pnlCampos.Enabled := EmEdicao;

   btnNovo.Enabled     := not EmEdicao;
   btnAlterar.Enabled  := not EmEdicao;
   btnExcluir.Enabled  := not EmEdicao;

   btnGravar.Enabled   := EmEdicao;
   btnCancelar.Enabled := EmEdicao;

   dbgProdutos.Enabled := not EmEdicao;
end;

procedure TfrmCadastroProdutos.FormShow(Sender: TObject);
begin
   try
      dmDados.cdsProdutos.Close;
      dmDados.cdsProdutos.Open;

      ControlarInterface;
   except
      on E: Exception do
         ShowMessage('Erro ao abrir a tabela de produtos: ' + E.Message);
   end;
end;

end.
