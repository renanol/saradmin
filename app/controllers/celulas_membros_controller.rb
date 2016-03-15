class CelulasMembrosController < ApplicationController

  before_action :set_celula, only:[ :new, :search ]
  before_action :preencher_listas, only: [ :new ]
  skip_before_action :verify_authenticity_token, only: [:create, :destroy]

  def new

  end

  def create
    @celula_membro = CelulaMembro.new({membro_id: params[:membro_id], celula_id: params[:celula_id]})

    if(@celula_membro.save)
      render json: @celula_membro, status: :created
    else
      render json: {errors: @celula.erros}, status: :unprocessable_entity
    end

  end

  def destroy

    @celula_membro = CelulaMembro.find(params[:celula_membro_id])

    @celula_membro.destroy

    render json: @celula_membro, status: :created

  end

  def search
    render json: Membro.by_nome_pessoa(params[:nome], params[:igreja_id], @celula.membros_ids), status: :created
  end

  private

  def set_celula
    @celula = Celula.find(params[:celula_id])
    @celula_membros = @celula.celula_membros
    @membros = Membro.all


  end

  def preencher_listas

  end


  
end