# These indexes cover all combination for searching a skill by name and profile_id
# Profile_id already has index from previous migration (xxxxxxx_create_skills.rb)
class AddIndexToSkill < ActiveRecord::Migration[5.0]
  def change
    # name
    # name, profile_id
    add_index :skills, [:name, :profile_id]

  end
end
