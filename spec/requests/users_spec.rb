require 'rails_helper'

RSpec.describe "Users API", type: :request do
  describe "POST /register with valid parameters" do
    it "registers a new user" do
      post "/register", params: { user: { username: "testuser_register", password_digest: "password", fullname: "Test User", telephone: "1234567890", email: "test@example.com", account_num: "123456789", account_bal: 0.0 } }

      expect(response).to have_http_status(:created)
      expect(User.count).to eq(1)
      expect(User.first.username).to eq("testuser_register")
    end
  end

  describe "POST /login with valid credentials" do
    it "logs in the user" do
      user = User.create(username: "testuser_login", password_digest: BCrypt::Password.create("password"), fullname: "Test User", telephone: "1234567890", email: "test@example.com", account_num: "123456789", account_bal: 0.0)

      post "/login", params: { username: user.username, password: "password" }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["message"]).to eq("Login successful")
    end
  end

  describe "GET /profile when user is authenticated" do
    it "returns the user profile" do
      user = User.create(username: "testuser_profile", password_digest: "password", fullname: "Test User", telephone: "1234567890", email: "test@example.com", account_num: "123456789", account_bal: 0.0)

      token = JsonWebToken.encode(user_id: user.id)
      headers = { "Authorization" => "Bearer #{token}" }

      get "/profile", headers: headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["username"]).to eq(user.username)
    end
  end
end