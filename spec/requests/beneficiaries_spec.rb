require 'rails_helper'

RSpec.describe "Beneficiaries API", type: :request do
  describe "POST /beneficiaries with valid parameters" do
    it "registers a new beneficiary" do
      user = User.create(username: "testuser1", password_digest: "password", fullname: "Test User", telephone: "1234567890", email: "test@example.com", account_num: "123456789", account_bal: 0.0)
      
      token = JsonWebToken.encode(user_id: user.id)
      headers = { "Authorization" => "Bearer #{token}" }

      post "/beneficiaries", params: { beneficiary: { name: "Beneficiary Name", account_num: "987654321", user_id: user.id } }, headers: headers

      expect(response).to have_http_status(:created)
      expect(Beneficiary.count).to eq(1)
      expect(Beneficiary.first.name).to eq("Beneficiary Name")
      expect(Beneficiary.first.account_num).to eq("987654321")
      expect(Beneficiary.first.user_id).to eq(user.id)
    end
  end
end