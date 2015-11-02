class UsuariosController < ApplicationController

  def index
    @users = User.all
  end
  
end
