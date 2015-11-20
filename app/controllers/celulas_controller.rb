class CelulasController < ApplicationController
  before_action :set_celula, only: [:show, :edit, :update]
  before_action :set_sub_equipes, only: [:new, :edit, :create, :update]

  def index
    @celulas = Celula.all
  end
  def show

  end

  def edit

  end

  def new
    @celula = Celula.new
  end

  def create
    @celula =   Celula.new(celula_params)

    respond_to do |format|
      if @celula.save
        format.html { redirect_to @celula, notice: 'Salvo com sucesso.' }
      else
        format.html { render :new }
      end
    end

  end

  def update

    @celula =   Celula.new(celula_params)

    respond_to do |format|
      if @celula.save
        format.html { redirect_to @celula, notice: 'Atualizado com sucesso.' }
      else
        format.html { render :edit }
      end
    end

  end

  private

  def set_sub_equipes
    @sub_equipes = SubEquipe.all
  end

  def set_celula
    @celula = Celula.find(params[:id])
  end

  def celula_params
    params.require(:celula).permit(:descricao, :sub_equipe_id)
  end
end
