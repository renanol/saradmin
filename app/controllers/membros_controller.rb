class MembrosController < ApplicationController

  before_action :preencher_listas, only: [:search, :index, :new, :edit]
  before_action :set_membro, only: [:show, :edit, :update, :destroy]

  def index
    @tela = 'Listar Membros'

    @q = Membro.ransack(params[:q])
    @membros = @q.result(distinct: false)
  end

  def new
    @tela = 'Cadastrar Membro'
    @membro = Membro.new
    @membro.build_pessoa(estado_civil: Pessoa.estado_civis[:solteiro])

    @membro.pessoa.pessoa_enderecos.build(descricao: 'Principal').build_endereco(pais_id: @paises.first.id, estado_id: @estados.first.id,  cidade_id: @cidades.first.id, bairro_id: @bairros.first.id)
    @membro.pessoa.pessoa_enderecos.build(descricao: 'Comercial').build_endereco(pais_id: @paises.first.id, estado_id: @estados.first.id,  cidade_id: @cidades.first.id, bairro_id: @bairros.first.id)

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

    @paises = Pais.order('nome')

    @estados = Estado.where('pais_id =? ', @paises.first.id).order('nome')

    @estados << Estado.new({id: -1, nome: 'Novo'})

    @cidades = Cidade.where('estado_id = ?', @estados.first.id).order('nome')

    @bairros = Bairro.where('cidade_id = ?', @cidades.first.id).order('nome')

    # preenchendo options

    @igreja_ops = Igreja.where(id: current_user.igrejas_ids).collect.map { |i| [i.descricao, i.id]  }

    @cargo_ops = Cargo.all.collect.map { |i|   [i.descricao, i.id] }

    @estados_civis_ops = Pessoa.estado_civis.collect.map { |e|  e }

    @paises_ops = @paises.collect.map { |pais|  [pais.nome.titleize, pais.id] }

    @estados_ops = @estados.collect.map { |estado|  [estado.nome.titleize, estado.id] }

    @cidades_ops = @cidades.collect.map { |cidade|  [cidade.nome.titleize, cidade.id] }

    @bairros_ops = @bairros.collect.map { |bairro|  [bairro.nome.titleize, bairro.id] }


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
