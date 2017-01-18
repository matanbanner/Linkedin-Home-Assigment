# These indexes cover all combination for searching a profile by name, title and current_position
# Summary column is not indexed because its type in text, which is too big

class AddIndexToProfile < ActiveRecord::Migration[5.0]
  def change

    add_index :profiles, :uid, :unique => true

    # name
    # name, title
    # name, title, current_position
    add_index :profiles, [:name, :title, :current_position]

    # title
    # title, current_position
    add_index :profiles, [:title, :current_position]

    # current_position
    # current_position, name
    add_index :profiles, [:current_position, :name]
  end
end
