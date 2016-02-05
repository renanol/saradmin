class AddColumnPaisIdToEstados < ActiveRecord::Migration
  def change
    add_column :estados, :pais_id, :integer
  end
end
