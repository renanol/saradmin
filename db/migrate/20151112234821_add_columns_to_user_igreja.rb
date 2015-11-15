class AddColumnsToUserIgreja < ActiveRecord::Migration
  def change
    add_column :user_igrejas, :user_id, :integer
    add_column :user_igrejas, :igreja_id, :integer
  end
end
