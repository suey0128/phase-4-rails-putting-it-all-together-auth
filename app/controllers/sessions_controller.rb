class SessionsController < ApplicationController
    def create
        #when a user login with username and pd, authenticate the info and find the id, 
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user
        else
            render json: { errors: ["Not authorized"] }, status: :unauthorized
        end
    end

    def destroy
        #find the login user using cookies
        user = User.find_by(id: session[:user_id])
        if user
            #just delete the cookie of the :user_id
            session.delete :user_id
            head :no_content
        else 
            render json: { errors: ["Not authorized"] }, status: :unauthorized
        end
    end

end
