require "rails_helper"

RSpec.feature "Create a ride" do
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
    login_as(@mladen)
    visit "/"
    click_link(@mladen.name)
    click_link "Add car"
    
    fill_in "Car", with: "Toyota C-HR"
    attach_file "Car image", "spec/pexels-photo-crop1.jpg"
    
    click_button "Finish"
  end
  
  scenario "with valid credentials" do 
    visit "/"
    click_link "Share your ride!"
    expect(page).to have_link("Back")
    
    fill_in "origin-city", with: "Belgrade"
    fill_in "destination-city", with: "Vienna"
    fill_in "Ride Date", with: "06-01-2017"
    fill_in "Ride time", with: "12:00"
    fill_in "Seats", with: "3"
    fill_in "Price", with: "1000"
    fill_in "Ride details", with: "I can pick you up at Sava centar or near the Arena."
    
    click_button "Finish"
    
    ride = Ride.last
    
    expect(current_path).to eq("/users/#{@mladen.id}/rides/#{ride.id}")
    expect(ride.user_id).to eq(@mladen.id)
    expect(page).to have_content("Your ride has been created")
    
  end
  
  scenario "with invalid credentials" do 
    visit "/"
    click_link "Share your ride!"
    expect(page).to have_link("Back")
    
    fill_in "origin-city", with: ""
    fill_in "destination-city", with: ""
    fill_in "Ride Date", with: ""
    fill_in "Ride time", with: ""
    fill_in "Seats", with: ""
    fill_in "Price", with: ""
    fill_in "Ride details", with: ""
    
    click_button "Finish"
    
    expect(page).to have_content("Your ride has not been created")
    
  end
end