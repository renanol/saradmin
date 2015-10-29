class User < ActiveRecord::Base
  after_initialize :set_default_attr, :if => :new_record?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile
  belongs_to :grupo

  enum status: [:ativo, :cancelado]

  def set_default_attr
    self.grupo ||= Grupo.find(3)
    self.status ||= :ativo
  end

  def admin?
    self.grupo_id == 1 || self.grupo_id == 2
  end

end
