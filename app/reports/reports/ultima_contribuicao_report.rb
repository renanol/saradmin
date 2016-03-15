module Reports
  class UltimaContribuicaoReport < PdfReport
    TABLE_WIDTHS = [  50,         200,    130,      80,                    80]
    TABLE_HEADERS = [["Cadastro", "Nome", "Cargo", "Última Contribuição", "Valor"]]

    def initialize(membros=[])
      super()
      @membros = membros

      header 'Ultima Contribuição'
      display_membro_table
      footer
    end

    private

    def display_membro_table
      if table_data.empty?
        text "Sem resultados"
      else
        table TABLE_HEADERS + table_data,
              header: true,
              column_widths: TABLE_WIDTHS,
              row_colors: TABLE_ROW_COLORS
      end
    end

    def table_data
      @table_data ||= @membros
    end
  end
end