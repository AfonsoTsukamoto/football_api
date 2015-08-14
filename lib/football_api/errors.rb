module FootballApi
  class BaseError < StandardError
  end

  class InvalidParameter < BaseError
  end

  class RequestError < BaseError
  end

  class FootballApiError < BaseError
  end
end