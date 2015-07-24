require 'spec_helper'

RSpec.describe FootballApi::Standing do
  context 'league standings' do
    let(:response_json) { JSONHelper::Standings.get(:default) }
    let(:competition_id) { 1204 }

    let(:uri) do
      "#{@base_url}/api/?APIKey=#{@api_key}&Action=standings"\
      "&comp_id=#{competition_id}"
    end

    let(:response) do
      FootballApi::Standing.all_from_competition(competition_id)
    end

    before(:each) do
      stub_request(:get, uri)
        .with(headers: @headers)
        .to_return(status: 200, body: response_json.to_json)
    end

    describe '.all_from_competition' do
      it 'not_fails' do
        expect(response).not_to be_nil
        expect(response.size).to eq(20)
      end

      it 'has_first_standing' do
        standing = response.first

        expect(standing).not_to be_nil
        expect(standing.stand_competition_id.to_i).to eq(competition_id)
      end

      it 'has_last_standing' do
        standing = response.last

        expect(standing).not_to be_nil
        expect(standing.stand_competition_id.to_i).to eq(competition_id)
      end
    end
  end

  context 'champions_league standings' do
    let(:response_json) { JSONHelper::Standings.get(:champions_league) }
    let(:competition_id) { 1005 }

    let(:uri) do
      "#{@base_url}/api/?APIKey=#{@api_key}&Action=standings&" \
      "comp_id=#{competition_id}"
    end

    before(:each) do
      stub_request(:get, uri)
        .with(headers: @headers)
        .to_return(status: 200, body: response_json.to_json)
    end

    let(:response) do
      FootballApi::Standing.all_from_competition(competition_id)
    end

    describe '.all_from_competition ' do
      it 'not_fails' do
        expect(response).not_to be_nil
        expect(response.size).to eq(32)
      end

      it 'has_first_standing' do
        standing = response.first

        expect(standing).not_to be_nil
        expect(standing.stand_competition_id.to_i).to eq(competition_id)
      end

      it 'has_last_standing' do
        standing = response.last

        expect(standing).not_to be_nil
        expect(standing.stand_competition_id.to_i).to eq(competition_id)
      end
    end
  end
end
