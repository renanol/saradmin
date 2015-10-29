class CreateFoos < ActiveRecord::Migration
  def change
    create_table :foos do |t|
      t.string :description
      t.integer :number

      t.timestamps null: false
    end
  end
end
