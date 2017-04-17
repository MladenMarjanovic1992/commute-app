require "rails_helper"

RSpec.feature "User sign out" do
  before do
    visit "/"
    
    click_link "Sign up"
    fill_in "Name", with: "Mladen"
    fill_in "Email", with: "mladen@email.com"
    fill_in "About me", with: "Hi I'm Mladen."
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    attach_file "Image", "spec/pexels-photo-crop1.jpg"
    click_button "Sign up"
    @mladen = User.last

  end
  
  scenario do
    visit "/"
    click_link "Sign out"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Signed out successfully")
  end
end
