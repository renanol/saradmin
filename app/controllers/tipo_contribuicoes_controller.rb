# == Schema Information
#
# Table name: tipo_contribuicoes
#
#  id         :integer          not null, primary key
#  descricao  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TipoContribuicoesController < ApplicationController
    before_action :set_tipo_contribuicao, only: [:show, :edit, :update]

    def index
      @tela = 'Listar Tipos de Contribuição'
      @tipo_contribuicoes = TipoContribuicao.all.order(:descricao)
    end

    def show
      @tela = 'Visualizar Tipo de Contribuição'
    end

    def edit
      @tela = 'Alterar Tipo de Contribuição'
    end

    def new
      @tela = 'Cadastrar Tipo de Contribuição'
      @tipo_contribuicao = TipoContribuicao.new
    end

    def create
      @tipo_contribuicao = TipoContribuicao.new(tipo_contribuicao_params)

      respond_to do |format|
        if @tipo_contribuicao.save
          format.html { redirect_to @tipo_contribuicao, notice: 'Salvo com sucesso.' }
        else
          format.html { render :new }
        end
      end

    end

    def update
      respond_to do |format|
        if @tipo_contribuicao.update(tipo_contribuicao_params)
          format.html { redirect_to @tipo_contribuicao, notice: 'Tipo de contribuição alterado com sucesso.' }
          format.json { render :show, status: :ok, location: @tipo_contribuicao }
        else
          format.html { render :edit }
          format.json { render json: @tipo_contribuicao.errors, status: :unprocessable_entity }
        end
      end
    end

    private

    def set_tipo_contribuicao
      @tipo_contribuicao = TipoContribuicao.find(params[:id])
    end

    def tipo_contribuicao_params
      params.require(:tipo_contribuicao).permit(:descricao)
    end

end
