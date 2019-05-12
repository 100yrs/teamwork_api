module TeamworkApi
  class TeamworkError < StandardError
    attr_reader :response

    def initialize(message, response = nil)
      super(message)
      @response = response
    end
  end

  class Error < TeamworkError
    attr_reader :wrapped_exception

    # Initializes a new Error object
    #
    # @param exception [Exception, String]
    # @return [TeamworkApi::Error]
    def initialize(exception = $!)
      @wrapped_exception = exception
      if exception.respond_to?(:message)
        super(exception.message)
      else
        super(exception.to_s)
      end
    end
  end

  class UnauthenticatedError < TeamworkError
  end

  class NotFoundError < TeamworkError
  end

  class UnprocessableEntity < TeamworkError
  end

  class TooManyRequests < TeamworkError
  end
end
