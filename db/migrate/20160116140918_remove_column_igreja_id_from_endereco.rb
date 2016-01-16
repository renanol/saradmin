class RemoveColumnIgrejaIdFromEndereco < ActiveRecord::Migration
  def change
    Endereco.where('igreja_id IS NOT NULL').each do |ed|
      IgrejaEndereco.create(endereco_id: ed.id, igreja_id: ed.igreja_id, descricao: 'Principal')
    end

    remove_column :enderecos, :igreja_id
  end
end
