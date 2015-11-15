class UserIgreja < ActiveRecord::Base

  belongs_to :user
  belongs_to :igreja

end
