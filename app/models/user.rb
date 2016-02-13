# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  grupo_id               :integer
#  name                   :string
#  status                 :integer
#

class User < ActiveRecord::Base
  after_initialize :set_default_attr, :if => :new_record?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile
  belongs_to :grupo

  has_many :user_igrejas
  has_many :igrejas, through: :user_igrejas

  enum status: [:ativo, :cancelado]

  scope :todos, -> {where(['grupo_id <> ?', 1])}

  def set_default_attr
    self.grupo ||= Grupo.find(3)
    self.status ||= :ativo
  end

  def active_for_authentication?
    super && self.ativo?
  end

  def admin?
    self.grupo_id == 1 || self.grupo_id == 2
  end

  def permissao(perm)
    permissao = Permissao.find_by_alias(perm)
    GrupoPermissao.find_by(grupo_id: self.grupo_id, permissao_id: permissao.id)
  end

  def tem_permissao(permissoes)
    permissoes.each do |perm|
      gp = self.permissao(perm)
      if gp.permissao.acesso?
        if not gp.nenhuma?
          return true
        end
      elsif gp.permissao.sim_nao? && gp.sim?
        return true
      end
    end
    return false
  end

  def igrejas_ids
    ids = Array.new
    self.user_igrejas.each do |ie|
      ids << ie.igreja_id
    end
    return ids
  end

  def redes_ids
    ids = Array.new
    Rede.where(igreja_id: self.igrejas_ids).each do |r|
      ids << r.id
    end
    return ids
  end

  def equipes_ids
    ids = Array.new
    Equipe.where(rede_id: self.redes_ids).each do |e|
      ids << e.id
    end
    return ids
  end

  def sub_equipes_ids
    ids = Array.new
    SubEquipe.where(equipe_id: self.equipes_ids).each do |se|
      ids << se.id
    end
    return ids
  end

  def celulas_ids
    ids = Array.new
    Celula.where(sub_equipe_id: self.sub_equipes_ids).each do |c|
      ids << c.id
    end
    return ids
  end

end
