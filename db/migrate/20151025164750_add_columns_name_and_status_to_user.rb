class AddColumnsNameAndStatusToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :status, :integer
  end
end
