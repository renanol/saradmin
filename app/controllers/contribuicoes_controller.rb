# == Schema Information
#
# Table name: contribuicoes
#
#  id                   :integer          not null, primary key
#  valor                :decimal(10, 2)
#  tipo_contribuicao_id :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  membro_id            :integer
#  data                 :date
#

class ContribuicoesController < ApplicationController

  before_action :set_contribuicao, only: [:show, :edit, :update]
  before_action :preencher_listas, only: [:new, :edit]

  def index
    @membro = Membro.find(params[:membro_id])

    @contribuicoes = Contribuicao.where(membro_id: params[:membro_id]).reverse_order
  end

  def show

  end

  def edit


  end

  def new
    @membro = Membro.find(params[:membro_id])
    @contribuicao = @membro.contribuicaos.build
    @contribuicao.data = Time.new.to_date
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

  def report
    index
    respond_to do |format|
      format.pdf do
        pdf = ContribuicaoMembroReport.new(@contribuicoes)

        send_data pdf.render, filename: "membros_contribuicoes_report.pdf", type: "application/pdf", disposition: "inline"
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
