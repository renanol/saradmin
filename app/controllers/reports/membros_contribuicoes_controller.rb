class Reports::MembrosContribuicoesController < ApplicationController

  def index
    
  end

  def report

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
          COALESCE(c.descricao, 'SEM CÉLULA') AS celula
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

    @records = []

    ActiveRecord::Base.connection.execute(sql).each do |r|
      @records << {
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
          celula: r['celula']
      }
    end

    respond_to do |format|
      format.pdf do
        pdf = Reports::MembrosContribuicoesReport.new(@records)
        send_data pdf.render, filename: "membros_contribuicoes.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end
  
end
