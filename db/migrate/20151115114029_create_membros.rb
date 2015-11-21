class CreateMembros < ActiveRecord::Migration
  def change
    create_table :membros do |t|

      t.timestamps null: false
    end
  end
end
