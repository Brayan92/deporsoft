
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
	        sql = 'select p.id as id , concat(p.first_name," ",p.last_name) as jugador,e.name as evento,e.id,count(e.id)as cantidad from details_matches inner join players p on p.id=player_id inner join events e on e.id=event_id where e.id = 3 group by p.id order by cantidad DESC'
			@events = ActiveRecord::Base.connection.execute(sql)	    	
	    else
	        sql = 'select p.id as id , concat(p.first_name," ",p.last_name) as jugador,e.name as evento,e.id,count(e.id)as cantidad from details_matches inner join players p on p.id=player_id inner join events e on e.id=event_id where e.id = 3 group by p.id order by cantidad DESC'
			@events = ActiveRecord::Base.connection.execute(sql)	    	
        end
    end
end
