module Reports

  class MembrosContribuicoesReport < PdfReport
    include ActionView::Helpers::NumberHelper

    TABLE_WIDTHS = [100, 220, 200]
    TABLE_HEADERS = [["Data", "Tipo", "Valor"]]

    def initialize(membros)
      super()

      @membros = membros

      header "Contribuições dos membros"

      move_down(15)

      display_membros_table

      footer
    end

    private

    def display_membros_table

      if table_data.empty?
        text "Sem resultados"
      else
        table_data.each do |data|

          @membro_info = [[{:content => "<b>Cadastro:</b>", :align => :right}, data[:numero_cadastro], {:content => "<b>Nome:</b>", :align => :right}, data[:nome]]]
          table @membro_info,
                cell_style: {:borders => [], :padding => 1, :inline_format => true},
                column_widths: [60, 180, 60, 220]

          @membro_info = [[{:content => "<b>Cargo:</b>", :align => :right}, data[:cargo], {:content => "<b>Igreja:</b>", :align => :right}, data[:igreja], {:content => "<b>Rede:</b>", :align => :right}, data[:rede]]]
          table @membro_info,
                cell_style: {:borders => [], :padding => 1, :inline_format => true},
                column_widths: [60, 80, 60, 180, 60, 80]

          @membro_info = [[{:content => "<b>Equipe:</b>", :align => :right}, data[:equipe], {:content => "<b>Sub-equipe:</b>", :align => :right}, data[:sub_equipe], {:content => "<b>Célula:</b>", :align => :right}, data[:celula]]]
          table @membro_info,
                cell_style: {:borders => [], :padding => 1, :inline_format => true},
                column_widths: [60, 80, 60, 180, 60, 80, 60]

          move_down(5)

          table TABLE_HEADERS + table_data_contribuicoes(data[:membro_id]),
                cell_style: {:padding_top => 1, :padding_bottom => 1},
                header: true,
                column_widths: TABLE_WIDTHS,
                row_colors: TABLE_ROW_COLORS do
            row(0).font_style = :bold
            column(0).style :align => :center
            column(1).style :align => :left
            column(2).style :align => :right
          end

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

    def table_data_contribuicoes(membro_id)
      Contribuicao.by_membro_order(membro_id).map { |c| [ c.data.to_s(:br), c.tipo_contribuicao.descricao, number_to_currency(c.valor)] }
    end

  end

end
