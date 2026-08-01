class PizzasController < ApplicationController
  # before_action :authenticate_user!

  def index
    @pizzas = Pizza.all
  end

  def show
    @pizza = Pizza.find(params[:id])
  end

  def create
    fingerprint = PizzaFingerprint.new(pizza_params).call

    existing_pizza = Pizza.find_by(fingerprint: fingerprint)

    if existing_pizza.present?
      @pizza = existing_pizza
    else
      @pizza = Pizza.new(pizza_params)
      @pizza.save!
    end
  end

  private

  def pizza_params
    params
      .permit(
        :size,
        :crust,
        :dough,
        :base_pizza_id,
        :price,
        pizza_ingredients_attributes: [ :pizza_topping_id, :quantity ]
      )
  end
end
