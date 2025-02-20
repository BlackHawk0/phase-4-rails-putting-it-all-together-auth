class UsersController < ApplicationController
    # POST /signup
    def create
        new_user = User.create(user_params)
        if new_user.valid?
            session[:user_id] = new_user.id
            render json: new_user, status: :created
        else
            render json: {errors: new_user.errors.full_messages}, status: :unprocessable_entity
        end
    end

    # GET /me
    def show
        user = User.find_by(id: session[:user_id])
        if user
            render json: user, status: :created
        else
            render json: {errors: "Not authorized"}, status: :unauthorized
        end
    end

    private
    def user_params
        params.permit(:username, :password, :password_confirmation, :image_url, :bio)
    end
end
