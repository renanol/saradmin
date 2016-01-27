class IgrejasController < ApplicationController

  before_action :set_igreja, only: [:show, :edit, :update, :destroys]
  before_action :preencher_listas, only: [:new, :edit, :create, :update]


  ## TODO REFATORAR METODOS CARREGA ESTADO E CIDADES

  def show

    @tela = 'Visualizar Igreja'

  end

  def index
    @tela = 'Listar Igreja'

    @igreja = Igreja.new

    @igrejas = Igreja.none

    if current_user.tem_permissao ['usuarioPodeAcessarTodosOsNiveisDaIgreja']
      @igrejas = Igreja.where(id: current_user.igrejas_ids)
    else
      membro = Membro.find_by_user_id(current_user.id)

      unless membro.nil?
        @igrejas = Igreja.where(id: membro.igrejas_ids)
      else
        @igrejas = Igreja.none
      end
    end

    authorize @igrejas
  end

  def edit

    @tela = 'Alterar Igreja'

    if not(@igreja.enderecos.nil?) && @igreja.enderecos.length > 0
      if not(@igreja.enderecos[0].cidade.nil?)
        @cidades = Cidade.where("estado_id = ?", @igreja.enderecos[0].cidade.estado.id).order("nome")
      end
    else
      @igreja.igreja_enderecos.build(descricao: 'Principal').build_endereco.build_bairro
    end

    if @igreja.contatos.nil? || @igreja.contatos.length == 0
      @igreja.contatos.build(tipo: Contato.tipos[:telefone])
      @igreja.contatos.build(tipo: Contato.tipos[:email])
    end

  end

  def new
    @tela = 'Cadastrar Igreja'

    @igreja = Igreja.new

    @igreja.igreja_enderecos.build(descricao: 'Principal').build_endereco.build_bairro

    @igreja.contatos.build({tipo: Contato.tipos[:telefone]})
    @igreja.contatos.build({tipo: Contato.tipos[:email]})

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

  def preencher_listas
    @resonsaveis = Membro.all
    @estados = Estado.order('nome')
    @cidades = Cidade.where("estado_id = ?", Estado.first.id).order("nome")
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
                :ponto_referencia,
                bairro_attributes: [
                    :id,
                    :nome
                ]
            ]
        ]
    )
  end

end

