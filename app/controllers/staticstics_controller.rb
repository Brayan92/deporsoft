
class StaticsticsController < ApplicationController
    def table_positions

	    @scores = []

	    if params[:championship_id].present?
	       @scores =  Report::TableScore.score.where(championship_id:params[:championship_id])
	    end
    end

    def table_players_goals
	    @events = []
	    if params[:championship_id].present?
	       @events = Report::PlayersGoals.events.where(championship_id:params[:championship_id])
	    end
    end
  end




