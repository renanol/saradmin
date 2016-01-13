class RedesController < ApplicationController

  before_action :set_rede, only: [:show, :edit, :update]
  before_action :set_membros, only: [:new, :edit, :create, :update]

  def index
    @redes = Rede.all
  end
  def show

  end

  def edit

  end

  def new
    @rede = Rede.new
  end

  def create
    @rede =   Rede.new(rede_params)

    respond_to do |format|
      if @rede.save
        format.html { redirect_to @rede, notice: 'Salvo com sucesso.' }
      else
        format.html { render :new }
      end
    end

  end

  def update

    @rede =   Rede.new(rede_params)

    respond_to do |format|
      if @rede.save
        format.html { redirect_to @rede, notice: 'Atualizado com sucesso.' }
      else
        format.html { render :edit }
      end
    end

  end

  private

  def set_membros
    @responsaveis= Membro.all
  end

  def set_rede
    @rede = Rede.find(params[:id])
  end

  def rede_params
    params.require(:rede).permit(:descricao, :responsavel_id)
  end
end
