class EnderecosController < ApplicationController

    skip_before_action :verify_authenticity_token, only: [:bairros, :cidades, :estados, :paises]

  def bairro

    bairro_id = params[:bairro_id]
    @bairro = Bairro.find(bairro_id)

    render json: @bairro
  end

  def bairros

    nome = params[:nome]
    cidade_id = params[:cidade_id]

    bairro = Bairro.new(nome: nome, cidade_id: cidade_id)

    respond_to do |format|
      if bairro.save
        format.json { render json: bairro, status: :created }
      else
        format.json { render json: bairro.errors, status: :unprocessable_entity }
      end
    end

  end

  def cidades

    nome = params[:nome]
    estado_id = params[:estado_id]

    cidade = Cidade.new(nome: nome, estado_id: estado_id)

    respond_to do |format|
      if cidade.save
        format.json { render json: cidade, status: :created }
      else
        format.json { render json: cidade.errors, status: :unprocessable_entity }
      end
    end

  end

  def estados

    nome = params[:nome]
    pais_id = params[:pais_id]

    estado = Estado.new(nome: nome, pais_id: pais_id)

    respond_to do |format|
      if estado.save
        format.json { render json: estado, status: :created }
      else
        format.json { render json: estado.errors, status: :unprocessable_entity }
      end
    end

  end

  def paises

    nome = params[:nome]

    pais = Pais.new(nome: nome)

    respond_to do |format|
      if pais.save
        format.json { render json: pais, status: :created }
      else
        format.json { render json: pais.errors, status: :unprocessable_entity }
      end
    end

  end

  def buscar_estados
    render json: Estado.by_pais(params[:pais_id])
  end

  def buscar_cidades
    render json: Cidade.by_estado(params[:estado_id])
  end

  def buscar_bairros
    render json: Bairro.by_cidade(params[:cidade_id])
  end

  def buscar_paises
    render json: Pais.all
  end


end