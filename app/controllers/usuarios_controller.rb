class UsuariosController < ApplicationController
  before_action :set_usuario, except: [:index, :new, :create]

  def index
    @tela = 'Listar Usuários'
    @usuarios = User.todos
    @grupo_opts = Grupo.todos.ativos.collect.map do |g|
      [g.descricao, g.id]
    end
  end

  def show

  end

  def new
    @tela = 'Cadastrar Usuário'
    @action = 'create'
    @usuario = User.new
    @grupo_opts = Grupo.todos.ativos.collect.map do |g|
      [g.descricao, g.id]
    end
    @igrejas = Igreja.all
  end

  def create
    @usuario = User.new(usuario_params)
    @usuario.password = '123mudar'
    @usuario.password_confirmation = '123mudar'
    @usuario.status = User.status[:ativo]

    params[:igreja].each do |igreja|
      if igreja[1][:id] == '1'
        @usuario.user_igrejas.build(igreja_id: igreja[0])
      end
    end

    respond_to do |format|
      if @usuario.save
        format.html { redirect_to usuarios_path, notice: 'Usuário cadastrado com sucesso.' }
        format.json { render :show, status: :created, location: usuarios_path }
      else
        format.html { render :new }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @tela = 'Alterar Usuário'
    @action = 'update'
    @grupo_opts = Grupo.todos.ativos.collect.map do |g|
      [g.descricao, g.id]
    end
    @igrejas = Igreja.all.order(:descricao)
  end

  def update

    @usuario.user_igrejas.each do |ui|
      ui.destroy
    end

    params[:igreja].each do |igreja|
      if igreja[1][:id] == '1'
        @usuario.user_igrejas.build(igreja_id: igreja[0])
      end
    end

    respond_to do |format|
      if @usuario.update(usuario_params)
        format.html { redirect_to usuarios_path, notice: 'Usuário alterado com sucesso.' }
        format.json { render :index, status: :ok, location: usuarios_path }
      else
        format.html { render :edit }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  def reset_password
    @usuario.update_attributes(password: '123mudar', password_confirmation: '123mudar')
    flash[:notice] = 'Senha resetada com sucesso!'
    redirect_to usuarios_path
  end

  def change_grupo
    @usuario.update_attributes(grupo_id: params[:grupo_id])
    flash[:notice] = 'Grupo alterado com sucesso!'
    redirect_to usuarios_path
  end

  def ativar
    @usuario.update_attributes(status: User.status[:ativo])
    flash[:notice] = 'Usuario ativado com sucesso!'
    redirect_to usuarios_path
  end

  def bloquear
    @usuario.update_attributes(status: User.status[:cancelado])
    flash[:notice] = 'Usuario cancelado com sucesso!'
    redirect_to usuarios_path
  end

  private
  def set_usuario
    @usuario = User.find(params[:id])
  end

  def usuario_params
    params.require(:user).permit(:name, :email, :grupo_id, igreja:[:id])
  end

end
