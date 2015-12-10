class AddColumnCargoIdToMembro < ActiveRecord::Migration
  def change
    add_column :membros, :cargo_id, :integer
  end
end
