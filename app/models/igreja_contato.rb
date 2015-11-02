class IgrejaContato < ActiveRecord::Base
  belongs_to :contato
  belongs_to :igreja

  accepts_nested_attributes_for :igreja
  accepts_nested_attributes_for :contato

end
