class ContribuicaoMembroReport < PdfReport
  include ActionView::Helpers::NumberHelper

  TABLE_WIDTHS = [50, 390, 100]
  TABLE_HEADERS = [["Data", "Descrição", "Valor"]]


  def initialize(contribuicoes)
    super()

    @contribuicoes= contribuicoes

    header 'Relatório de Contribuição'
    display_contribuicao_table
    footer

  end

  private

  def display_contribuicao_table
    if table_data.empty?
      text "Nenhuma contribuição encontrado"
    else
      table TABLE_HEADERS + table_data,
            header: true,
            column_widths: TABLE_WIDTHS,
            row_colors: TABLE_ROW_COLORS
    end
  end

  def table_data
    @table_data ||= @contribuicoes.map { |c| [ c.data.to_s(:br), c.tipo_contribuicao.descricao,  number_to_currency(c.valor) ] }
  end

end
