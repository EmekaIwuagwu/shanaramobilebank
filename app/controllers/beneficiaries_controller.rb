class BeneficiariesController < ApplicationController
    before_action :authenticate_user
  
    def create
      beneficiary = @current_user.beneficiaries.build(beneficiary_params)
      if beneficiary.save
        render json: { message: 'Beneficiary has been saved successfully.' , data:beneficiary}, status: :created
      else
        render json: { errors: beneficiary.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      beneficiary = @current_user.beneficiaries.find_by(account_num: params[:account_num])
      if beneficiary.update(beneficiary_params)
        render json: { message: 'Beneficiary details updated successfully.', data:beneficiary }, status: :ok
      else
        render json: { errors: beneficiary.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      beneficiary = @current_user.beneficiaries.find_by(account_num: params[:account_num])
      if beneficiary.destroy
        render json: { message: 'Beneficiary deleted successfully.' }, status: :ok
      else
        render json: { errors: beneficiary.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def beneficiary_params
      params.permit(:name_in_full, :account_num)
    end
  end
  