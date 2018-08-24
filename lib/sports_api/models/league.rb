class SportsApi::Model::League
  CALENDAR_TYPES = [
    DAY = 'day',
    LIST = 'list'
  ]

  attr_accessor :name,
                :abbreviation,
                :calendar_type,
                :calendar,
                :events,
                :teams

  def calendar=(events)
    @calendar ||= events
  end
end
