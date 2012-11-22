module Loopiator
  class ApiError < StandardError; end
  
  class AuthError < ApiError
    def message
      "You've supplied invalid authentication credentials. Please check your credentials and then try again."
    end
  end
  
  class RateLimitError < ApiError
    def message
      "You've reached the number of allowed API-requests within the given time period. Please wait a bit and then retry again."
    end
  end
  
  class InvalidParameterError < ApiError
    def message
      "One or several parameters have invalid parameters supplied."
    end
  end
  
  class UnknownError < ApiError
    def message
      "An unknown error occurred while trying to request data from the API."
    end
  end
  
  class ConnectionError < ApiError
    def message
      "An unknown connection error occurred while trying to connect to the API."
    end
  end
end
