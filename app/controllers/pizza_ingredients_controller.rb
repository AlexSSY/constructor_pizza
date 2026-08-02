class PizzaIngredientsController < ApplicationController
  before_action :authenticate_user!

  def create
    @pizza_ingredient = IncreaseIngredientService.new(
      pizza_id: params[:pizza_id], topping_id: params[:pizza_topping_id]
    ).call
  end

  def destroy
    @pizza_ingredient = DecreaseIngredientService.new(
      pizza_id: params[:pizza_id], topping_id: params[:pizza_topping_id]
    ).call
  end

  private

  def params
    params.permit(:pizza_id, :pizza_topping_id)
  end
end
