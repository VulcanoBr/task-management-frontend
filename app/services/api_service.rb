class ApiService
  include HTTParty
  base_uri ApiConfig::API_URL

  def initialize(token = nil)
    @token = token
    @api_prefix = "/api/#{ApiConfig::API_VERSION}"   # '/api/v1'
  end

  def headers
    {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{@token}"
    }
  end

  def api_path(path)
    "#{@api_prefix}#{path}"
  end

  def handle_response(response)
    if response.success?
      response.parsed_response
    else
      raise ApiError.new(response.code, response.parsed_response)
    end
  end
end
