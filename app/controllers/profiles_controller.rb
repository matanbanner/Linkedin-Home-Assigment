class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  # GET /profiles/import?url=url
  def import
    flash[:alert] = nil
    url = params[:url]
    if url.present?
      if Profile::URL_REGEX2.match(url).nil?
        flash[:alert] = "Error: #{url} not valid URL"
      else
        profile = Profile.build(url)
        profile.save
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
  #http://localhost:3000/profiles/import_profile?url=https%3A%2F%2Fwww.linkedin.com%2Fin%2Fbracha-madar-34ab2424
  def import_profile
    url = params[:url]
    if Profile::URL_REGEX2.match(url).nil?
      render json: {status: "error", message: "#{url} not valid URL"}
    else
      begin
        profile = Profile.build(url)
        profile.save
        render json: {status: "ok"}
      rescue => e
        render json: {status: "error", message: e.message}
      end
    end
  end

  # GET /profiles/searech_by_skills?skills=[...]
  # {skills: ["Servers", "SQL", "IIS", "Windows Server"]}.to_query
  # http://localhost:3000/profiles/search_by_skills?skills%5B%5D=Servers&skills%5B%5D=SQL&skills%5B%5D=IIS&skills%5B%5D=Windows+Server
  def search_by_skills
    skills_filter = params[:skills]
    if skills_filter.is_a?(Array)
      profiles = Profile.filter({}, skills_filter)
      render json: {status: "ok", data: {profiles: profiles}}
    else
      render json: {status: "error", message: 'Parameter (skills) should be an array'}
    end
  end

  # GET /profiles/search_by_attrs?name=<name>&title=<title>&....
  # {current_position: 'DevOps Engineer'}.to_query(:profile)
  def search_by_attrs
    profile_filter = profile_params.to_h.reject{|k,v| v.blank?}
    profiles = Profile.filter(profile_filter)
    render json: {status: "ok", data: {profiles: profiles}}
  end

#################################







  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:uid, :name, :title, :current_position, :summary, :experience, :education, :score, :url)
    end
end
