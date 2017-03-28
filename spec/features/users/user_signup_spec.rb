require "rails_helper"

RSpec.feature "Sign users up" do
  scenario "with valid credentials" do
    visit "/"
    
    click_link "Sign up"
    fill_in "Email", with: "mladen@email.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    attach_file "Image", "spec/pexels-photo-crop.jpg"
    click_button "Sign up"
    
    expect(page).to have_content("You have signed up successfully")
    
  end
end