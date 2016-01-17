class PessoaEndereco < ActiveRecord::Base

  belongs_to :pessoa
  belongs_to :endereco

  accepts_nested_attributes_for :endereco

end
