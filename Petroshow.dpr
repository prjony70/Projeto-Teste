program Petroshow;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {Principal},
  uDmDados in 'uDmDados.pas' {dmDados: TDataModule},
  uFrmCadastroProdutos in 'uFrmCadastroProdutos.pas' {frmCadastroProdutos},
  uFrmVendas in 'uFrmVendas.pas' {frmVendas},
  uFrmFiltroRelatorio in 'uFrmFiltroRelatorio.pas' {frmFiltroRelatorio};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmDados, dmDados);
  Application.CreateForm(TPrincipal, Principal);
  Application.Run;
end.
