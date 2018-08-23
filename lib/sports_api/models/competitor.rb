class SportsApi::Model::Competitor
  attr_accessor :type,
                :home_away,
                :score,
                :winner,
                :data_name,
                :name,
                :location,
                :abbreviation,
                :display_name,
                :short_display_name,
                :color,
                :alternate_color,
                :is_active,
                :overall_record,
                :home_record,
                :away_record,
                :conference_record,
                :id,
                :linescores,
                :rank,
                :conference_id

  def rank=(rank)
    @rank = rank == 99 ? nil : rank.to_s
  end
end
