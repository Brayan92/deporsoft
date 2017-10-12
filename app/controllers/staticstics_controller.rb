
class StaticsticsController < ApplicationController
    def table_positions

	    @scores = []

	    if params[:championship_id].present?
	       @scores =  Report::TableScore.score.where(championship_id:params[:championship_id]).order('puntos DESC')
	    end
    end

    def table_players_goals
	    @events = []
	    if params[:championship_id].present? && params[:event_id].present?
	       @events = Report::PlayersGoals.events.where(championship_id:params[:championship_id],event_id:params[:event_id]).order('cantidad DESC')
	    else
               @events = Report::PlayersGoals.events.where(championship_id:params[:championship_id],event_id:3).order('cantidad DESC')
            end
    end
  end




