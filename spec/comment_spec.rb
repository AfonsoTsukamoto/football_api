require 'spec_helper'

RSpec.describe FootballApi::Comment do
  let(:match_id) { 1788007 }
  let(:first_comment_id) { 7626965 }
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

  describe '.new' do
    it 'sets all properties' do
      expect(request_response).not_to be_nil

      comment = request_response.commentaries.first

      expect(comment.id.to_i).to eq(first_comment_id)
      expect(comment.important.downcase).to eq(false.to_s)
      expect(comment.is_goal.downcase).to eq(false.to_s)
      expect(comment.minute).to eq(90)
      expect(comment.comment).not_to be_nil
    end
  end
end
