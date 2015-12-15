class AddColumnMembroIdToIgrejas < ActiveRecord::Migration
  def change
    add_column :igrejas, :membro_id, :integer
  end
end
