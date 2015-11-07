class GruposController < ApplicationController
  before_action :set_grupo, only: [:show, :edit, :update, :destroy]

  def index
    @grupos = Grupo.todos
  end

  def show
  end

  def new
    @grupo = Grupo.new

    Permissao.all.each do |perm|
      valor = GrupoPermissao.valores[:nenhuma]
      if perm.sim_nao?
        valor = GrupoPermissao.valores[:nao]
      end
      @grupo.grupo_permissaos.build(grupo: @grupo, permissao_id: perm.id, valor: valor)
    end

    puts @grupo
  end

  def edit
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
