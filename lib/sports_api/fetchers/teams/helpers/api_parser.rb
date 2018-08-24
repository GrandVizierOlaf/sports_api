module SportsApi::Fetcher::Team::ApiParser
  attr_accessor :league

  def response
    if self.team_id
      generate_team
    else
      generate_teams
    end
  end

  def generate_team
    team_json = json

    SportsApi::Model::Team.new.tap do |team|
      team.id = team_json['team']['id']
      team.location = team_json['team']['location']
      team.name = team_json['team']['name']
      team.nickname = team_json['team']['nickname']
      team.abbreviation = team_json['team']['abbreviation']
      team.display_name = team_json['team']['displayName']
      team.short_display_name = team_json['team']['shortDisplayName']
      team.color = team_json['team']['color']
      team.alternate_color = team_json['team']['alternateColor'] || '00000'
      team.is_active = team_json['team']['isActive']
      team.conference_id = team_json['team']['conferenceId']
    end
  end

  def generate_teams
    league_json = json['sports'].first['leagues'].first

    league_json['teams'].map do |team_json|
      SportsApi::Model::Team.new.tap do |team|
        team.id = team_json['team']['id']
        team.location = team_json['team']['location']
        team.name = team_json['team']['name']
        team.nickname = team_json['team']['nickname']
        team.abbreviation = team_json['team']['abbreviation']
        team.display_name = team_json['team']['displayName']
        team.short_display_name = team_json['team']['shortDisplayName']
        team.color = team_json['team']['color']
        team.alternate_color = team_json['team']['alternateColor'] || '00000'
        team.is_active = team_json['team']['isActive']
        team.conference_id = team_json['team']['conferenceId']
      end
    end
  end
end
