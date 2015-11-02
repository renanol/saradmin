class IgrejasController < ApplicationController

  before_action :set_igreja, only: [:show, :edit, :update, :destroy]

  def show

  end

  def index

    @igrejas = Igreja.all

  end

  def edit

    @estados = Estado.all
    @cidades = Cidade.where("estado_id = ?", @igreja.enderecos[0].cidade.estado.id)

  end

  def new
    @igreja = Igreja.new
    @igreja.enderecos.build.build_bairro
    @igreja.igreja_contatos.build(3).build_contato

    @estados = Estado.all
    @cidades = Cidade.where("estado_id = ?", Estado.first.id)

  end

  def buscar_cidades
    @cidades = Cidade.where("estado_id = ?", params[:estado_id])
    render json: @cidades
  end

  def update
    respond_to do |format|
      if @igreja.update(igreja_params)
        format.html { redirect_to @igreja, notice: 'Igreja alterada com sucesso' }
        format.json { render :show, status: :ok, location: @igreja }
      else
        format.html { render :edit }
        format.json { render json: @igreja.errors, status: :unprocessable_entity }
      end
    end
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
    params.require(:igreja).permit(:descricao, enderecos_attributes: [:id,:cidade_id, :logradouro, :numero, :complemento, :cep, bairro_attributes: [:id,:nome] ])
  end



end
