
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
	        sql = 'select t.name as equipo,p.id as id , concat(p.first_name," ",p.last_name) as nombre,e.name as evento,e.id,count(e.id)as cantidad from details_matches d inner join players p on p.id=d.player_id inner join events e on e.id=d.event_id inner join teams t on t.id = d.team_id where e.id = ' << params[:event_id].to_s << ' event_id group by p.id,t.id order by cantidad DESC'
			@events = ActiveRecord::Base.connection.execute(sql)	    	
	    else
	        sql = 'select t.name as equipo,p.id as id , concat(p.first_name," ",p.last_name) as nombre,e.name as evento,e.id,count(e.id)as cantidad from details_matches d inner join players p on p.id=d.player_id inner join events e on e.id=d.event_id inner join teams t on t.id = d.team_id where e.id = 3 group by p.id,t.id order by cantidad DESC'
			@events = ActiveRecord::Base.connection.execute(sql)	    	
        end
    end
end
