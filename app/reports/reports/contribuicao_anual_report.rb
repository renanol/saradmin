module Reports
  class ContribuicaoAnualReport < PdfReport
    value_column_width = 55
    TABLE_WIDTHS =  []
    12.times { TABLE_WIDTHS << value_column_width }
    TABLE_WIDTHS << 60

    TABLE_HEADERS = [["JAN", "FEV", "MAR", "ABR", "MAI", "JUN", "JUL", "AGO", "SET", "OUT", "NOV", "DEZ", "TOT"]]

    def initialize(ano, membros=[])
      super(page_layout: :landscape)
      @membros = membros

      header "Contribuição Anual #{ano}"

      move_down(15)

      display_membro_table
      footer
    end

    private

    def display_membro_table
      if table_data.empty?
        text "Sem resultados"
      else
        table_data.each do |data|

          @membro_info = [[{:content => "<b>Cadastro:</b>", :align => :right}, data[:numero_cadastro], {:content => "<b>Nome:</b>", :align => :right}, data[:nome]]]
          table @membro_info,
                cell_style: {:borders => [], :padding => 1, :inline_format => true},
                column_widths: [60, 180, 60, 420]

          @membro_info = [[{:content => "<b>Cargo:</b>", :align => :right}, data[:cargo], {:content => "<b>Igreja:</b>", :align => :right}, data[:igreja], {:content => "<b>Rede:</b>", :align => :right}, data[:rede]]]
          table @membro_info,
                cell_style: {:borders => [], :padding => 1, :inline_format => true},
                column_widths: [60, 180, 60, 180, 60, 180]

          @membro_info = [[{:content => "<b>Equipe:</b>", :align => :right}, data[:equipe], {:content => "<b>Sub-equipe:</b>", :align => :right}, data[:sub_equipe], {:content => "<b>Célula:</b>", :align => :right}, data[:celula]]]
          table @membro_info,
                cell_style: {:borders => [], :padding => 1, :inline_format => true},
                column_widths: [60, 180, 60, 180, 60, 180, 60]

          move_down(5)

          table TABLE_HEADERS + data[:valores],
                cell_style: {align: :right, :padding_top => 1, :padding_bottom => 1},
                header: true,
                column_widths: TABLE_WIDTHS,
                row_colors: TABLE_ROW_COLORS

          move_down(10)

          dash([1, 2, 3, 2, 1, 5], :phase => 6)
          stroke_horizontal_rule
          dash(100)

          move_down(10)
        end
      end
    end

    def table_data
      @table_data ||= @membros
    end
  end
end