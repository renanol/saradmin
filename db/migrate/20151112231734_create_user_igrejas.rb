class CreateUserIgrejas < ActiveRecord::Migration
  def change
    create_table :user_igrejas do |t|

      t.timestamps null: false
    end
  end
end
