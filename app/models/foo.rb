# == Schema Information
#
# Table name: foos
#
#  id          :integer          not null, primary key
#  description :string
#  number      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Foo < ActiveRecord::Base
  validates :description, presence: true
end
