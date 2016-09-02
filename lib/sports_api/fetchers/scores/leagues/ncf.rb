require_relative '../helpers/api_parser'

class SportsApi::Fetcher::Score::NCF < SportsApi::Fetcher::Score
  include SportsApi::Fetcher::ESPN::Api
  include SportsApi::Fetcher::Score::ApiParser

  def initialize(week)
    self.week = week
  end

  def self.find(date)
    date_obj = date_list(date)

    date_obj ? SportsApi::Fetcher::Score::NCF.find_by(date_obj.week) : nil
  end

  def self.find_by(week)
    new(week).response
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

  def generate_calendar(calendar_json)
    generate_calendar_list(calendar_json)
  end

  def generate_situation(situation_json)
    SportsApi::Model::Situation::Ncf.new.tap do |situation|
      situation.last_play = generate_last_play(situation_json['lastPlay'])
      situation.down = situation_json['down']
      situation.yard_line = situation_json['yardLine']
      situation.distance = situation_json['distance']
      situation.down_distance_text = situation_json['downDistanceText']
      situation.is_red_zone = situation_json['isRedZone']
      situation.home_timeouts = situation_json['homeTimeouts']
      situation.away_timeouts = situation_json['awayTimeouts']
      situation.possession = situation_json['possession']
    end
  end

  def generate_last_play(last_play_json)
    SportsApi::Model::LastPlay::Ncf.new.tap do |last_play|
      last_play.type = last_play_json["type"]["text"]
      last_play.text = last_play_json["text"]
      last_play.score_value = last_play_json["scoreValue"]
      last_play.team = last_play_json["team"]["id"]
      last_play.drive = last_play_json["drive"]["description"]
      last_play.start_yard_line = last_play_json["start"]["yardLine"]
      last_play.start_time_side = last_play_json["start"]["team"]["id"]
      last_play.finish_yard_line = last_play_json["end"]["yardLine"]
      last_play.finish_time_side = last_play_json["end"]["team"]["id"]
      last_play.stat_yardage = last_play_json["statYardage"]
    end
  end

  def json
    @json ||= get('football', 'college-football', week: week, limit: 300, groups: 80)
  end
end
