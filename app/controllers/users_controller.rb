class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show]

  def register
    account_num = "2040#{rand(10**6..10**7)}"
    user = User.new(user_params.except(:password).merge(account_num: account_num))
    user.password_digest = BCrypt::Password.create(user_params[:password])
    if user.save
      render json: { message: 'Registration successful', user:user }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(username: params[:username])
    if user && BCrypt::Password.new(user.password_digest) == params[:password]
      token = encode_token(user_id: user.id)
      render json: { message: 'Login Successful', token: token, user: user.as_json(except: :password_digest) }, status: :ok
    else
      render json: { message: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def show
    render json: @current_user.as_json(except: :password_digest), status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :fullname, :telephone, :email)
  end

  def encode_token(payload)
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def authenticate_user
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      decoded = JWT.decode(header, Rails.application.secrets.secret_key_base)[0]
      @current_user = User.find(decoded['user_id'])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
