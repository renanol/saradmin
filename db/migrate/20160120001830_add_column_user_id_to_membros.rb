class AddColumnUserIdToMembros < ActiveRecord::Migration
  def change
    add_column :membros, :user_id, :integer
  end
end
