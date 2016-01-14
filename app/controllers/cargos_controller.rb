class CargosController < ApplicationController
  before_action :set_cargo, only: [:show, :edit, :update]

  def index
    @cargos = Cargo.all
  end
  def show

  end

  def edit

  end

  def new
    @cargo = Cargo.new
  end

  def create
    @cargo =   Cargo.new(cargo_params)

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
