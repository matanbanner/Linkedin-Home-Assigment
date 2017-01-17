json.extract! profile, :id, :uid, :name, :title, :current_position, :summary, :experience, :education, :score, :url, :created_at, :updated_at
json.url profile_url(profile, format: :json)