class AddColumnResponsavelIdToEquipes < ActiveRecord::Migration
  def change
    add_column :equipes, :responsavel_id, :integer
  end
end
