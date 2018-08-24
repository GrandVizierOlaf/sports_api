class SportsApi::Fetcher::Ranking
  attr_accessor :date,
                :week

  def self.find(league, date)
    case league
    when SportsApi::NFL
      SportsApi::Fetcher::Ranking::NFL.find(date)
    when SportsApi::NCF
      SportsApi::Fetcher::Ranking::NCF.find(date)
    when SportsApi::NBA
      SportsApi::Fetcher::Ranking::NBA.find(date)
    when SportsApi::MLB
      SportsApi::Fetcher::Ranking::MLB.find(date)
    end
  end

  private

  def self.date_list(date)
    date_obj = SportsApi::Fetcher::Calendar.find(league).detect do |list|
      (list.start_date < date) && (date < list.end_date)
    end

    ## if no date found, try removing a day
    unless date_obj
      date = date - 1
      return SportsApi::Fetcher::Calendar::find(league).detect do |list|
        (list.start_date <= date) && (date <= list.end_date)
      end
    end

    date_obj
  end

end
