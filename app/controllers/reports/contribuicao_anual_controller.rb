class Reports::ContribuicaoAnualController < ApplicationController
  include ActionView::Helpers::NumberHelper
  def index
    @ano = Time.now.year
  end

  def report
    @ano = params[:ano]

    @cadastro = params[:cadastro]
    @nome = params[:nome]

    @cargo_id = params[:cargo_id]
    @igreja_id = params[:igreja_id]
    @rede_id = params[:rede_id]
    @equipe_id = params[:equipe_id]
    @sub_equipe_id = params[:sub_equipe_id]
    @celula_id = params[:celula_id]

    sql =
        "SELECT m.id AS membro_id,
          m.numero_cadastro,
          p.id AS pessoa_id,
          p.nome,
          cg.id AS cargo_id,
          cg.descricao AS cargo,
          i.id AS igreja_id,
          i.descricao AS igreja,
          COALESCE(membro_redes(m.id), 'SEM REDE') AS rede,
          COALESCE(membro_equipes(m.id), 'SEM EQUIPE') AS equipe,
          COALESCE(membro_sub_equipes(m.id), 'SEM SUB EQUIPE') AS sub_equipe,
          COALESCE(membro_celulas(m.id), 'SEM CÉLULA') AS celula,
          COALESCE((
            SELECT sum(valor)
            FROM contribuicoes ct
            WHERE ct.membro_id = m.id
              AND to_char(ct.data, 'mm/yyyy') = '01/#{@ano}'
          ), 0) as jan,
          COALESCE((
            SELECT sum(valor)
            FROM contribuicoes ct
            WHERE ct.membro_id = m.id
              AND to_char(ct.data, 'mm/yyyy') = '02/#{@ano}'
          ), 0) as fev,
          COALESCE((
            SELECT sum(valor)
            FROM contribuicoes ct
            WHERE ct.membro_id = m.id
              AND to_char(ct.data, 'mm/yyyy') = '03/#{@ano}'
          ), 0) as mar,
          COALESCE((
            SELECT sum(valor)
            FROM contribuicoes ct
            WHERE ct.membro_id = m.id
              AND to_char(ct.data, 'mm/yyyy') = '04/#{@ano}'
          ), 0) as abr,
          COALESCE((
            SELECT sum(valor)
            FROM contribuicoes ct
            WHERE ct.membro_id = m.id
              AND to_char(ct.data, 'mm/yyyy') = '05/#{@ano}'
          ), 0) as mai,
          COALESCE((
            SELECT sum(valor)
            FROM contribuicoes ct
            WHERE ct.membro_id = m.id
              AND to_char(ct.data, 'mm/yyyy') = '06/#{@ano}'
          ), 0) as jun,
          COALESCE((
            SELECT sum(valor)
            FROM contribuicoes ct
            WHERE ct.membro_id = m.id
              AND to_char(ct.data, 'mm/yyyy') = '07/#{@ano}'
          ), 0) as jul,
          COALESCE((
            SELECT sum(valor)
            FROM contribuicoes ct
            WHERE ct.membro_id = m.id
              AND to_char(ct.data, 'mm/yyyy') = '08/#{@ano}'
          ), 0) as ago,
          COALESCE((
            SELECT sum(valor)
            FROM contribuicoes ct
            WHERE ct.membro_id = m.id
              AND to_char(ct.data, 'mm/yyyy') = '09/#{@ano}'
          ), 0) as set,
          COALESCE((
            SELECT sum(valor)
            FROM contribuicoes ct
            WHERE ct.membro_id = m.id
              AND to_char(ct.data, 'mm/yyyy') = '10/#{@ano}'
          ), 0) as out,
          COALESCE((
            SELECT sum(valor)
            FROM contribuicoes ct
            WHERE ct.membro_id = m.id
              AND to_char(ct.data, 'mm/yyyy') = '11/#{@ano}'
          ), 0) as nov,
          COALESCE((
            SELECT sum(valor)
            FROM contribuicoes ct
            WHERE ct.membro_id = m.id
              AND to_char(ct.data, 'mm/yyyy') = '12/#{@ano}'
          ), 0) as dez,
          COALESCE((
            SELECT sum(valor)
            FROM contribuicoes ct
            WHERE ct.membro_id = m.id
              AND to_char(ct.data, 'yyyy') = '#{@ano}'
          ), 0) as tot
        FROM membros m
          JOIN pessoas p ON p.id = m.pessoa_id
          JOIN igrejas i ON i.id = m.igreja_id
          JOIN cargos cg ON cg.id = m.cargo_id
        WHERE TRUE "

    sql = "#{sql} AND m.numero_cadastro = #{@cadastro}" unless @cadastro.nil? or @cadastro.empty?

    sql = "#{sql} AND p.nome ILIKE '%#{@nome}%' " unless @nome.nil? or @nome.empty?

    sql = "#{sql} AND cg.id = #{@cargo_id}" unless @cargo_id.nil? or @cargo_id.empty? or @cargo_id == "0"

    sql = "#{sql} AND i.id = #{@igreja_id}" unless @igreja_id.nil? or @igreja_id.empty? or @igreja_id == "0"

    sql = "#{sql} AND #{@rede_id} IN (
        SELECT e.rede_id
        FROM celula_membros cm
          JOIN celulas c ON c.id = cm.celula_id
          JOIN sub_equipes se ON se.id = c.sub_equipe_id
          JOIN equipes e ON e.id = se.equipe_id
        WHERE cm.membro_id = m.id
      )" unless @rede_id.nil? or @rede_id.empty? or @rede_id == '0'

    sql = "#{sql} AND #{@equipe_id} IN (
        SELECT se.equipe_id
        FROM celula_membros cm
          JOIN celulas c ON c.id = cm.celula_id
          JOIN sub_equipes se ON se.id = c.sub_equipe_id
        WHERE cm.membro_id = m.id
      )" unless @equipe_id.nil? or @equipe_id.empty? or @equipe_id == "0"

    sql = "#{sql} AND #{@sub_equipe_id} IN (
        SELECT c.sub_equipe_id
        FROM celula_membros cm
          JOIN celulas c ON c.id = cm.celula_id
        WHERE cm.membro_id = m.id
      )" unless @sub_equipe_id.nil? or @sub_equipe_id.empty? or @sub_equipe_id == "0"

    sql = "#{sql} AND #{@celula_id} IN (
        SELECT cm.celula_id
        FROM celula_membros cm
        WHERE cm.membro_id = m.id
      )" unless @celula_id.nil? or @celula_id.empty? or @celula_id == "0"

    @records_array = []

    ActiveRecord::Base.connection.execute(sql).each do |r|
      @records_array << {
          membro_id: r['membro_id'],
          numero_cadastro: r['numero_cadastro'],
          pessoa_id: r['pessoa_id'],
          nome: r['nome'],
          cargo_id: r['cargo_id'],
          cargo: r['cargo'],
          igreja_id: r['igreja_id'],
          igreja: r['igreja'],
          rede: r['rede'],
          equipe: r['equipe'],
          sub_equipe: r['sub_equipe'],
          celula: r['celula'],
          valores: [
              [
                number_to_currency(BigDecimal.new(r['fev'])),
                number_to_currency(BigDecimal.new(r['jan'])),
                number_to_currency(BigDecimal.new(r['mar'])),
                number_to_currency(BigDecimal.new(r['abr'])),
                number_to_currency(BigDecimal.new(r['mai'])),
                number_to_currency(BigDecimal.new(r['jun'])),
                number_to_currency(BigDecimal.new(r['jul'])),
                number_to_currency(BigDecimal.new(r['ago'])),
                number_to_currency(BigDecimal.new(r['set'])),
                number_to_currency(BigDecimal.new(r['out'])),
                number_to_currency(BigDecimal.new(r['nov'])),
                number_to_currency(BigDecimal.new(r['dez'])),
                number_to_currency(BigDecimal.new(r['tot']))
              ]
          ]
      }
    end

    respond_to do |format|
      format.pdf do
        pdf = Reports::ContribuicaoAnualReport.new(@ano, @records_array)
        send_data pdf.render, filename: "contrib_anual.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end

end
