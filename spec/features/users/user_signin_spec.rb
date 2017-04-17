require "rails_helper"

RSpec.feature "User sign in" do
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
    
    visit "/"
    click_link "Sign out"
  end
  
  scenario "with valid credentials" do
    visit "/"
    click_link "Sign in"
    
    fill_in "Email", with: "mladen@email.com"
    fill_in "Password", with: "password"
    click_button "Log in"
    
    expect(current_path).to eq(root_path)
    expect(page).to have_content("Signed in successfully")
    expect(page).to have_content(@mladen.name)
    expect(page).not_to have_link("Sign in")
    expect(page).not_to have_link("Sign up")
    expect(page).to have_link("Sign out")


  end
  
  scenario "with invalid credentials" do
    visit "/"
    click_link "Sign in"
    
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    click_button "Log in"
    
    expect(current_path).to eq(new_user_session_path)
  end
end