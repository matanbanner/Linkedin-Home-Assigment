class Profile < ApplicationRecord

  has_many :skills, dependent: :destroy

  serialize :experience, JSON
  serialize :education, JSON

  # Supports following formats:
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

  # Supported arguments:
  # profile_filter = { name: 'Gal Artsi', title: 'DevOps Engineer at Novus.io', current_position: 'DevOps Engineer'}
  # skills_filter = ["Servers", "SQL", "IIS", "Windows Server", "DevOps", "Linux", "Bash", "Integration"]
  #
  # Should add limit
  def self.filter(profile_filter={}, skills_filter=[])

    if profile_filter.blank?
      if skills_filter.present?
        profile_ids = Skill.where(name: skills_filter).pluck(:profile_id)
        profiles = Profile.where(id: profile_ids)
        return profiles
      else
        # If there is no filter, return all
        return self.all
      end
    end

    # Concatenate sql query
    sql = self
    profile_filter.each do |column, value|
      sql = sql.where("#{column} LIKE '%#{value}%'")
    end


    # Eager loading skills to prevent N+1 queries problem
    profiles = sql.includes(:skills).order(score: :desc)

    # Filter profiles: selecting only those that their skills contain ALL skills_filter
    skills_filter_set = skills_filter.to_set
    profiles.select do |p|
      profile_skills = p.skills.map(&:name)
      profile_skills_set = profile_skills.to_set

      skills_filter_set.subset?(profile_skills_set)
    end
  end

  def self.call_linkedin(url)
    p = Linkedin::Profile.new(url)
  end

  #
  def calc_score
    regex_has_years = /([0-9]*) year[s]?($| ([0-9]*) month[s]?)/
    regex_months_only = /([0-9]*) month[s]?/

    tot_experience = 0
    self.experience.each do |job|
      duration = job["duration"]
       if regex_has_years =~ duration
         years = $1.to_i
         months = $3.to_i
        #  puts "years=#{years} months=#{months}"
       elsif regex_months_only =~ duration
         years = 0
         months = $1.to_i
        #  puts "years=#{years} months=#{months}"
       end
       tot_experience += ((years * 12) + months)
    end

    score = (tot_experience * 0.6 + self.skills.count * 0.4).round(2)
    score

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
    read_attribute(:score) || 0.0
  end

  def to_json
    h = self.attributes
    h["skills"] = self.skills.map(&:name)
    h.to_json(only: ["name", "title", "current_position", "summary", "experience", "education", "score", "skills"])
  end



end
