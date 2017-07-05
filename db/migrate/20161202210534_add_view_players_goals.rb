class AddViewPlayersGoals < ActiveRecord::Migration[5.0]
  def up
    sql = <<-SQL
		create view players_goals as 
		     select max(p.id)  as id,
				    concat (max(p.first_name)," ",max(p.last_name)) as nombre,
		            max(t.name) as equipo,
		            count(d.event_id) as cantidad,
		            max(m.championship_id) as championship_id,
		            max(d.event_id) as event_id
				 from details_matches d
		     left join players p on d.player_id = p.id
		     left join teams t   on d.team_id   = t.id
		     left join matches m on d.match_id  = m.id
		     group by d.player_id
    SQL
    execute sql
  end  	
  def down
    execute "DROP view players_goals"
  end
end
