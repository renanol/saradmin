class MembrosController < ApplicationController

  def new
    @tela = 'Cadastrar Membro'
    @membro_form = MembroForm.new
    @membro_form.estado_civil = Pessoa.estado_civis[:solteiro]
  end

  def create
    @form = MembroForm.new(membro_form_params)

    membro = Membro.new(
        pessoa: Pessoa.new(
            numero_cadastro: @form.numero_cadastro,
            nome: @form.nome,
            data_nascimento: @form.data_nascimento,
            cpf: @form.cpf,
            rg: @form.rg,
            estado_civil: @form.estado_civil
        )
    )

    respond_to do |format|
      if membro.save
        format.html { redirect_to membro, notice: 'Membro cadastrado com sucesso.' }
        format.json { render :show, status: :created, location: membro }
      else
        format.html { render :new }
        format.json { render json: membro.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def membro_form_params
    params.require(:membro).permit(:numero_cadastro, :nome, :data_nascimento, :cpf, :rg, :estado_civil)
  end

end
