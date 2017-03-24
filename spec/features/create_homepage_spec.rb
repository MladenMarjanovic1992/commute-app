require "rails-helper"

RSpec.feature "Display homepage" do
  visit "/"
  
  expect(page).to have_link("Commute.rs")
  expect(page).to have_link("Sign up")
  expect(page).to have_link("Sign in")
  
  expect(page).to have_content("Welcome to Commute.rs!")
  expect(page).to have_content("Save your money and your environment by sharing a ride.")

end