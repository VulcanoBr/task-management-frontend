module ApiConfig
  # Configure a URL base da API aqui
  API_URL = ENV.fetch('API_URL', 'http://localhost:3000')
  API_VERSION = ENV.fetch('API_VERSION', 'v1')
end
