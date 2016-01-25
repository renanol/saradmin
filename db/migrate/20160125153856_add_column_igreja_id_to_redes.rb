class AddColumnIgrejaIdToRedes < ActiveRecord::Migration
  def change
    add_column :redes, :igreja_id, :integer
  end
end
