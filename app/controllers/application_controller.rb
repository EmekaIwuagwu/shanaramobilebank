class ApplicationController < ActionController::API
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
  
    def encode_token(payload)
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end
  end
  