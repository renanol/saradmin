# == Schema Information
#
# Table name: celulas
#
#  id             :integer          not null, primary key
#  descricao      :string
#  sub_equipe_id  :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  responsavel_id :integer
#

class CelulasController < ApplicationController
  before_action :set_celula, only: [:show, :edit, :update]
  before_action :set_listas, only: [:new, :edit]

  def index
    @tela = 'Listar Células'

    @celulas = Celula.none

    if current_user.tem_permissao ['usuarioPodeAcessarTodosOsNiveisDaIgreja']
      @celulas = Celula.where(sub_equipe_id: current_user.sub_equipes_ids)
    else
      membro = Membro.find_by_user_id(current_user.id)

      unless membro.nil?
        @celulas = Celula.where(id: membro.celulas_ids)
      else
        @celulas = Celula.none
      end
    end

    authorize @celulas
  end

  def show
    @tela = 'Visualizar Célula'
  end

  def edit
    @tela = 'Editar Célula'
  end

  def new
    @tela = 'Cadastrar Célula'
    @celula = Celula.new
  end

  def create
    @celula = Celula.new(celula_params)

    respond_to do |format|
      if @celula.save
        format.html { redirect_to @celula, notice: 'Salvo com sucesso.' }
      else
        format.html { render :new }
      end
    end

  end

  def update
    respond_to do |format|
      if @celula.update(celula_params)
        format.html { redirect_to @celula, notice: 'Atualizado com sucesso.' }
      else
        format.html { render :edit }
      end
    end

  end

  private

  def set_listas
    @sub_equipes = SubEquipe.where(equipe_id: current_user.equipes_ids)
    @membros = Membro.where(igreja_id: current_user.igrejas_ids)


  end

  def set_celula
    @celula = Celula.find(params[:id])
  end

  def celula_params
    params.require(:celula).permit(:descricao, :sub_equipe_id, :responsavel_id)
  end
end
