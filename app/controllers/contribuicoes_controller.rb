class ContribuicoesController < ApplicationController

  before_action :set_contribuicao, only: [:show, :edit, :update]
  before_action :preencher_listas, only: [:new, :edit]

  def index
    @membro = Membro.find(params[:membro_id])
    @tela = "Listar Contribuições de #{@membro.pessoa.nome}"
    @contribuicoes = Contribuicao.where(membro_id: params[:membro_id])
  end

  def show
    @tela = 'Visualizar Contribuição'
  end

  def edit
    @tela = "Alterar Contribuição de #{@membro.pessoa.nome}"
  end

  def new
    @membro = Membro.find(params[:membro_id])
    @contribuicao = @membro.contribuicaos.build
    @contribuicao.data = Time.new.to_date
    @tela = "Cadastrar Contribuição de #{@membro.pessoa.nome}"
  end

  def create
    @membro = Membro.find(params[:membro_id])
    @contribuicao = @membro.contribuicaos.create(contribuicao_params)

    respond_to do |format|
      if @contribuicao.save
        format.html { redirect_to membro_contribuicoes_path(@membro), notice: 'Salvo com sucesso.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @contribuicao.update(contribuicao_params)
        format.html { redirect_to membro_contribuicoes_path(@contribuicao.membro), notice: 'Contribuição alterada com sucesso.' }
        format.json { render :show, status: :ok, location: @contribuicao }
      else
        format.html { render :edit }
        format.json { render json: @contribuicao.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def preencher_listas
    @tipo_ops = TipoContribuicao.all.collect.map do |t|
      [t.descricao, t.id]
    end
  end

  def set_contribuicao
    @contribuicao = Contribuicao.find(params[:id])
    @membro = @contribuicao.membro
  end

  def contribuicao_params
    params.require(:contribuicao).permit(:tipo_contribuicao_id, :valor, :data)
  end

end
