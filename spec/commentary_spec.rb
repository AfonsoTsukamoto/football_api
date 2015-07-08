require 'spec_helper'

RSpec.describe FootballApi::Commentary do
  let(:match_id) { 1788007 }
  let(:static_id) { 1755579 }
  let(:default)  { JSONHelper::Commentaries.get(:default) }
  let(:uri) {
    "#{@base_url}/api/?APIKey=#{@api_key}&Action=commentaries&match_id=#{match_id}"
  }

  before do
    stub_request(:get, uri)
      .with(headers: @headers)
      .to_return(status: 200, body: default.to_json)
  end

  describe '.all_from_match' do
    it 'sets match id' do
      res = FootballApi::Commentary.all_from_match(match_id)
      # TODO: Really weird. while asking for the game 1788007, api
      # returns
      # { match_id: "1788007", comm_static_id: "1755579" }
      # and then comm_static_id is on the actual match... fuckin no sense!
      # Gotta find a turn around (changing api??)

      binding.pry

      expect(res).not_to be_nil
      expect(res.static_id.to_i).to eq(static_id)
    end

    it 'sets all match summary cards' do
      res = FootballApi::Commentary.all_from_match(match_id)
      summary = res.match_summary

      expect(summary).not_to be_nil
      expect(summary.local_team_yellowcards.size).to eq(2)
      expect(summary.local_team_redcards.size).to eq(0)
      expect(summary.visitor_team_yellowcards.size).to eq(4)
      expect(summary.visitor_team_redcards.size).to eq(0)
    end

    it 'sets all match summary goals' do
      res = FootballApi::Commentary.all_from_match(match_id)
      summary = res.match_summary

      expect(summary).not_to be_nil
      expect(summary.local_team_goals.size).to eq(1)
      expect(summary.visitor_team_goals.size).to eq(2)
    end
  end
end