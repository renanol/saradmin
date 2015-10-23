class DashboardController < ApplicationController

  def index
    @users = User.all
    authorize :dashboard, :index?
  end

  def clear
  end

end
