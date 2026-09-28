unit uFrmFiltroRelatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, System.DateUtils,
  Winapi.ShellAPI, System.IOUtils, Vcl.Buttons;

type
  TfrmFiltroRelatorio = class(TForm)
    dtpInicio: TDateTimePicker;
    dtpFim: TDateTimePicker;
    btnVisualizar: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnVisualizarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFiltroRelatorio: TfrmFiltroRelatorio;

implementation

{$R *.dfm}

uses uDmDados;

procedure TfrmFiltroRelatorio.btnVisualizarClick(Sender: TObject);
var
   CaminhoArquivo, HTML: string;
   Linha: string;
begin
   dmDados.cdsRelatorio.Close;
   dmDados.qryRelatorio.ParamByName('DATA_INICIO').AsDateTime := dtpInicio.Date;
   dmDados.qryRelatorio.ParamByName('DATA_FIM').AsDateTime := dtpFim.Date;
   dmDados.cdsRelatorio.Open;

   if dmDados.cdsRelatorio.IsEmpty then
   begin
      ShowMessage('Nenhuma venda encontrada para o período selecionado.');
      Exit;
   end;


   HTML := '<html>' +
           '<head>' +
           '  <title>Relatório de Vendas</title>' +
           '  <style>' +
           '    body { font-family: Arial, sans-serif; margin: 30px; }' +
           '    h1 { text-align: center; color: #333; }' +
           '    h3 { text-align: center; color: #666; }' +
           '    table { width: 100%; border-collapse: collapse; margin-top: 20px; }' +
           '    th { background-color: #f2f2f2; color: #333; border: 1px solid #ddd; padding: 10px; text-align: left; }' +
           '    td { border: 1px solid #ddd; padding: 10px; }' +
           '    tr:nth-child(even) { background-color: #f9f9f9; }' +
           '    .total { font-weight: bold; font-size: 1.1em; background-color: #e2e2e2 !important; }' +
           '  </style>' +
           '</head>' +
           '<body>' +
           '  <h1>Petroshow - Relatório de Vendas</h1>' +
           '  <h3>Período de ' + DateToStr(dtpInicio.Date) + ' a ' + DateToStr(dtpFim.Date) + '</h3>' +
           '  <table>' +
           '    <tr>' +
           '      <th>Código Venda</th>' +
           '      <th>Data da Venda</th>' +
           '      <th>Nome do Cliente</th>' +
           '      <th>Cidade/UF</th>' +
           '      <th>Valor Total</th>' +
           '    </tr>';

   while not dmDados.cdsRelatorio.Eof do
   begin
      Linha := '<tr>' +
               '  <td>' + dmDados.cdsRelatorio.FieldByName('COD_VENDA').AsString + '</td>' +
               '  <td>' + DateToStr(dmDados.cdsRelatorio.FieldByName('DATA_VENDA').AsDateTime) + '</td>' +
               '  <td>' + dmDados.cdsRelatorio.FieldByName('NOME_CLIENTE').AsString + '</td>' +
               '  <td>' + dmDados.cdsRelatorio.FieldByName('CIDADE').AsString + '/' + dmDados.cdsRelatorio.FieldByName('ESTADO').AsString + '</td>' +
               '  <td>R$ ' + FormatFloat(',0.00', dmDados.cdsRelatorio.FieldByName('VALOR_TOTAL').AsFloat) + '</td>' +
               '</tr>';
      HTML := HTML + Linha;
      dmDados.cdsRelatorio.Next;
   end;

   HTML := HTML + '  </table>' +
                  '</body>' +
                  '</html>';

   CaminhoArquivo := TPath.Combine(TPath.GetTempPath, 'RelatorioVendas.html');
   TFile.WriteAllText(CaminhoArquivo, HTML);

   ShellExecute(0, 'open', PChar(CaminhoArquivo), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmFiltroRelatorio.FormShow(Sender: TObject);
begin
   dtpInicio.Date := StartOfTheMonth(Date);
   dtpFim.Date := Date;
end;

end.
