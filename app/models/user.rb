class User < ActiveRecord::Base
  after_initialize :set_default_role, :if => :new_record?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile

  enum role: [:admin, :default]

  def set_default_role
    self.role ||= :default
  end

end
