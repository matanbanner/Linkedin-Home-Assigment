class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :uid
      t.string :name
      t.string :title
      t.string :current_position
      t.text :summary
      t.text :experience
      t.text :education
      t.float :score
      t.string :url

      t.timestamps
    end
  end
end
