class ImportProfileJob < ApplicationJob
  queue_as :default

  def perform(url)
    profile = Profile.build(url)
    profile.store
  end
end
