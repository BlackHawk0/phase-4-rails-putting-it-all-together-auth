class RecipesController < ApplicationController
    # ensure a user is logged in
    before_action :authorize

    # GET /recipes
    def index
        recipes = Recipe.all
        render json: recipes, include:['user']

    end

    def create
        # find the specif user
        user = User.find_by(id: session[:user_id])
        recipe = Recipe.create(recipe_params.merge({user_id: user.id}))
        if recipe.valid?
            render json: recipe, status: :created
        else
            render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
        end


    end

    private
    def authorize
        render json: {errors: ["Not authorised"]}, status: :unauthorized unless session.include? :user_id
    end

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end



        


end
