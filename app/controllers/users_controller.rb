class UsersController < ApplicationController
    def create
        #take in the input from frontend and create user
        user = User.create!(params.permit(:username, :password, :password_confirmation, :image_url, :bio))
        #store the user id in session so that it can be use for #show 
        session[:user_id] = user.id
        #send info back to the frontend
        render json: user, except: [:created_at, :updated_at], status: :created
    #handle invalid input    
    rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def show
        #when the user signup, the id is stored in session(cookie), find the user using cookie
        user = User.find_by(id: session[:user_id])
        if user
            render json: user
        else
            render json: { error: "Not authorized"}, status: :unauthorized
        end
    end

end

# Parameters {"username"=>"", "password"=>"", "password_confirmation"=>"", "image_url"=>"", "bio"=>""