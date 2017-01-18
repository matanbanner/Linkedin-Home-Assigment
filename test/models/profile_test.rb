require 'test_helper'

class ProfileTest < ActiveSupport::TestCase

  test "filter by name" do
    profile1 = Profile.filter({name: "Bracha Madar"}).first
    profile2 = Profile.filter({name: "Neta Kaplan Shertzer"}).first

    bracha = profiles(:profile_3)

    assert_equal profile1, bracha, "Didn't match profiles"
    assert_not_equal profile2, bracha, "Match profiles"

  end

  test "filter by name and title" do
    profile1 = Profile.filter({name: "Bracha Madar", title: "HR Recruiter"}).first
    bracha = profiles(:profile_3)
    assert_equal profile1, bracha, "name didn't match"
    assert_equal profile1, bracha, "Didn't match profiles"

    profile2 = Profile.filter({name: "Bracha Madar", title: "Fake Title"}).first
    assert_nil profile2, "Should not match any profile"
  end


  test "filter by skills" do
    profile1 = profiles(:profile_7)
    profile2 = profiles(:profile_8)
    set1 = [profile1, profile2].to_set

    set2 = Profile.filter({}, ["Linux", "Virtualization", "DevOps"]).to_set

    assert set1 == set2

  end

  test "filter by names and skills" do
    profile1 = Profile.filter({name: "Itai Ganot"}, ["Linux", "Virtualization", "DevOps"]).first
    profile2 = profiles(:profile_8)
    assert_equal profile1, profile2, "Didn't match profiles"
  end


  test "filter by nothing" do
    assert_equal Profile.filter({}).size, Profile.count, "Should return all profiles"
  end


end
