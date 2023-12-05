class UsersController < ApplicationController
    skip_before_action :authenticate_user, only: [:create]

    def create
        @user = User.new(user_params)
        if @user.save
            payload = { user_id: @user.id }
            token = initiate_token(payload)
            render json: { message: 'User created successfully' }, status: :created
        else
            render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.require(:user).permit(:full_name, :email, :phone, :address, :password)
    end
end
  