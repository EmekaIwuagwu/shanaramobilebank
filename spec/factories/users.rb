FactoryBot.define do
    factory :user do
      username { "testuser" }
      password_digest { BCrypt::Password.create('password') }
      fullname { 'Test User' }
      telephone { '1234567890' }
      email { 'test@example.com' }
      account_num { '20407966731' }
      account_bal { 0.0 }
    end
  end
  