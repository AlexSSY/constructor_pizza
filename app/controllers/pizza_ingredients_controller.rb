class PizzaIngredientsController < ApplicationController
  before_action :authenticate_user!

  def create
    pizza = Pizza.find(params[:pizza_id])
    topping = PizzaTopping.find(params[:pizza_topping_id])

    pizza_ingredient = PizzaIngredient.new(pizza: pizza, pizza_topping: topping)

    if pizza_ingredient.save
      redirect_to pizza_path(pizza), notice: "Topping added to pizza."
    else
      redirect_to pizza_path(pizza), alert: "Failed to add topping."
    end
  end

  def destroy
    pizza_ingredient = PizzaIngredient.find(params[:id])
    pizza = pizza_ingredient.pizza

    if pizza_ingredient.destroy
      redirect_to pizza_path(pizza), notice: "Topping removed from pizza."
    else
      redirect_to pizza_path(pizza), alert: "Failed to remove topping."
    end
  end
end
