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
          COALESCE(membro_redes(m.id), 'SEM REDE') AS rede,
          COALESCE(membro_equipes(m.id), 'SEM EQUIPE') AS equipe,
          COALESCE(membro_sub_equipes(m.id), 'SEM SUB EQUIPE') AS sub_equipe,
          COALESCE(membro_celulas(m.id), 'SEM CÉLULA') AS celula
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
