# == Schema Information
#
# Table name: user_igrejas
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  igreja_id  :integer
#

class UserIgreja < ActiveRecord::Base

  belongs_to :user
  belongs_to :igreja

end
