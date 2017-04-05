require "rails_helper"

RSpec.feature "Editing ride" do
  
  before do
    @mladen = User.create(email: "mladen@email.com", password: "password")
    login_as(@mladen)
    @ride = @mladen.rides.create(origin_city: "Belgrade", destination_city: "Vienna", ride_date: "06-06-2017", ride_time: "16:00:00", price: "1000", seats: "5", details: "Pick you up near Arena")
  end
  
  scenario "with valid inputs" do
    visit "/"
    click_link(@mladen.email)
    
    path = "/users/#{@mladen.id}/rides/#{@ride.id}"
    link = "a[href=\'#{path}\']"
    
    find(link).click
    click_link("Edit ride")
    
    expect(page).to have_link("Back")
    
    fill_in "origin-city", with: "Novi Sad"
    fill_in "destination-city", with: "Berlin"
    fill_in "Ride Date", with: "06-06-2017"
    fill_in "Ride time", with: "13:00"
    fill_in "Seats", with: "2"
    fill_in "Price", with: "700"
    fill_in "Ride details", with: "I can pick you up at Zeleni venac."
    
    click_button "Finish"
    
    expect(current_path).to eq("/users/#{@mladen.id}/rides/#{@ride.id}")
    
    expect(page).to have_content("Ride successfully updated!")
    expect(page).to have_content("Novi Sad")
    expect(page).to have_content("Berlin")
    expect(page).to have_content("06-06-2017")
    expect(page).to have_content("13:00")
    expect(page).to have_content("2")
    expect(page).to have_content("700")
    expect(page).to have_content("I can pick you up at Zeleni venac.")
  end
  
  scenario "with valid inputs" do
    visit "/"
    click_link(@mladen.email)
    
    path = "/users/#{@mladen.id}/rides/#{@ride.id}"
    link = "a[href=\'#{path}\']"
    
    find(link).click
    click_link("Edit ride")
    
    expect(page).to have_link("Back")
    
    fill_in "origin-city", with: ""
    fill_in "destination-city", with: ""
    fill_in "Ride Date", with: ""
    fill_in "Ride time", with: ""
    fill_in "Seats", with: ""
    fill_in "Price", with: ""
    fill_in "Ride details", with: ""
    
    click_button "Finish"
    
    expect(page).to have_content("Ride has not been updated!")

  end
  
end