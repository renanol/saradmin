class PessoaContato < ActiveRecord::Base

  belongs_to :pessoa
  belongs_to :contato

end
