# == Schema Information
#
# Table name: grupos
#
#  id         :integer          not null, primary key
#  descricao  :string
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GruposController < ApplicationController
  before_action :set_grupo, only: [:show, :edit, :update, :destroy]

  def index
    @tela = 'Listar Grupos'
    @grupos = Grupo.todos
  end

  def show
    @tela = 'Visualizar Grupo'
  end

  def new
    @tela = 'Cadastrar Grupo'
    @grupo = Grupo.new

    Permissao.all.each do |perm|
      if perm.sim_nao?
        @grupo.grupo_permissaos.build(grupo: @grupo, permissao_id: perm.id, valor: GrupoPermissao.valores[:nao])
      else
        @grupo.grupo_permissaos.build(grupo: @grupo, permissao_id: perm.id, valor: GrupoPermissao.valores[:nenhuma])
      end
    end
  end

  def edit
    @tela = 'Alterar Grupo'
  end

  def create
    @grupo = Grupo.new(grupo_params)

    respond_to do |format|
      if @grupo.save
        format.html { redirect_to @grupo, notice: 'Grupo criado com sucesso.' }
        format.json { render :show, status: :created, location: @grupo }
      else
        format.html { render :new }
        format.json { render json: @grupo.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @grupo.update(grupo_params)
        format.html { redirect_to @grupo, notice: 'Grupo alterado com sucesso.' }
        format.json { render :show, status: :ok, location: @grupo }
      else
        format.html { render :edit }
        format.json { render json: @grupo.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_grupo
    @grupo = Grupo.find(params[:id])
  end

  def grupo_params
    params.require(:grupo).permit(:descricao, grupo_permissaos_attributes: [:id, :valor, :permissao_id])
  end

end
