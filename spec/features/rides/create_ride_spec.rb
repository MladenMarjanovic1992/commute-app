require "rails_helper"

RSpec.feature "Create a ride" do
  before do
    @mladen = User.create(email: "mladen@email.com", password: "password")
    login_as(@mladen)
  end
  
  scenario "with valid credentials" do 
    visit "/"
    click_link "Share your ride!"
    expect(page).to have_link("Back")
    
    fill_in "From", with: "Belgrade"
    fill_in "To", with: "Veinna"
    fill_in "Ride Date", with: "2017-06-01"
    fill_in "Ride time", with: "12:00"
    fill_in "Seats", with: "3"
    fill_in "Price", with: "1000"
    fill_in "Ride details", with: "I can pick you up at Sava centar or near the Arena."
    
    click_button "Finish"
    
    ride = Ride.last
    
    expect(current_path).to eq("/users/#{@mladen.id}/rides/#{@mladen.rides.last.id}")
    expect(ride.user_id).to eq(@mladen.id)
    expect(page).to have_content("Your ride has been created")
    
  end
  
  scenario "with invalid credentials" do 
    visit "/"
    click_link "Share your ride!"
    expect(page).to have_link("Back")
    
    fill_in "From", with: ""
    fill_in "To", with: ""
    fill_in "Ride Date", with: ""
    fill_in "Ride time", with: ""
    fill_in "Seats", with: ""
    fill_in "Price", with: ""
    fill_in "Ride details", with: ""
    
    click_button "Finish"
    
    expect(page).to have_content("Your ride has not been created")
    
  end
end