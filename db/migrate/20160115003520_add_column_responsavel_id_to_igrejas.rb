class AddColumnResponsavelIdToIgrejas < ActiveRecord::Migration
  def change
    add_column :igrejas, :responsavel_id, :integer
  end
end
