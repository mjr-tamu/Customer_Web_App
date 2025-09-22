# frozen_string_literal: true

class AddPublishDateToBooks < ActiveRecord::Migration[8.0]
  def change
    add_column :books, :publish_date, :datetime
  end
end
