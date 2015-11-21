class AddColumnPessoaIdToMembro < ActiveRecord::Migration
  def change
    add_column :membros, :pessoa_id, :integer
  end
end
