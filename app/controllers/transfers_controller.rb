class TransfersController < ApplicationController
  before_action :authenticate_user

  def create
    to_account_num = params[:to_account_num]
    amount = params[:amount].to_f

    ActiveRecord::Base.transaction do
      from_user = @current_user
      to_user = User.find_by(account_num: to_account_num)

      if from_user.account_bal >= amount
        from_user.update!(account_bal: from_user.account_bal - amount)
        to_user.update!(account_bal: to_user.account_bal + amount)

        render json: { message: 'Transfer successful' }, status: :ok
      else
        render json: { errors: 'Insufficient balance' }, status: :unprocessable_entity
      end
    end
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Recipient account not found' }, status: :not_found
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end
end
