class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy] 
  def index
    @users = User.all
  end

  def new
    @user = User.new
    @roles = Role.all
  end

  def edit
    @roles = Role.all
  end
  def show
  end


  def create
    @user = User.new(user_params)
    @user.roles = []
    respond_to do |format|
      if @user.save
        save_role
        format.html { redirect_to '/admin/users', notice: 'Usuario creado correctamente.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Usuario borrado.' }
      format.json { head :no_content }
    end
  end

  def update
    if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
    end    
    respond_to do |format|
      if @user.update(user_params)
        save_role
        format.html { redirect_to @user, notice: 'Usuario actulizado.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
    def save_role
        @user.roles = []
        @user.save
        if params[:roles].present?
           params[:roles].each do |value|
              if !@user.has_role? value
                  @user.add_role value
              end
           end
        end

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email,:number_id,:password)
    end


end