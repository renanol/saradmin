class MembrosController < ApplicationController

  def new
    @tela = 'Cadastrar Membro'
    @membro_form = MembroForm.new
    @estados = Estado.order('nome')
    @cidades = Cidade.where('estado_id = ?', Estado.first.id).order('nome')
    @igreja_ops = Igreja.all.collect.map do |i|
      [i.descricao, i.id]
    end
  end

  def create
    @form = MembroForm.new(membro_form_params)

    membro = Membro.new(
        igreja_id: @form.igreja_id,
        pessoa: Pessoa.new(
            numero_cadastro: @form.numero_cadastro,
            nome: @form.nome,
            data_nascimento: @form.data_nascimento,
            cpf: @form.cpf,
            rg: @form.rg,
            estado_civil: @form.estado_civil
        )
    )

    membro.pessoa.enderecos << Endereco.new(
        logradouro: @form.endereco[:logradouro],
        numero: @form.endereco[:numero],
        cep: @form.endereco[:cep],
        complemento: @form.endereco[:complemento],
        estado_id: @form.endereco[:estado_id],
        cidade_id: @form.endereco[:cidade_id],
        bairro: Bairro.new(nome: @form.endereco[:bairro][:nome])
    )

    membro.pessoa.contatos << Contato.new(tipo: Contato.tipos[:email], descricao: @form.email)

    membro.pessoa.contatos << Contato.new(tipo: Contato.tipos[:telefone], descricao: @form.telefone)

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
    params.require(:membro).permit(
        :numero_cadastro,
        :nome,
        :data_nascimento,
        :cpf,
        :rg,
        :estado_civil,
        :email,
        :telefone,
        :igreja_id,
        endereco: [
            :logradouro,
            :numero,
            :estado_id,
            :cidade_id,
            :complemento,
            :cep,
            bairro: [
                :nome
            ]
        ]
    )
  end

end
