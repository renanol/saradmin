class AddColumnResponsavelIdToRedes < ActiveRecord::Migration
  def change
    add_column :redes, :responsavel_id, :integer
  end
end
