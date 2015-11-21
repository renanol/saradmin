class Cargo < ActiveRecord::Base

  def lidera
    if lideranca
      'SIM'
    else
      'NAO'
    end
  end

end
