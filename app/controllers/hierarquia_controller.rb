class HierarquiaController < ApplicationController

  def preencher_igrejas
    render json: Igreja.where(id: current_user.igrejas_ids)
  end

  def preencher_cargos
    render json: Cargo.where("TRUE")
  end

  def preencher_responsaveis
    retorno = []

    Membro.joins(:cargo).where(igreja_id: params[:igreja_id], 'cargos.lideranca' => true).each do |m|
      retorno << {id: m.id, nome: m.pessoa.nome}
    end

    render json: retorno
  end

  def preencher_redes
    retorno = []

    Rede.where(igreja_id: params[:igreja_id]).each do |r|
      retorno << {id: r.id, descricao: r.descricao}
    end

    render json: retorno
  end

  def preencher_equipes
    retorno = []

    Equipe.where(rede_id: params[:rede_id]).each do |e|
      retorno << {id: e.id, descricao: e.descricao}
    end

    render json: retorno
  end

  def preencher_sub_equipes
    retorno = []

    SubEquipe.where(equipe_id: params[:equipe_id]).each do |se|
      retorno << {id: se.id, descricao: se.descricao}
    end

    render json: retorno
  end

  def preencher_celulas
    retorno = []

    Celula.where(sub_equipe_id: params[:sub_equipe_id]).each do |c|
      retorno << {id: c.id, descricao: c.descricao}
    end

    render json: retorno
  end

end
