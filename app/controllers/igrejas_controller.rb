class IgrejasController < ApplicationController

  before_action :set_igreja, only: [:show, :edit, :update, :destroys]
  before_action :set_responsaveis, only: [:new, :edit, :create, :update]


  ## TODO REFATORAR METODOS CARREGA ESTADO E CIDADES

  def show

  end

  def index

    @igrejas = Igreja.all
    @igreja = Igreja.new

  end

  def edit

    @estados = Estado.order('nome')
    @cidades = Cidade.where("estado_id = ?", Estado.first.id).order("nome")

    if not(@igreja.enderecos.nil?) && @igreja.enderecos.length > 0
      if not(@igreja.enderecos[0].cidade.nil?)
        @cidades = Cidade.where("estado_id = ?", @igreja.enderecos[0].cidade.estado.id).order("nome")
      end
    else
      @igreja.enderecos.build.build_bairro
    end

    if @igreja.contatos.nil? || @igreja.contatos.length == 0
      @igreja.contatos.build(tipo: Contato.tipos[:telefone])
      @igreja.contatos.build(tipo: Contato.tipos[:email])
    end

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


  def set_responsaveis
    @resonsaveis = Membro.all
  end

  def set_igreja
    @igreja = Igreja.find(params[:id])
  end

  def igreja_params
    params.require(:igreja).permit(
        :descricao,
        :responsavel_id,
        contatos_attributes: [
            :id,
            :tipo,
            :descricao
        ],
        igreja_enderecos_attributes: [
            :id,
            :descricao,
            endereco_attributes: [
                :id,
                :estado_id,
                :cidade_id,
                :logradouro,
                :numero,
                :cep,
                :complemento,
                bairro_attributes: [
                    :id,
                    :nome
                ]
            ]
        ]
    )
  end

end

