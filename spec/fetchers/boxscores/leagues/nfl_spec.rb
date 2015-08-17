require 'spec_helper'

describe SportsApi::Fetcher::Boxscore::NFL do
  describe '#find' do
    let(:gameid) { 400791773 }
    let(:find) { SportsApi::Fetcher::Boxscore::NFL.find(gameid) }
    let(:json_stub_week_1) { StubbedJson.get('postgame-week-1.json') }
    let(:json_stub_week_2) { StubbedJson.get('postgame-week-2.json') }
    let(:html_stub) { StubbedHtml.get('400791773.html') }
    let(:expect_instance) { allow_any_instance_of(SportsApi::Fetcher::Score::NFL) }
    before { expect_instance.to receive(:get).with('football', 'nfl', week: 1, seasontype: 1).and_return(json_stub_week_2) }
    before { expect_instance.to receive(:get).with('football', 'nfl', week: 2, seasontype: 1).and_return(json_stub_week_2) }
    before { expect_any_instance_of(SportsApi::Fetcher::Boxscore::NFL).to receive(:get).with('nfl/boxscore', gameId: gameid).and_return(html_stub) }

    context 'event info' do
      it { expect(find.score.date).to eq(Date.new(2015, 8, 16)) }
    end
  end
end