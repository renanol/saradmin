# == Schema Information
#
# Table name: redes
#
#  id             :integer          not null, primary key
#  descricao      :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  responsavel_id :integer
#  igreja_id      :integer
#

class RedesController < ApplicationController

  before_action :set_rede, only: [:show, :edit, :update]

  def index
    @tela = 'Listar Redes'
    @redes = Rede.none

    if current_user.tem_permissao ['usuarioPodeAcessarTodosOsNiveisDaIgreja']
      @redes = Rede.where(igreja_id: current_user.igrejas_ids)
    else
      membro = Membro.find_by_user_id(current_user.id)

      unless membro.nil?
        @redes = Rede.where(id: membro.redes_ids)
      else
        @redes = Rede.none
      end
    end

    authorize @redes
  end

  def show
    @tela = 'Visualizar Rede'
  end

  def edit
    @tela = 'Editar Rede'
  end

  def new
    @tela = 'Cadastrar Rede'
    @rede = Rede.new
  end

  def create
    @rede = Rede.new(rede_params)

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

  def set_rede
    @rede = Rede.find(params[:id])
  end

  def rede_params
    params.require(:rede).permit(:descricao, :responsavel_id, :igreja_id)
  end

end
