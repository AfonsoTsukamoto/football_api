require 'spec_helper'

RSpec.describe FootballApi::Standing do

  context 'league standings' do
  let(:response)   { JSONHelper::Standings.get(:default) }
  let(:competition_id) { 1204 }
  let(:uri) {
    "#{@base_url}/api/?APIKey=#{@api_key}&Action=standings&comp_id=#{competition_id}"
  }
  before(:each) do
    stub_request(:get, uri)
    .with(headers: @headers)
    .to_return(status: 200, body: response.to_json)
  end
  let(:request_response) { FootballApi::Standing.all_from_competition(competition_id) }

  describe '.all_from_competition ' do

    it 'not_fails' do
      expect(request_response).not_to be_nil
      expect(request_response.size).to eq(20)
    end

    it 'has_first_standing' do
      standing = request_response.first

      expect(standing).not_to be_nil
      expect(standing.stand_competition_id.to_i).to eq(competition_id)
    end

    it 'has_last_standing' do
      standing = request_response.last

      expect(standing).not_to be_nil
      expect(standing.stand_competition_id.to_i).to eq(competition_id)
    end
  end
end

context 'champions_league standings' do
  let(:response)   { JSONHelper::Standings.get(:champions_league) }
  let(:competition_id) { 1005 }
  let(:uri) {
    "#{@base_url}/api/?APIKey=#{@api_key}&Action=standings&comp_id=#{competition_id}"
  }
  before(:each) do
    stub_request(:get, uri)
    .with(headers: @headers)
    .to_return(status: 200, body: response.to_json)
  end
  let(:request_response) { FootballApi::Standing.all_from_competition(competition_id) }

  describe '.all_from_competition ' do

    it 'not_fails' do
      expect(request_response).not_to be_nil
      expect(request_response.size).to eq(32)
    end

    it 'has_first_standing' do
      standing = request_response.first

      expect(standing).not_to be_nil
      expect(standing.stand_competition_id.to_i).to eq(competition_id)
    end

    it 'has_last_standing' do
      standing = request_response.last

      expect(standing).not_to be_nil
      expect(standing.stand_competition_id.to_i).to eq(competition_id)
    end
  end
end
end
