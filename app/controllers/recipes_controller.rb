class RecipesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        #find out if the user is logged in
        user = User.find_by(id: session[:user_id])
        if user
            recipes = Recipe.all
            render json: recipes, include: :user, status: :created
        else
            render json: { errors: ["Not authorized"]}, status: :unauthorized
        end
    end

    def create
        #make sure the user is loggin 
        user = User.find_by(id: session[:user_id])

        if user
            # byebug
            # recipe = Recipe.create!(recipe_params)
            recipe = Recipe.create!(title: params[:title], instructions: params[:instructions], minutes_to_complete: params[:minutes_to_complete], user_id: user.id)
            # recipe.updated(user_id: user.id)
            render json: recipe, include: :user, status: :created

        else
            render json: { errors: ["Not authorized"]}, status: :unauthorized
        end
    end

    private
    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    # def recipe_params
    #     params.permit(:title, :instructions, :minutes_to_complete)
    # end
end

# t.string "title"
# t.text "instructions"
# t.integer "minutes_to_complete"
# t.integer "user_id"
