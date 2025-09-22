# frozen_string_literal: true

class AddPriceToBooks < ActiveRecord::Migration[8.0]
  def change
    add_column :books, :price, :float
  end
end
