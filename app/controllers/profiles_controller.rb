class ProfilesController < ApplicationController


  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @profile = Profile.find(params[:id])
  end

  # GET /profiles/import?url=url
  def import
    flash[:alert] = nil
    url = params[:url]
    if url.present?
      if Profile::URL_REGEX2.match(url).nil?
        flash[:alert] = "Error: #{url} not valid URL"
      else
        # Enqueue url to a job queque
        # ImportProfileJob.perform_later(url)
        flash[:alert] = 'Profile will be created in the background, feel free to enter a new url...'
        profile = Profile.build(url)
        profile.store
      end
    end
  end

  # GET /profiles/search
  def search
    if params[:commit]
      skills_str = params[:skills]
      skills_filter = skills_str.split(',')
      profile_filter = profile_params.to_h.reject{|k,v| v.blank?}
      @profiles = Profile.filter(profile_filter, skills_filter)
    end
  end


########  API ENDPOINTS #########

  # GET /profiles/import_profile?url=url
  # { url: 'https://www.linkedin.com/in/bracha-madar-34ab2424' }.to_query
  # Try: http://localhost:3000/profiles/import_profile?url=https%3A%2F%2Fwww.linkedin.com%2Fin%2Fbracha-madar-34ab2424
  def import_profile
    url = params[:url]
    if Profile::URL_REGEX2.match(url).nil?
      render json: {status: "error", message: "#{url} not valid URL"}
    else
      # Enqueue url to a job queque
      ImportProfileJob.perform_later(url)
      # profile = Profile.build(url)
      # profile.store
      render json: {
        status: "ok",
        params: {url: url}
      }
    end
  end

  # GET /profiles/searech_by_skills?skills=[...]
  # {skills: ["Servers", "SQL", "IIS", "Windows Server"]}.to_query
  # Try: http://localhost:3000/profiles/search_by_skills?skills%5B%5D=Servers&skills%5B%5D=SQL&skills%5B%5D=IIS&skills%5B%5D=Windows+Server
  def search_by_skills
    skills_filter = params[:skills]
    if skills_filter.is_a?(Array)
      profiles = Profile.filter({}, skills_filter)
      render json: {
        status: "ok",
        params: {skills: skills_filter},
        data: {profiles: profiles}
      }
    else
      render json: {status: "error", message: 'Parameter (skills) should be an array'}
    end
  end

  # GET /profiles/search_by_attrs?profile={name: "Matan", title: "DevOp", ....}
  # {current_position: 'DevOps Engineer'}.to_query(:profile)
  # Try: http://localhost:3000/profiles/search_by_attrs?profile%5Bcurrent_position%5D=DevOps+Engineer
  def search_by_attrs
    profile_filter = profile_params.to_h.reject{|k,v| v.blank?}
    profiles = Profile.filter(profile_filter)
    render json: {
      status: "ok",
      params: {profile_filter: profile_params},
      data: {profiles: profiles}
    }
  end

#################################




  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:uid, :name, :title, :current_position, :summary, :experience, :education, :score, :url)
    end
end
