class PizzasController < ApplicationController
  # before_action :authenticate_user!

  def index
    @pizzas = Pizza.all
  end

  def show
    @pizza = Pizza.find(params[:id])
  end

  def create
    @pizza = Pizza.new(pizza_params)
    if @pizza.save
      redirect_to @pizza, notice: "Pizza was successfully created."
    else
      render :new
    end
  end

  private

  def pizza_params
    params
      .require(:pizza)
      .permit(
        :size,
        :crust,
        :dough,
        :base_pizza_id,
        :price,
        pizza_ingredients_attributes: [ :id, :pizza_topping_id, :quantity, :_destroy ]
      )
  end
end
