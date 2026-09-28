unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Produtos1: TMenuItem;
    Relatrios1: TMenuItem;
    VendasporPerodo1: TMenuItem;
    Vendas1: TMenuItem;
    procedure Produtos1Click(Sender: TObject);
    procedure VendasporPerodo1Click(Sender: TObject);
    procedure Vendas1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Principal: TPrincipal;

implementation

{$R *.dfm}

uses uDmDados, uFrmCadastroProdutos, uFrmFiltroRelatorio, uFrmVendas;

procedure TPrincipal.Produtos1Click(Sender: TObject);
begin
   frmCadastroProdutos := TfrmCadastroProdutos.Create(Self);
   try
      frmCadastroProdutos.ShowModal;
   finally
      FreeAndNil(frmCadastroProdutos);
   end;
end;

procedure TPrincipal.Vendas1Click(Sender: TObject);
begin
   frmVendas := TfrmVendas.Create(Self);
   try
      frmVendas.ShowModal;
   finally
      FreeAndNil(frmVendas);
   end;
end;

procedure TPrincipal.VendasporPerodo1Click(Sender: TObject);
begin
   frmFiltroRelatorio := TfrmFiltroRelatorio.Create(Self);
   try
      frmFiltroRelatorio.ShowModal;
   finally
      FreeAndNil(frmFiltroRelatorio);
   end;
end;

end.
