module Loopiator
  class AuthError < StandardError; end
  class RateLimitError < StandardError; end
  class InvalidParameterError < StandardError; end
  class UnknownError < StandardError; end
end
