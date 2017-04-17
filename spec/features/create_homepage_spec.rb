require "rails_helper"

RSpec.feature "Display homepage" do
  scenario do
    visit "/"
    
    expect(page).to have_link("Commute.rs")
    expect(page).to have_link("Sign up")
    expect(page).to have_link("Sign in")
    
    expect(page).to have_content("Welcome to Commute.rs!")
    expect(page).to have_content("Save money and the environment by sharing a ride.")
  end

end