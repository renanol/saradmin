class AddColumnMembroIdToContribuicao < ActiveRecord::Migration
  def change
    add_column :contribuicoes, :membro_id, :integer
  end
end
