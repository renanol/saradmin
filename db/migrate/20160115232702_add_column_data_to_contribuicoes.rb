class AddColumnDataToContribuicoes < ActiveRecord::Migration
  def change
    add_column :contribuicoes, :data, :date
  end
end
