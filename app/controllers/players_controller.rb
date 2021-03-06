class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]

  # GET /players
  # GET /players.json
  def index
    team_id=params[:team_id]
    @players = Player.where(team_id: team_id)
    @players = Player.all if @players.blank? && !params[:team_id].present?

  end

  # GET /players/1
  # GET /players/1.json
  def show
  end

  # GET /players/new
  def new
    @player = Player.new
    @teams = Team.all
  end

  # GET /players/1/edit
  def edit
    @teams = Team.all
  end

  def search 
    @players = Player.order(:first_name,:last_name).where("(first_name like ? or id = ? or tshirt_number = ? or last_name like ?) and team_id=? and status=0","%#{params[:term]}%",params[:term],params[:term],"%#{params[:term]}%",params[:team_id])
    render json: @players
  end


  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        format.html { redirect_to '/players?team_id=' << @player.team_id.to_s, notice: 'Player was successfully created.' }
        format.json { render :show, status: :created, location: @player }
      else
        format.html { render :new }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url, notice: 'Player was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:first_name, :last_name, :telefono, :email, :movil, :number_id, :team_id,:term,:tshirt_number,:foto)
    end
end
