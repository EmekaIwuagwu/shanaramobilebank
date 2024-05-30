require 'rails_helper'

RSpec.describe "Transfers API", type: :request do
  describe "POST /transfer with valid parameters" do
    it "transfers money from one user to another" do
      user1 = User.create(username: "testuser2_transfer", password_digest: "password", fullname: "Test User 1", telephone: "1234567890", email: "test1@example.com", account_num: "123456789", account_bal: 10000.0)
      user2 = User.create(username: "testuser3_transfer", password_digest: "password", fullname: "Test User 2", telephone: "9876543210", email: "test2@example.com", account_num: "987654321", account_bal: 5000.0)

      post "/transfer", params: { transfer: { sender_id: user1.id, receiver_id: user2.id, amount: 1000.0 } }

      expect(response).to have_http_status(:created)
      expect(user1.reload.account_bal).to eq(9000.0)
      expect(user2.reload.account_bal).to eq(6000.0)
    end
  end
end