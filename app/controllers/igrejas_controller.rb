class IgrejasController < ApplicationController

  before_action :set_igreja, only: [:show, :edit, :update, :destroys]
  before_action :set_membros, only: [:new, :edit, :create, :update]


  ## TODO REFATORAR METODOS CARREGA ESTADO E CIDADES

  def show

  end

  def index

    @igrejas = Igreja.all
    @igreja = Igreja.new

  end

  def edit

    @estados = Estado.order('nome')
    @cidades = Cidade.where("estado_id = ?", @igreja.enderecos[0].cidade.estado.id).order("nome")

  end

  def new
    @igreja = Igreja.new
    @igreja.enderecos.build.build_bairro


    @igreja.igreja_contatos.build.build_contato({tipo: Contato.tipos[:telefone]})
    @igreja.igreja_contatos.build.build_contato({tipo: Contato.tipos[:email]})

    @estados = Estado.order('nome')
    @cidades = Cidade.where("estado_id = ?", Estado.first.id).order("nome")

  end

  def buscar_cidades
    @cidades = Cidade.where("estado_id = ?", params[:estado_id]).order("nome")
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

  def add_contato

    @igreja = Igreja.new(igreja_params)

    @igreja.igreja_contatos.build.build_contato

    @estados = Estado.order('nome')
    @cidades = Cidade.where("estado_id = ?", @igreja.enderecos[0].cidade.estado.id).order("nome")

    respond_to do |format|
        format.html { render :new }
    end

  end

  def create

    @igreja = Igreja.new(igreja_params)

    @estados = Estado.order('nome')
    @cidades = Cidade.where("estado_id = ?", @igreja.enderecos[0].cidade.estado.id).order("nome")

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


  def set_membros
    @membros = Membro.all
  end

  def set_igreja
    @igreja = Igreja.find(params[:id])
  end

  def igreja_params
    params.require(:igreja).permit(:descricao, :membro_id, igreja_contatos_attributes:[:id, contato_attributes:[:id, :tipo, :descricao]], enderecos_attributes: [:id,:cidade_id, :logradouro, :numero, :complemento, :cep, bairro_attributes: [:id,:nome] ])
  end

end

