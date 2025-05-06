class AuthService < ApiService
  def login(email, password)
    response = self.class.post(api_path('/users/auth'),
      body: { email: email, password: password }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    )
    puts "Login response: #{response.inspect}" # Para debug
    puts "Login response: #{response.inspect}" # Para debug
    handle_response(response)
  end

  def sign_up(email, password)
    response = self.class.post(api_path('/users/sign_up'),
      body: { email: email, password: password }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    )
    handle_response(response)
  end
end
