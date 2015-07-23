require 'spec_helper'

RSpec.describe FootballApi::Comment do
  let(:match_id) { 1788007 }
  let(:default)  { JSONHelper::Commentaries.get(:default) }

  let(:uri) {
    "#{@base_url}/api/?APIKey=#{@api_key}&Action=commentaries&match_id=#{match_id}"
  }

  before(:each) do
    stub_request(:get, uri)
    .with(headers: @headers)
    .to_return(status: 200, body: default.to_json)
  end

  let(:request_response) { FootballApi::Commentary.all_from_match(match_id) }

  describe '.all_from_match' do
    it 'sets match id' do
      expect(request_response).not_to be_nil
      expect(request_response.static_id.to_i).to eq(static_id)
    end
  end
end
