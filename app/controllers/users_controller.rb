class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
    @roles = Role.all
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to '/admin/users', notice: 'Usuario creado correctamente.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:user).permit(:first_name, :last_name, :email,:number_id,:password)
    end


end