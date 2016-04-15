class Reports::ContribuicaoAnualController < ApplicationController

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
          COALESCE(r.id, -1) AS rede_id,
          COALESCE(r.descricao, 'SEM REDE') AS rede,
          COALESCE(e.id, -1) AS equipe_id,
          COALESCE(e.descricao, 'SEM EQUIPE') AS equipe,
          COALESCE(se.id, -1) AS sub_equipe_id,
          COALESCE(se.descricao, 'SEM SUB EQUIPE') AS sub_equipe,
          COALESCE(c.id, -1) AS celula_id,
          COALESCE(c.descricao, 'SEM CÉLULA') AS celula,
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
          LEFT JOIN celula_membros cm ON cm.membro_id = m.id
          LEFT JOIN celulas c ON c.id = cm.celula_id
          LEFT JOIN sub_equipes se ON se.id = c.sub_equipe_id
          LEFT JOIN equipes e ON e.id = se.equipe_id
          LEFT JOIN redes r ON r.id = e.rede_id
        WHERE TRUE "

    unless @cadastro.nil? or @cadastro.empty?
      sql = sql + " AND m.numero_cadastro = " + @cadastro
    end

    unless @nome.nil? or @nome.empty?
      sql = sql + " AND p.nome ILIKE '%" + @nome + "%' "
    end

    unless @cargo_id.nil? or @cargo_id.empty? or @cargo_id == "0"
      sql = sql + " AND cg.id = " + @cargo_id
    end

    unless @igreja_id.nil? or @igreja_id.empty? or @igreja_id == "0"
      sql = sql + " AND i.id = " + @igreja_id
    end

    unless @rede_id.nil? or @rede_id.empty? or @rede_id == "0"
      sql = sql + " AND r.id = " + @rede_id
    end

    unless @equipe_id.nil? or @equipe_id.empty? or @equipe_id == "0"
      sql = sql + " AND e.id = " + @equipe_id
    end

    unless @sub_equipe_id.nil? or @sub_equipe_id.empty? or @sub_equipe_id == "0"
      sql = sql + " AND se.id = " + @sub_equipe_id
    end

    unless @celula_id.nil? or @celula_id.empty? or @celula_id == "0"
      sql = sql + " AND c.id = " + @celula_id
    end

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
          rede_id: r['rede_id'],
          rede: r['rede'],
          equipe_id: r['equipe_id'],
          equipe: r['equipe'],
          sub_equipe_id: r['sub_equipe_id'],
          sub_equipe: r['sub_equipe'],
          celula_id: r['celula_id'],
          celula: r['celula'],
          valores: [
              [
                  BigDecimal.new(r['jan']),
                  BigDecimal.new(r['fev']),
                  BigDecimal.new(r['mar']),
                  BigDecimal.new(r['abr']),
                  BigDecimal.new(r['mai']),
                  BigDecimal.new(r['jun']),
                  BigDecimal.new(r['jul']),
                  BigDecimal.new(r['ago']),
                  BigDecimal.new(r['set']),
                  BigDecimal.new(r['out']),
                  BigDecimal.new(r['nov']),
                  BigDecimal.new(r['dez']),
                  BigDecimal.new(r['tot'])
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
