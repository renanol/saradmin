class UsuarioForm

  include ActiveModel::Model

  attr_accessor :user, :grupo, :igreja

  def self.user_attributes
    User.column_names.push(User.reflections.keys)
  end

  def self.grupo_attributes
    Grupo.column_names.push(Grupo.reflections.keys)
  end

  def self.igreja_attributes
    Igreja.column_names.push(Igreja.reflections.keys)
  end

  user_attributes.each do |attr|
    delegate attr.to_sym, "#{attr}=".to_sym, to: :user
  end

  grupo_attributes.each do |attr|
    delegate attr.to_sym, "#{attr}=".to_sym, to: :grupo
  end

  igreja_attributes.each do |attr|
    delegate attr.to_sym, "#{attr}=".to_sym, to: :igreja
  end

  delegate :id, :persisted?, to: :user

end