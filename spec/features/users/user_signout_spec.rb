require "rails_helper"

RSpec.feature "User sign out" do
  before do
    @mladen = User.create(name: "Mladen", email: "mladen@email.com", password: "password")
    visit "/"
    click_link "Sign in"
    fill_in "Email", with: @mladen.email
    fill_in "Password",  with: @mladen.password
    click_button "Log in"
  end
  
  scenario do
    visit "/"
    click_link "Sign out"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Signed out successfully")
  end
end
