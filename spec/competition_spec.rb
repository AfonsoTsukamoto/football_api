require 'spec_helper'

RSpec.describe FootballApi::Competition do
  let(:response)   { JSONHelper::Competitions.get(:all) }
  let(:uri) { "#{@base_url}/api/?APIKey=#{@api_key}&Action=competitions" }

  before(:each) do
    stub_request(:get, uri)
    .with(headers: @headers)
    .to_return(status: 200, body: response.to_json)
  end
  let(:request_response) { FootballApi::Competition.all }

  describe '.all' do
    it 'not_fails' do
      expect(request_response).not_to be_nil
      expect(request_response.size).to eq(1)
    end

    it 'has_competition' do
      competition = request_response.first

      expect(competition).not_to be_nil
      expect(competition.id).not_to be_nil
    end
  end
end
