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
    this.user_igrejas.each do |ie|
      ids << ie.igreja_id
    end
    return ids
  end

end