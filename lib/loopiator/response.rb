module Loopiator
  module Response
    
    # Parsing returned status from Loopia and raising exceptions when necessary.
    # For more information: https://www.loopia.se/api/status/
    def parse_response(response)
      response = response.downcase.to_sym
      
      case response
        when :ok
          return response
        when :domain_occupied
          return response
        when :auth_error
          raise Loopiator::AuthError,             "You've supplied invalid authentication credentials. Please check your credentials and then try again."
        when :rate_limited
          raise Loopiator::RateLimitError,        "You've reached the number of allowed API-requests within the given time period. Please wait a bit and then retry again."
        when :bad_indata
          raise Loopiator::InvalidParameterError, "One or several parameters have invalid parameters supplied."
        when :unknown_error
          raise Loopiator::UnknownError,          "An unknown error occurred while trying."
        else
          return response
      end
    end
    
  end
end