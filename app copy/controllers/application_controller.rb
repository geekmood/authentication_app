class ApplicationController < ActionController::API
    before_action :authenticate_user

    def authenticate_user
        if request.headers['Authorization']
            begin
                auth_header = request.headers['Authorization']
                decode_token = JWT.decode(token, secret)
                payload = decode_token.first
                @user = User.find(payload['user_id'])
            rescue => exception
                render json: { message: "Error: #{exception}"}, status: :forbidden
            end
        else
            render json: { message: "No authorization header sent" }, status: :forbidden
        end  
    end

    def secret
        secret = ENV['SECRET_KEY_BASE'] || Rails.application.secrets.secret_key_base
    end

    def token
        auth_header.split(" ")[1]
    end

    def initiate_token(payload)
        JWT.encode(payload, secret)
    end

end
