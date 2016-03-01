# == Schema Information
#
# Table name: igrejas
#
#  id             :integer          not null, primary key
#  descricao      :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  membro_id      :integer
#  responsavel_id :integer
#

class IgrejasController < ApplicationController

  before_action :set_igreja, only: [:show, :edit, :update, :destroys]
  before_action :preencher_listas, only: [:new, :edit, :create, :update]


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

    if @igreja.contatos.nil? || @igreja.contatos.length == 0
      @igreja.contatos.build(tipo: Contato.tipos[:telefone])
      @igreja.contatos.build(tipo: Contato.tipos[:email])
    end

  end

  def new
    @tela = 'Cadastrar Igreja'

    @igreja = Igreja.new

    @igreja.igreja_enderecos.build(descricao: 'Principal').build_endereco

    @igreja.contatos.build({tipo: Contato.tipos[:telefone]})
    @igreja.contatos.build({tipo: Contato.tipos[:email]})

  end

  #TODO MOVER PARA O APPLICATION
  def buscar_estados
    render json: Estado.by_pais(params[:pais_id])
  end

  def buscar_cidades
    render json: Cidade.by_estado(params[:estado_id])
  end

  def buscar_bairros
    render json: Bairro.by_cidade(params[:cidade_id])
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

        User.where(grupo_id: [1, 2]).each do |u|
          UserIgreja.create(user_id: u.id, igreja_id: @igreja.id)
        end

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

    @resonsaveis = Membro.none.collect.map {|m| [m.pessoa.nome, m.id] }

    unless @igreja.nil?
      @resonsaveis = Membro.where(igreja_id: @igreja.id).collect.map {|m| [m.pessoa.nome, m.id] }
    end

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
                :bairro_id,
                :pais_id
            ]
        ]
    )
  end

end

