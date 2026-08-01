class Init < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :hashed_password, null: false
    end

    add_index :users, :email, unique: true

    create_table :carts do |t|
      t.references :user, foreign_key: true
    end

    create_table :cart_items do |t|
      t.references :cart, foreign_key: true
      t.references :cart_itemable, polymorphic: true
      t.integer :quantity, null: false, default: 1
    end

    create_table :pizza_categories do |t|
      t.string :slug, null: false
      t.string :name, null: false
    end

    add_index :pizza_categories, :slug, unique: true

    create_table :base_pizzas do |t|
      t.string :slug, null: false
      t.string :name, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.references :pizza_category, foreign_key: true
    end

    create_table :pizzas do |t|
      t.string :size, null: false
      t.string :crust, null: false
      t.string :dough, null: false
      t.references :base_pizza, foreign_key: true
      t.decimal :price, precision: 10, scale: 2, null: false
      t.boolean :in_catalog, null: false, default: true
      t.boolean :is_base, null: false, default: false
      t.string :fingerprint, null: false
    end

    add_index :pizzas, :fingerprint, unique: true

    create_table :pizza_toppings do |t|
      t.string :slug, null: false
      t.string :name, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.boolean :in_catalog, null: false, default: true
      t.boolean :is_base, null: false, default: false
    end

    add_index :pizza_toppings, :slug, unique: true

    create_table :pizza_ingredients do |t|
      t.references :pizza, foreign_key: true
      t.references :pizza_topping, foreign_key: true
      t.integer :quantity, null: false, default: 1
    end

    add_index :pizza_ingredients, [ :pizza_id, :pizza_topping_id ], unique: true
  end
end
