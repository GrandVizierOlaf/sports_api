require 'faraday'
require 'nokogiri'
require 'json'

module SportsApi::Fetcher
  module ESPN
    module Api
      def get(league_string, league, page, params)
        url = "http://site.api.espn.com/apis/site/v2/sports/#{league_string}/#{league}/#{page}"
        response = Http.get(url, params)
        if response.status == 200
          JSON.parse(response.body)
        else
          raise ArgumentError, "invalid URL: #{url}"
        end
      end

      def rankings(league_string, league, params)
        get(league_string, league, 'rankings', params)
      end

      def scoreboard(league_string, league, params)
        get(league_string, league, 'scoreboard', params)
      end

      def teams(league_string, league, team_id, params)
        if team_id
          get(league_string, league, "teams/#{team_id}", params)
        else
          get(league_string, league, 'teams', params)
        end
      end
    end

    module Scraper
      def url(path)
        ['http:/', domain, *path].join('/')
      end

      def domain
        'espn.go.com'
      end

      def get(path, params)
        http_url = self.url(*path)
        response = Http.get(http_url,params)
        if response.status == 200
          Nokogiri::HTML(response.body)
        else
          raise ArgumentError, error_message(url, path)
        end
      end

      def error_message(url, path)
        "The url #{url} from the path #{path} did not return a valid page."
      end
    end
  end

  class Http
    attr_accessor :body,
                  :status

    def initialize(status, body)
      self.status = status
      self.body   = body
    end

    def self.get(url, params)
      response = Faraday.get(url, params.merge(timeout: 10))
      new(response.status, response.body)
    end
  end
end
