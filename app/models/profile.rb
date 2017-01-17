class Profile < ApplicationRecord
  has_many :skills, dependent: :destroy

  serialize :experience, JSON
  serialize :education, JSON

  def self.build(url)

    # check URL and extract unique user id if valid
    if /https?:\/\/www\.linkedin\.com\/in\/(.+)/ =~ url
      uid = $1
    else
      raise "Error: #{url} not valid URL"
    end

    # calling linkedin
    p = call_linkedin(url)


    # setting Profile attributes
    profile = self.new(
      uid: uid,
      url: url,
      name: p.name,
      title: p.title,
      current_position: p.current_companies.first.try(:[], :title),
      summary: p.summary,
      experience: (p.current_companies + p.past_companies).to_json,
      education: p.education.to_json
    )

    # calculate and set score
    profile.score = profile.calc_score

    # set skills
    skills = p.skills.map { |s| Skill.new(name: s)  }
    profile.skills = skills

    profile

  end

  def self.call_linkedin(url)
    p = Linkedin::Profile.new(url)
  end

  def calc_score
    # Stub function
    -1
  end

  def experience
    begin
      JSON.parse(read_attribute(:experience))
    rescue
      []
    end
  end

  def education
    begin
      JSON.parse(read_attribute(:education))
    rescue
      []
    end
  end

  def score
    read_attribute(:score) || 0
  end


end
