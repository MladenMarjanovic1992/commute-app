require "rails_helper"

RSpec.feature "User sign in" do
  before do
    @mladen = User.create(email: "mladen@email.com", password: "password")
  end
  
  scenario "with valid credentials" do
    visit "/"
    click_link "Sign in"
    
    fill_in "Email", with: "mladen@email.com"
    fill_in "Password", with: "password"
    click_button "Log in"
    
    expect(current_path).to eq(root_path)
    expect(page).to have_content("Signed in successfully")
    expect(page).to have_content(@mladen.email)
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