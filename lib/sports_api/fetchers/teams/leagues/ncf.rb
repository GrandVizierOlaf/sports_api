require_relative '../helpers/api_parser'

class SportsApi::Fetcher::Team::NCF < SportsApi::Fetcher::Team
  include SportsApi::Fetcher::ESPN::Api
  include SportsApi::Fetcher::Team::ApiParser

  def initialize(week)
    self.week = week
  end

  def self.find(id)
    SportsApi::Fetcher::Team::NCF.find_by(id)
  end

  def response
    generate_league
  end

  def self.league
    SportsApi::NCF
  end

  def league
    self.class.league
  end

  private

  def json
    @json ||= teams('football', 'college-football', week: week, limit: 300, groups: 80)
  end
end
