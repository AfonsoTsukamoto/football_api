require 'spec_helper'

RSpec.describe FootballApi::Commentary do
  let(:match_id) { 1788007 }
  let(:static_id) { 1755579 }
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
      # doing a :static_id validation, this value must be set before request
      # we can't request a match that we dont already have some information
      # like :match_id and :match_static_id

      expect(request_response).not_to be_nil
      expect(request_response.static_id.to_i).to eq(static_id)
    end

    it 'sets all match summary cards' do
      summary = request_response.match_summary

      expect(summary).not_to be_nil
      expect(summary.local_team_yellowcards.size).to eq(2)
      expect(summary.local_team_redcards.size).to eq(0)
      expect(summary.visitor_team_yellowcards.size).to eq(4)
      expect(summary.visitor_team_redcards.size).to eq(0)
    end

    it 'sets all match summary goals' do
      summary = request_response.match_summary

      expect(summary).not_to be_nil
      expect(summary.local_team_goals.size).to eq(1)
      expect(summary.visitor_team_goals.size).to eq(2)
    end

    it 'sets local team and players' do
      local_team = request_response.local_match_team

      expect(local_team).not_to be_nil
      expect(local_team.players.size).to eq(18)
      expect(local_team.id).to eq(request_response.match_id)
    end

    it 'sets visitor team and players' do
      visitor_team = request_response.visitor_match_team

      expect(visitor_team).not_to be_nil
      expect(visitor_team.players.size).to eq(18)
      expect(visitor_team.id).to eq(request_response.match_id)
    end

    it 'sets match bench' do
      match_bench = request_response.match_bench

      expect(match_bench).not_to be_nil
      expect(match_bench.match_id).to eq(request_response.match_id)
    end

    it 'sets local team bench' do
      match_bench = request_response.match_bench

      expect(match_bench.local_team).not_to be_nil
      expect(match_bench.local_team.players.size).to eq(7)
    end

    it 'sets visitor team bench' do
      match_bench = request_response.match_bench

      expect(match_bench.visitor_team).not_to be_nil
      expect(match_bench.visitor_team.players.size).to eq(7)
    end

    it 'sets match substitutions' do
      match_substitutions = request_response.match_substitutions

      expect(match_substitutions).not_to be_nil
      expect(match_substitutions.match_id).to eq(request_response.match_substitutions.match_id)
    end

    it 'sets local team substitutions' do
      match_substitutions = request_response.match_substitutions

      expect(match_substitutions.local_team).not_to be_nil
      expect(match_substitutions.local_team.size).to be(3)
    end

    it 'sets visitor team substitutions' do
      match_substitutions = request_response.match_substitutions

      expect(match_substitutions.visitor_team).not_to be_nil
      expect(match_substitutions.visitor_team.size).to be(3)
    end

    it 'sets commentaries' do
      commentaries = request_response.commentaries

      expect(commentaries).not_to be_nil
      expect(commentaries.size).to eq(111)
    end
  end
end
