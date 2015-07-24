require 'spec_helper'

RSpec.describe FootballApi::Event do
  context 'events from fixtures' do
    let(:fixtures_date) { '23.07.2015' }
    let(:default)  { JSONHelper::Fixtures.get(:match_date_2015) }
    let(:uri) {
      "#{@base_url}/api/?APIKey=#{@api_key}&Action=fixtures&match_date=#{fixtures_date}"
    }

    before(:each) do
      stub_request(:get, uri)
      .with(headers: @headers)
      .to_return(status: 200, body: default.to_json)
    end

    let(:request_response) { FootballApi::Fixture.where(match_date: fixtures_date) }

    let(:fixture) {request_response[23]}
    let(:match) { fixture.match }

    let(:local_goal) { fixture.match_events[2] }
    let(:away_goal) { fixture.match_events[0] }
    let(:visitor_red_card) { fixture.match_events[1] }
    let(:local_yellow_card) { fixture.match_events[4] }

    describe '.new red_card' do
      it 'has all values' do
        expect(visitor_red_card.event_id).not_to be_nil
        expect(visitor_red_card.event_type).to eq("redcard")
        expect(visitor_red_card.event_team).to eq("visitorteam")

        expect(visitor_red_card.event_match_id).to eq(match.match_id)
        expect(visitor_red_card.event_minute).not_to be_nil

        expect(visitor_red_card.event_player).not_to be_nil
        expect(visitor_red_card.event_player_id).not_to be_empty
        expect(visitor_red_card.event_result).to be_empty
      end
    end

    describe '.new yellow_card' do
      it 'has all values' do
        expect(local_yellow_card.event_id).not_to be_nil
        expect(local_yellow_card.event_type).to eq("yellowcard")
        expect(local_yellow_card.event_team).to eq("localteam")

        expect(local_yellow_card.event_match_id).to eq(match.match_id)
        expect(local_yellow_card.event_minute).not_to be_nil

        expect(local_yellow_card.event_player).not_to be_nil
        expect(local_yellow_card.event_player_id).not_to be_empty

        expect(local_yellow_card.event_result).to be_empty
      end
    end

    describe '.new local_goal' do
      it 'has all values' do
        expect(local_goal.event_id).not_to be_nil
        expect(local_goal.event_type).to eq("goal")
        expect(local_goal.event_team).to eq("localteam")

        expect(local_goal.event_match_id).to eq(match.match_id)
        expect(local_goal.event_minute).not_to be_nil

        expect(local_goal.event_player).not_to be_nil
        expect(local_goal.event_player_id).not_to be_empty

        expect(local_goal.event_result).not_to be_empty
      end
    end

    describe '.new visitor_goal' do
      it 'has all values' do
        expect(away_goal.event_id).not_to be_nil
        expect(away_goal.event_type).to eq("goal")
        expect(away_goal.event_team).to eq("visitorteam")

        expect(away_goal.event_match_id).to eq(match.match_id)
        expect(away_goal.event_minute).not_to be_nil

        expect(away_goal.event_player).not_to be_nil
        expect(away_goal.event_player_id).not_to be_empty

        expect(away_goal.event_result).not_to be_empty
      end
    end
  end
end
