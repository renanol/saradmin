class RedesController < ApplicationController

  before_action :set_rede, only: [:show, :edit, :update]
  before_action :set_membros, only: [:new, :edit, :create, :update]

  def index
    @redes = Rede.none

    if current_user.tem_permissao ['usuarioPodeAcessarTodosOsNiveisDaIgreja']
      # para adicionar no where igreja_id: current_user.igrejas_ids,
      @redes = Rede.all
    else
      membro = Membro.find_by_user_id(current_user.id)

      unless membro.nil?
        # para adicionar no where igreja_id: current_user.igrejas_ids,
        @redes = Rede.where(responsavel_id: membro.id)
      else
        @redes = Rede.none
      end
    end

    authorize @redes
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

    respond_to do |format|
      if @rede.update(rede_params)
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
