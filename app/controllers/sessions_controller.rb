class SessionsController < ApplicationController

    # POST /login
    def create
        user = User.find_by(username: params[:username])
        # checks if password and username are valid
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user, status: :ok
        else
            render json: {errors: ["Invalid username or password"]}, status: :unauthorized
        end
    end


    # DELETE /logout
    def destroy
        user = User.find_by(id: session[:user_id])
        # if logged in
        if user
            session.delete :user_id
            head :no_content    
        else
            render json: {errors: ["Not authorized"]}, status: :unauthorized
        end
    end
end
