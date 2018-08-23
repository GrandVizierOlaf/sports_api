module SportsApi::Fetcher::Team::ApiParser
  attr_accessor :league

  def response
    generate_league
  end

  def generate_league
    SportsApi::Model::League.new.tap do |league|
      league_json = json['leagues'].first

      ## Build League
      league.name = league_json['name']
      league.abbreviation = league_json['abbreviation']
      league.calendar_type = league_json['calendarType']
      league.calendar = generate_calendar(league_json['calendar'])

      ## Build Event
      league.events = generate_events
    end
  end

  def generate_teams
    json['teams'].map do |event_json|
      SportsApi::Model::Team.new.tap do |team|
        team.id = event_json['id']
        team.location = event_json['location']
        team.name = event_json['name']
        team.nickname = event_json['nickname']
        team.abbreviation = event_json['abbreviation']
        team.display_name = event_json['displayName']
        team.short_display_name = event_json['shortDisplayName']
        team.color = event_json['color']
        team.alternate_color = event_json['alternateColor'] || '00000'
        team.is_active = event_json['isActive']
        team.conference_id = event_json['conferenceId']
      end
    end
  end
end
