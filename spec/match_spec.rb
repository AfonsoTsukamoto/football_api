require 'spec_helper'

RSpec.describe FootballApi::Match do
  let(:competition_id) { 1204 }
  let(:response)   { JSONHelper::Matches.get(:no_matches_today) }
  let(:uri) {
    "#{@base_url}/api/?APIKey=#{@api_key}&Action=today&comp_id=#{competition_id}"
  }
  before(:each) do
    stub_request(:get, uri)
    .with(headers: @headers)
    .to_return(status: 200, body: response.to_json)
  end

  let(:request_response) { FootballApi::Match.all_from_competition(competition_id) }

  # At the moment we don't have api with matches today :(
  # lets test what we have!
  describe '.all_from_competition with no matches' do
    it 'returns_no_matches' do
      expect(request_response).not_to be_nil
      expect(request_response.size).to eq(0)
    end
  end
end
