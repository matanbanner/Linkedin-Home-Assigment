class Profile < ApplicationRecord

  has_many :skills, dependent: :destroy

  serialize :experience, JSON
  serialize :education, JSON

  # supports following formats:
  # https://www.linkedin.com/in/itaiganot
  # https://www.linkedin.com/in/itaiganot/...
  # https://www.linkedin.com/in/itaiganot?....
  URL_REGEX1 = /http[s]?:\/\/www\.linkedin\.com\/in\/(.+)[\?\/]/
  URL_REGEX2 = /http[s]?:\/\/www\.linkedin\.com\/in\/(.+)/

  def self.build(url)

    # check URL and extract unique user id if valid
    if URL_REGEX1 =~ url || URL_REGEX2 =~ url
      uid = $1
    else
      raise "Error: #{url} not valid URL"
    end

    # calling linkedin
    resp = call_linkedin(url)


    # setting Profile attributes
    profile = self.find_or_initialize_by(uid: uid)
    profile.assign_attributes(
      url: url,
      name: resp.name,
      title: resp.title,
      current_position: resp.current_companies.first.try(:[], :title),
      summary: resp.summary,
      experience: (resp.current_companies + resp.past_companies).to_json,
      education: resp.education.to_json
    )

    # calculate and set score
    profile.score = profile.calc_score

    # set skills
    resp.skills.each do |skill|
      profile.skills.build(name: skill)
    end

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
