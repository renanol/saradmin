class AddColumIgrejaIdToMembro < ActiveRecord::Migration
  def change
    add_column :membros, :igreja_id, :integer
  end
end
