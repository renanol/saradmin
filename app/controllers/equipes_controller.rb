# == Schema Information
#
# Table name: equipes
#
#  id             :integer          not null, primary key
#  descricao      :string
#  rede_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  responsavel_id :integer
#

class EquipesController < ApplicationController
  before_action :set_equipe, only: [:show, :edit, :update]

  def index
    @tela = 'Listar Equipes'

    @equipes = Equipe.none

    if current_user.tem_permissao ['usuarioPodeAcessarTodosOsNiveisDaIgreja']
      @equipes = Equipe.where(rede_id: current_user.redes_ids)
    else
      membro = Membro.find_by_user_id(current_user.id)

      unless membro.nil?
        @equipes = Equipe.where(id: membro.equipes_ids)
      else
        @equipes = Equipe.none
      end
    end

    authorize @equipes
  end

  def show
    @tela = 'Visualizar Equipe'
  end

  def edit
    @tela = 'Editar Equipe'
  end

  def new
    @tela = 'Cadastrar Equipe'
    @equipe = Equipe.new
  end

  def create
    @equipe = Equipe.new(equipe_params)

    respond_to do |format|
      if @equipe.save
        format.html { redirect_to @equipe, notice: 'Salvo com sucesso.' }
      else
        format.html { render :new }
      end
    end

  end

  def update

    respond_to do |format|
      if @equipe.update(equipe_params)
        format.html { redirect_to @equipe, notice: 'Atualizado com sucesso.' }
      else
        format.html { render :edit }
      end
    end

  end

  private

  def set_equipe
    @equipe = Equipe.find(params[:id])
  end

  def equipe_params
    params.require(:equipe).permit(:descricao, :rede_id, :responsavel_id)
  end
end
