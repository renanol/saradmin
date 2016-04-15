# == Schema Information
#
# Table name: membros
#
#  id                              :integer          not null, primary key
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  pessoa_id                       :integer
#  igreja_id                       :integer
#  cargo_id                        :integer
#  numero_cadastro                 :integer
#  titulo_eleitor_numero_inscricao :string
#  titulo_eleitor_zona             :string
#  titulo_eleitor_secao            :string
#  titulo_eleitor_data_emissao     :date
#  user_id                         :integer
#

class MembrosController < ApplicationController

  before_action :preencher_listas, only: [:search, :index, :new, :edit, :create, :show]
  before_action :set_membro, only: [:show, :edit, :update, :destroy, :report_contribuicao]
  skip_before_action :verify_authenticity_token, only: [:search_membro]


  def index
    @tela = 'Listar Membros'

    @q = Membro.ransack(params[:q])
    @membros = @q.result(distinct: false)
  end

  def new
    @tela = 'Cadastrar Membro'
    @membro = Membro.new
    @membro.build_pessoa(estado_civil: Pessoa.estado_civis[:solteiro])

    @membro.pessoa.pessoa_enderecos.build(descricao: 'Principal').build_endereco
    @membro.pessoa.pessoa_enderecos.build(descricao: 'Comercial').build_endereco

    @membro.pessoa.contatos.build(tipo: Contato.tipos[:email])
    @membro.pessoa.contatos.build(tipo: Contato.tipos[:telefone])
    @membro.pessoa.contatos.build(tipo: Contato.tipos[:telefone_comercial])
  end

  def create

    @membro = Membro.new(membro_params)

    respond_to do |format|
      if @membro.save
        format.html { redirect_to @membro, notice: 'Membro criado com sucesso.' }
        format.json { render :show, status: :created, location: @membro }
      else
        format.html { render :new }
        format.json { render json: @membro.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @tela = 'Alterar Membro'


  end

  def update
    respond_to do |format|
      if @membro.update(membro_params)
        format.html { redirect_to @membro, notice: 'Membro alterado com sucesso.' }
        format.json { render :show, status: :ok, location: @membro }
      else
        format.html { render :edit }
        format.json { render json: @membro.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @tela = 'Visualizar Membro'
  end

  def report
    index
    respond_to do |format|
      format.pdf do
        pdf = MembroReport.new(@membros)
        send_data pdf.render, filename: "membros_report.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end

  def search
    index

    render :index
  end

  private

  def set_membro
    @membro = Membro.find(params[:id])
  end

  def preencher_listas

    # preenchendo options

    @igreja_ops = Igreja.where(id: current_user.igrejas_ids).collect.map { |i| [i.descricao, i.id]  }

    @cargo_ops = Cargo.all.collect.map { |i|   [i.descricao, i.id] }

    @estados_civis_ops = Pessoa.estado_civis.collect.map { |e|  e }

  end

  def membro_params
    params.require(:membro).permit(
        :numero_cadastro,
        :igreja_id,
        :cargo_id,
        :email,
        :telefone,
        pessoa_attributes: [
            :id,
            :nome,
            :data_nascimento,
            :cpf,
            :rg,
            :estado_civil,
            :titulo_eleitor_numero_inscricao,
            :titulo_eleitor_zona,
            :titulo_eleitor_secao,
            :titulo_eleitor_data_emissao,
            pessoa_enderecos_attributes: [
                :id,
                :descricao,
                endereco_attributes: [
                    :id,
                    :logradouro,
                    :numero,
                    :cep,
                    :complemento,
                    :ponto_referencia,
                    :bairro_id,
                    :pais_id,
                    :estado_id,
                    :cidade_id
                ]
            ],
            contatos_attributes: [
                :id,
                :tipo,
                :descricao
            ]
        ]
    )
  end

end
