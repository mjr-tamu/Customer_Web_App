class AddUserToCalendars < ActiveRecord::Migration[8.0]
  def change
    add_reference :calendars, :user, null: true, foreign_key: true
  end
end
