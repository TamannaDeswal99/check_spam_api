class ApplicationController < ActionController::API
    before_action :authenticate_user!

    private

    def authenticate_user!
        unless user_signed_in?
            render json: {error: 'Unauthorized'}, status: :unauthorized
        end
    end

    def current_user 
        @current_user ||= User.find_by(id: session[:user_id])
    end

    def user_signed_in?
        current_user.present?
    end
end
