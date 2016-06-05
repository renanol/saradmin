class MembroReport < PdfReport
    TABLE_WIDTHS = [50, 290, 100, 100]
    TABLE_HEADERS = [["ID", "Nome", "Cargo", "Igreja"]]

    def initialize(membros=[])
      super()
      @membros = membros

      header 'Listagem de membros'
      display_membro_table
      footer
    end

    private

    def display_membro_table
      if table_data.empty?
        text "Nenhum membro encontrado"
      else
        table TABLE_HEADERS + table_data,
              header: true,
              column_widths: TABLE_WIDTHS,
              row_colors: TABLE_ROW_COLORS
      end
    end

    def table_data
      @table_data ||= @membros.map { |m| [m.id, m.pessoa.nome, m.cargo.descricao, m.igreja.descricao] }
    end
end
