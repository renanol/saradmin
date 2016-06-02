class Reports::UltimaContribuicaoController < ApplicationController
  include ActionView::Helpers::NumberHelper

  def index
    @data_ult_contrib = Date.current.to_s(:br)
  end

  def report
    @data_ult_contrib = params[:data_ult_contrib]

    sql =
        "SELECT DISTINCT
        m.numero_cadastro,
        p.nome,
        c.descricao,
        (SELECT to_char(cot.data, 'dd/mm/yyyy')
         FROM contribuicoes cot
         WHERE cot.membro_id = m.id
         ORDER BY cot.data DESC, cot.id DESC
         LIMIT 1) AS ULTIMA_CONTRIBUICAO,
        (SELECT cot.valor
         FROM contribuicoes cot
         WHERE cot.membro_id = m.id
         ORDER BY cot.data DESC
         LIMIT 1) AS VALOR
      FROM membros m
        JOIN pessoas p ON p.id = m.pessoa_id
        JOIN cargos c ON c.id = m.cargo_id
        LEFT JOIN contribuicoes ct ON ct.membro_id = m.id
      WHERE (SELECT max(cot.data)
             FROM contribuicoes cot
             WHERE cot.membro_id = m.id) <= to_date('#{@data_ult_contrib}', 'dd/mm/yyyy')"

    @records_array = []

    ActiveRecord::Base.connection.execute(sql).each do |r|
      @records_array << [r['numero_cadastro'], r['nome'], r['descricao'], r['ultima_contribuicao'], number_to_currency(r['valor'])]
    end

    respond_to do |format|
      format.pdf do
        pdf = Reports::UltimaContribuicaoReport.new(@records_array)
        send_data pdf.render, filename: "membros_report.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end

end
