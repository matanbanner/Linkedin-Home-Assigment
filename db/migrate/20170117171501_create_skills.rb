class CreateSkills < ActiveRecord::Migration[5.0]
  def change
    create_table :skills do |t|
      t.string :name

      # This also adds index for profile
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end
