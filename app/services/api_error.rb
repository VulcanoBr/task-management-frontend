class ApiError < StandardError
  attr_reader :status, :errors

  def initialize(status, errors)
    @status = status
    @errors = errors
    super("API Error: #{status} - #{errors}")
  end
end
