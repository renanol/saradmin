# == Schema Information
#
# Table name: sub_equipes
#
#  id             :integer          not null, primary key
#  descricao      :string
#  equipe_id      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  responsavel_id :integer
#

class SubEquipesController < ApplicationController
  before_action :set_sub_equipe, only: [:show, :edit, :update]
  before_action :set_equipes, only: [:new, :edit, :create, :update]
  before_action :set_responsaveis, only: [:new, :edit, :create, :update]


  def index
    @tela = 'Listar Sub-equipes'

    @sub_equipes = SubEquipe.none

    if current_user.tem_permissao ['usuarioPodeAcessarTodosOsNiveisDaIgreja']
      @sub_equipes = SubEquipe.where(equipe_id: current_user.equipes_ids)
    else
      membro = Membro.find_by_user_id(current_user.id)

      unless membro.nil?
        @sub_equipes = SubEquipe.where(id: membro.sub_equipes_ids)
      else
        @sub_equipes = SubEquipe.none
      end
    end

    authorize @sub_equipes
  end

  def show
    @tela = 'Visualizar Sub-equipe'
  end

  def edit
    @tela = 'Editar Sub-equipe'
  end

  def new
    @tela = 'Cadastrar Sub-equipe'
    @sub_equipe = SubEquipe.new
  end

  def create
    @sub_equipe = SubEquipe.new(sub_equipe_params)

    respond_to do |format|
      if @sub_equipe.save
        format.html { redirect_to @sub_equipe, notice: 'Salvo com sucesso.' }
      else
        format.html { render :new }
      end
    end

  end

  def update
    respond_to do |format|
      if @sub_equipe.update(sub_equipe_params)
        format.html { redirect_to @sub_equipe, notice: 'Atualizado com sucesso.' }
      else
        format.html { render :edit }
      end
    end

  end

  private

  def set_responsaveis
    @responsaveis = Membro.where(igreja_id: current_user.igrejas_ids)
  end

  def set_equipes
    @equipes = Equipe.where(rede_id: current_user.redes_ids)
  end

  def set_sub_equipe
    @sub_equipe = SubEquipe.find(params[:id])
  end

  def sub_equipe_params
    params.require(:sub_equipe).permit(:descricao, :equipe_id, :responsavel_id)
  end
end
