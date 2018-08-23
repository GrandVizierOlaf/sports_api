class SportsApi::Fetcher::Team
  attr_accessor :date,
                :week

  def self.find(league, id)
    case league
    when SportsApi::NFL
      SportsApi::Fetcher::Team::NFL.find(id)
    when SportsApi::NCF
      SportsApi::Fetcher::Team::NCF.find(id)
    when SportsApi::NBA
      SportsApi::Fetcher::Team::NBA.find(id)
    when SportsApi::MLB
      SportsApi::Fetcher::Team::MLB.find(id)
    end
  end

end
