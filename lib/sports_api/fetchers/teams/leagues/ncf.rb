require_relative '../helpers/api_parser'

class SportsApi::Fetcher::Team::NCF < SportsApi::Fetcher::Team
  include SportsApi::Fetcher::ESPN::Api
  include SportsApi::Fetcher::Team::ApiParser

  def initialize(team_id = nil)
    self.team_id = team_id
  end

  def self.find_all
    new().response
  end

  def self.find_one(team_id)
    new(team_id).response
  end

  def self.league
    SportsApi::NCF
  end

  def league
    self.class.league
  end

  private

  def json
    @json ||= teams('football', 'college-football', team_id, limit: 300, groups: 80)
  end
end
