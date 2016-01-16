class EquipesController < ApplicationController
  before_action :set_equipe, only: [:show, :edit, :update]
  before_action :set_redes, only: [:new, :edit, :create, :update]

  def index
    @equipes = Equipe.all
  end
  def show

  end

  def edit

  end

  def new
    @equipe = Equipe.new
  end

  def create
    @equipe =   Equipe.new(equipe_params)

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

  def set_redes
    @redes = Rede.all
  end

  def set_equipe
    @equipe = Equipe.find(params[:id])
  end

  def equipe_params
    params.require(:equipe).permit(:descricao, :rede_id)
  end
end
