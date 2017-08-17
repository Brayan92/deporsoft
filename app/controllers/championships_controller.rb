class ChampionshipsController < ApplicationController
  before_action :set_championship, only: [:show, :edit, :update, :destroy]

  # GET /championships
  # GET /championships.json
  def index
    @championships = Championship.all
  end

  # GET /championships/1
  # GET /championships/1.json
  def show
    @days = { 1 => "Lunes",
                2 => "Martes",
                3 => "Miercoles",
                4 => "Jueves",
                5 => "Viernes",
                6 => "Sabado",
                7 => "Domingo",
         }
  end

  # GET /championships/new
  def new
    @championship = Championship.new
    @days = { 1 => "Lunes",
                2 => "Martes",
                3 => "Miercoles",
                4 => "Jueves",
                5 => "Viernes",
                6 => "Sabado",
                7 => "Domingo",
         }
  end

  # GET /championships/1/edit
  def edit
    @days = { 1 => "Lunes",
                2 => "Martes",
                3 => "Miercoles",
                4 => "Jueves",
                5 => "Viernes",
                6 => "Sabado",
                7 => "Domingo",
         }
  end

  # POST /championships
  # POST /championships.json
  def create
    set_days_game
    @championship = Championship.new(championship_params)
    respond_to do |format|
      if @championship.save
        format.html { redirect_to '/championships', notice: 'Campeonato creado correctamente.' }
        format.json { render :show, status: :created, location: @championship }
      else
        format.html { render :new }
        format.json { render json: @championship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /championships/1
  # PATCH/PUT /championships/1.json
  def update
    respond_to do |format|
    set_days_game
    puts params
      if @championship.update(championship_params)
        format.html { redirect_to @championship, notice: 'Campeonato actulizado correctamente.' }
        format.json { render :show, status: :ok, location: @championship }
      else
        format.html { render :edit }
        format.json { render json: @championship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /championships/1
  # DELETE /championships/1.json
  def destroy
    @championship.destroy
    respond_to do |format|
      format.html { redirect_to championships_url, notice: 'Championship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_championship
      @championship = Championship.find(params[:id])
    end
    def set_days_game
      params[:championship][:game_days] = params[:days].join(',')
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def championship_params
      params.require(:championship).permit(:name, :quantity_min_teams, :date_initial_inscription, :date_end_inscription, :match_duration, :matches_simultanius, :game_days)
    end
end
