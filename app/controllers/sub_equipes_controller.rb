class SubEquipesController < ApplicationController
  before_action :set_sub_equipe, only: [:show, :edit, :update]
  before_action :set_equipes, only: [:new, :edit, :create, :update]
  before_action :set_responsaveis, only: [:new, :edit, :create, :update]


  def index
    @sub_equipes = SubEquipe.all
  end
  def show

  end

  def edit

  end

  def new
    @sub_equipe = SubEquipe.new
  end

  def create
    @sub_equipe =   SubEquipe.new(sub_equipe_params)

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
    @responsaveis = Membro.all
  end

  def set_equipes
    @equipes = Equipe.all
  end

  def set_sub_equipe
    @sub_equipe = SubEquipe.find(params[:id])
  end

  def sub_equipe_params
    params.require(:sub_equipe).permit(:descricao, :equipe_id, :responsavel_id)
  end
end
