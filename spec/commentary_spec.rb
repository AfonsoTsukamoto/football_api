require 'spec_helper'

RSpec.describe FootballApi::Commentary do
  let(:match_id) { 1788007 }
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

      expect(res).not_to be_nil
      expect(res.static_id).to eq(match_id)
    end
  end
end