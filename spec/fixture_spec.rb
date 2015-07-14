require 'spec_helper'

RSpec.describe FootballApi::Fixture do
  let(:competition_id) { 1204 }

  describe '.where from_to_date ' do
    let(:response)   { JSONHelper::Fixtures.get(:from_to_date) }

    let(:from_date) { '01.01.2015' }
    let(:to_date) { '01.02.2015' }
    let(:from_to_parameters) {
      { :comp_id => competition_id, :from_date => from_date, :to_date => to_date }
    }
    let(:uri) {
      "#{@base_url}/api/?APIKey=#{@api_key}&Action=fixtures"\
      "&comp_id=#{competition_id}&from_date=#{from_date}&to_date=#{to_date}"
    }

    before(:each) do
      stub_request(:get, uri)
      .with(headers: @headers)
      .to_return(status: 200, body: response.to_json)
    end

    let(:request_response) { FootballApi::Fixture.where(from_to_parameters) }

    it 'not_fails' do
      expect(request_response).not_to be_nil
      expect(request_response.size).to eq(40)
    end

    it 'has_first_match' do
      fixture = request_response.first
      expect(fixture.match).not_to be_nil
      expect(fixture.match.match_comp_id.to_i).to eq(competition_id)
      expect(fixture.match_events.size).to eq(2)
      expect(fixture.match_timer).to be_blank
    end

    it 'has_last_match' do
      fixture = request_response.last
      expect(fixture.match).not_to be_nil
      expect(fixture.match.match_comp_id.to_i).to eq(competition_id)
      expect(fixture.match_events.size).to eq(4)
      expect(fixture.match_timer).to be_blank
    end
  end

  describe '.where match_date ' do
    let(:response)   { JSONHelper::Fixtures.get(:match_date) }

    let(:match_date) { '01.01.2015' }
    let(:date_parameters) {
      { :comp_id => competition_id, :match_date => match_date }
    }
    let(:uri) {
      "#{@base_url}/api/?APIKey=#{@api_key}&Action=fixtures"\
      "&comp_id=#{competition_id}&match_date=#{match_date}"
    }

    before(:each) do
      stub_request(:get, uri)
      .with(headers: @headers)
      .to_return(status: 200, body: response.to_json)
    end

    let(:request_response) { FootballApi::Fixture.where(date_parameters) }

    it 'not_fails' do
      expect(request_response).not_to be_nil
      expect(request_response.size).to eq(10)
    end

    it 'has_first_match' do
      fixture = request_response.first
      expect(fixture.match).not_to be_nil
      expect(fixture.match.match_comp_id.to_i).to eq(competition_id)
      expect(fixture.match_events.size).to eq(2)
      expect(fixture.match_timer).to be_blank
    end

    it 'has_last_match' do
      fixture = request_response.last
      expect(fixture.match).not_to be_nil
      expect(fixture.match.match_comp_id.to_i).to eq(competition_id)
      expect(fixture.match_events.size).to eq(12)
      expect(fixture.match_timer).to be_blank
    end
  end
end
