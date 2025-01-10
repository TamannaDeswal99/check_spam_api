class Api::V1::UsersController < ApplicationController
    skip_before_action :authenticate_user!, only: [:create]
    before_action :authenticate_user!, only: [:show, :update]

     # POST /api/v1/users
    def create
        user = User.new(user_params)
        if user.save
            render json: user, status: :created 
        else
            render json: user.errors, status: :unprocessable_entity
        end
    end

    # GET /api/v1/users/:id
    def show
        user = User.find_by(id: params[:id])
        if user && user.update(user_params)
            render json: user, status: :ok
        else
            render json: { error: 'User not found'}, status: :not_found
        end
    end

    # PUT /api/v1/users/:id
    def update
        user = User.find_by(id: params[:id])
        if user && user.update(user_params)
            render json: user, status: :ok
        else
            render json: {error: 'User not found or update failed.'}, status: :unprocessable_entity
        end
    end

    private 

    def user_params
        params.require(:user).permit(:name, :phone_number, :email, :password)
    end
end
