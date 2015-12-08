class PessoaEndereco < ActiveRecord::Base

  belongs_to :pessoa
  belongs_to :endereco

end
