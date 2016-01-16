class AddColumnResponsavelIdToSubEquipes < ActiveRecord::Migration
  def change
    add_column :sub_equipes, :responsavel_id, :integer
  end
end
