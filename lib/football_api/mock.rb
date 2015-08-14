json_helper = File.join('..', '..', '..', 'spec', 'helpers', 'json_helper')
require File.expand_path(json_helper, __FILE__)

module FootballApi
  class Mock
    class << self
      def explain
        meths = %w(commentaries competitions fixtures matches standings)
        puts 'Returns mock class instance for tests.'
        puts 'Available methods:'
        meths.each do |m|
          puts "\t - FootballApi::Mock.#{m}"
        end
        puts 'Params'
        puts '*type*, which allows the selection of the mock json.'
        puts ''
      end

      def commentaries(type = :default)
        json = JSONHelper::Commentaries.get(type)
        FootballApi::Commentary.collection(json)
      end

      def competitions(type = :all)
        json = JSONHelper::Competitions.get(type)
        FootballApi::Competition.collection(json)
      end

      def fixtures(type = :from_to_date)
        json = JSONHelper::Fixtures.get(type)
        FootballApi::Fixture.collection(json)
      end

      def matches(type = :today_default)
        json = JSONHelper::Matches.get(type)
        FootballApi::Match.collection(json)
      end

      def standings(type = :default)
        json = JSONHelper::Standings.get(type)
        FootballApi::Standing.collection(json)
      end
    end
  end
end
