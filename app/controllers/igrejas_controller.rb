class IgrejasController < ApplicationController

  before_action :set_igreja, only: [:show, :edit, :update, :destroy]

  def show

  end

  def index

  end

  def new
    @igreja = Igreja.new
    @igreja.enderecos.build().build_bairro().build_cidade()
  end

  def create

    @igreja = Igreja.new(igreja_params)

    respond_to do |format|
      if @igreja.save
        format.html { redirect_to @igreja, notice: 'Salvo com sucesso!' }
        format.json { render :show, status: :created, location: @igreja }
      else
        format.html { render :new }
        format.json { render json: @igreja.errors, status: :unprocessable_entity }
      end
    end

  end

  private

  def set_igreja
    @igreja = Igreja.find(params[:id])
  end

  def igreja_params
    params.require(:igreja).permit(:descricao, enderecos_attributes: [:logradouro, :numero, :complemento, :cep, bairro_attributes: [:bairro] ])
  end

end
