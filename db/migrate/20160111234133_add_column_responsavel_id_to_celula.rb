class AddColumnResponsavelIdToCelula < ActiveRecord::Migration
  def change
    add_column :celulas, :responsavel_id, :integer
  end
end
