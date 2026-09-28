unit uDmDados;

interface

uses
  System.SysUtils, System.Classes, Data.DBXFirebird, Data.FMTBcd, Data.DB,
  Datasnap.DBClient, Datasnap.Provider, Data.SqlExpr;

type
  TdmDados = class(TDataModule)
    SQLConnection1: TSQLConnection;
    qryVendas: TSQLQuery;
    qryVendasItens: TSQLQuery;
    dspVendas: TDataSetProvider;
    cdsVendas: TClientDataSet;
    dsLinkMestre: TDataSource;
    cdsVendasCOD_VENDA: TIntegerField;
    cdsVendasDATA_VENDA: TDateField;
    cdsVendasNOME_CLIENTE: TStringField;
    cdsVendasCEP: TStringField;
    cdsVendasLOGRADOURO: TStringField;
    cdsVendasNUMERO: TStringField;
    cdsVendasBAIRRO: TStringField;
    cdsVendasCIDADE: TStringField;
    cdsVendasESTADO: TStringField;
    cdsVendasVALOR_TOTAL: TFMTBCDField;
    cdsVendasqryVendasItens: TDataSetField;
    cdsVendasItens: TClientDataSet;
    dsVendas: TDataSource;
    dsVendasItens: TDataSource;
    qryProdutos: TSQLQuery;
    dspProdutos: TDataSetProvider;
    cdsProdutos: TClientDataSet;
    dsProduto: TDataSource;
    cdsProdutosCOD_PRODUTO: TIntegerField;
    cdsProdutosDESCRICAO: TStringField;
    cdsProdutosPRECO: TFMTBCDField;
    cdsVendasItensCOD_ITEM: TIntegerField;
    cdsVendasItensCOD_VENDA: TIntegerField;
    cdsVendasItensCOD_PRODUTO: TIntegerField;
    cdsVendasItensQUANTIDADE: TFMTBCDField;
    cdsVendasItensPRECO_UNITARIO: TFMTBCDField;
    cdsVendasItensVALOR_TOTAL: TFMTBCDField;
    qryRelatorio: TSQLQuery;
    dspRelatorio: TDataSetProvider;
    cdsRelatorio: TClientDataSet;
    cdsRelatorioCOD_VENDA: TIntegerField;
    cdsRelatorioDATA_VENDA: TDateField;
    cdsRelatorioNOME_CLIENTE: TStringField;
    cdsRelatorioCEP: TStringField;
    cdsRelatorioLOGRADOURO: TStringField;
    cdsRelatorioNUMERO: TStringField;
    cdsRelatorioBAIRRO: TStringField;
    cdsRelatorioCIDADE: TStringField;
    cdsRelatorioESTADO: TStringField;
    cdsRelatorioVALOR_TOTAL: TFMTBCDField;
    dtsRelatorio: TDataSource;
    dsCarregaProdutos: TDataSource;
    qryAuxiliar: TSQLQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure cdsProdutosAfterInsert(DataSet: TDataSet);
    procedure dsProdutoStateChange(Sender: TObject);
    procedure dsVendasStateChange(Sender: TObject);
    procedure dsVendasItensStateChange(Sender: TObject);
    procedure cdsVendasItensAfterInsert(DataSet: TDataSet);
    procedure cdsVendasNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    function SalvarVenda: Boolean;
    procedure NovaVenda;
  end;

var
  dmDados: TdmDados;

implementation

uses
  uFrmCadastroProdutos,
  uFrmVendas;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TdmDados.cdsProdutosAfterInsert(DataSet: TDataSet);
begin
   DataSet.FieldByName('COD_PRODUTO').AsInteger := 0;
end;

procedure TdmDados.cdsVendasItensAfterInsert(DataSet: TDataSet);
begin
   DataSet.FieldByName('COD_ITEM').AsInteger := 0;
   DataSet.FieldByName('COD_VENDA').AsInteger := cdsVendas.FieldByName('COD_VENDA').AsInteger;
end;

procedure TdmDados.cdsVendasNewRecord(DataSet: TDataSet);
begin
   qryAuxiliar.Close;
   qryAuxiliar.SQL.Text := 'SELECT GEN_ID(GEN_VENDA_ID, 1) FROM RDB$DATABASE';
   qryAuxiliar.Open;

   DataSet.FieldByName('COD_VENDA').AsInteger := qryAuxiliar.Fields[0].AsInteger;

   DataSet.FieldByName('DATA_VENDA').AsDateTime := Date;
   DataSet.FieldByName('VALOR_TOTAL').AsFloat := 0;
end;

procedure TdmDados.DataModuleCreate(Sender: TObject);
begin
   SQLConnection1.Connected := True;
end;

procedure TdmDados.dsProdutoStateChange(Sender: TObject);
begin
   if Assigned(frmCadastroProdutos) then
      frmCadastroProdutos.ControlarInterface;
end;

procedure TdmDados.dsVendasItensStateChange(Sender: TObject);
begin
   if Assigned(frmVendas) then
      frmVendas.ControlarInterface;
end;

procedure TdmDados.dsVendasStateChange(Sender: TObject);
begin
   if Assigned(frmVendas) then
      frmVendas.ControlarInterface;
end;

procedure TdmDados.NovaVenda;
begin
   cdsVendas.Close;

   qryVendas.ParamByName('COD_VENDA').AsInteger := -1;
   cdsVendas.Open;

   cdsVendas.Append;
end;

function TdmDados.SalvarVenda: Boolean;
begin
   Result := False;
   if SQLConnection1.InTransaction then Exit;

   try
      if (cdsVendas.State in [dsEdit, dsInsert]) then
         cdsVendas.Post;

      if (cdsVendasItens.State in [dsEdit, dsInsert]) then
         cdsVendasItens.Post;

      if (cdsVendas.ChangeCount > 0) then
      begin
         cdsVendas.ApplyUpdates(0);
      end;
      Result := True;
   except
      on E: Exception do
      begin
         raise Exception.Create('Erro ao salvar venda: ' + E.Message);
      end;
   end;
end;

end.
