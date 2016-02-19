# == Schema Information
#
# Table name: cargos
#
#  id         :integer          not null, primary key
#  descricao  :string
#  lideranca  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CargosController < ApplicationController
  before_action :set_cargo, only: [:show, :edit, :update]

  def index
    @tela = 'Listar Cargos'
    @cargos = Cargo.all
  end

  def show
    @tela = 'Visualizar Cargo'
  end

  def edit
    @tela = 'Editar Cargo'
  end

  def new
    @tela = 'Cadastrar Cargo'
    @cargo = Cargo.new(lideranca: false)
  end

  def create
    @cargo = Cargo.new(cargo_params)

    respond_to do |format|
      if @cargo.save
        format.html { redirect_to @cargo, notice: 'Salvo com sucesso.' }
      else
        format.html { render :new }
      end
    end

  end

  def update

    respond_to do |format|

      if @cargo.update(cargo_params)
        format.html { redirect_to @cargo, notice: 'Atualizado com sucesso.' }
      else
        format.html { render :edit }
      end
    end

  end

  private

  def set_cargo
    @cargo = Cargo.find(params[:id])
  end

  def cargo_params
    params.require(:cargo).permit(:descricao, :lideranca )
  end
end
