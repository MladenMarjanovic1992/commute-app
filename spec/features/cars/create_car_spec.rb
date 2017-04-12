require "rails_helper"

RSpec.feature "Add a car" do
  before do
    visit "/"
    
    click_link "Sign up"
    fill_in "Name", with: "Mladen"
    fill_in "Email", with: "mladen@email.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    attach_file "Image", "spec/pexels-photo-crop1.jpg"
    click_button "Sign up"
    @mladen = User.last
  end
  
  scenario "with invalid inputs" do
    visit "/"
    click_link @mladen.name
    click_link "Add car"
    
    fill_in "Car", with: ""
 
    click_button "Finish"
    expect(page).to have_content("Car not added!")
  end
  
  scenario "with valid inputs" do
    visit "/"
    click_link @mladen.name
    click_link "Add car"
    
    fill_in "Car", with: "Toyota C-HR"
    attach_file "Car image", "spec/pexels-photo-crop1.jpg"
    
    click_button "Finish"
    
    expect(current_path).to eq drivers_show_path
    expect(page).to have_css("img[src*='pexels-photo-crop1.jpg']")
    expect(page).to have_content("Car successfully added!")
  end
  
end