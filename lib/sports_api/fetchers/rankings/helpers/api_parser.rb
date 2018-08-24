module SportsApi::Fetcher::Ranking::ApiParser
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
    
      ## Build Event
      league.rankings = generate_rankings
    end
  end

  def generate_rankings
    json['rankings'].map do |ranking_json|
      SportsApi::Model::Ranking.new.tap do |ranking|
        ranking.name = ranking_json['name']
        ranking.short_name = ranking_json['shortName']
        ranking.ranks = generate_ranks(ranking_json)
      end
    end
  end

  def generate_ranks(ranking_json)
    ranking_json['ranks'].map do |rank_json|
      SportsApi::Model::Rank.new.tap do |rank|
        rank.current = rank_json['current']
        rank.team = generate_team(rank_json['team'])
      end
    end
  end

    def generate_team(team_json)
    SportsApi::Model::Team.new.tap do |team|
      team.id = team_json['id']
      team.location = team_json['location']
      team.name = team_json['name']
      team.nickname = team_json['nickname']
      team.abbreviation = team_json['abbreviation']
      team.display_name = team_json['displayName']
      team.short_display_name = team_json['shortDisplayName']
      team.color = team_json['color']
      team.alternate_color = team_json['alternateColor'] || '00000'
      team.is_active = team_json['isActive']
      team.conference_id = team_json['conferenceId']
    end
  end
end
