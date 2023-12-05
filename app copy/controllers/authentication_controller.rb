class AuthenticationController < ApplicationController
    skip_before_action :authenticate_user, only: [:login]

    def login
        @user = User.find_by(email: params[:email])
        if @user
            if(@user.authenticate(params[:password]))
                payload = { user_id: @user.id }
                secret = ENV['SECRET_KEY_BASE'] || Rails.application.secrets.secret_key_base
                token = initiate_token(payload)
                render json: { full_name: @user.full_name}
            else
                render json: { message: 'Authentication failed' }
            end
        else
            render json: { message: "Couldn't find user" }
        end
    end
end
