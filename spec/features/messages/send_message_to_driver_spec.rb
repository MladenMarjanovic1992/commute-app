require "rails_helper"

RSpec.feature "Send message to driver" do
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
    click_link(@mladen.name)
    click_link "Add car"
    
    fill_in "Car", with: "Toyota C-HR"
    attach_file "Car image", "spec/pexels-photo-crop1.jpg"
    
    click_button "Finish"
    click_link "Sign out"
    
    visit "/"
    
    click_link "Sign up"
    fill_in "Name", with: "Milos"
    fill_in "Email", with: "milos@email.com"
    fill_in "About me", with: "Hi I'm Milos."
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    attach_file "Image", "spec/pexels-photo-crop1.jpg"
    click_button "Sign up"
    @milos = User.last
    
    @ride1 = @mladen.rides.create(origin_city: "Belgrade", destination_city: "Budapest", ride_date: "06-06-2017", ride_time: "16:00:00", price: "1000", seats: "5", details: "Pick you up near Arena")

    visit "/"

    fill_in "Origin city", with: "belgrade"
    fill_in "Destination city", with: "Budapest"
    click_button "Go!"
  end
  
  scenario do
    expect(page).to have_link("Send message")
    click_link("Send message")
    
    expect(current_path).to eq(new_message_path)
    
    fill_in "Subject", with: "Ride to Budapest"
    fill_in "Message", with: "Hi, is there still a seat available?"
    click_button("Send")
    
    expect(page).to have_content("Message has been sent!")
    expect(current_path).to eq(search_rides_dashboards_path)
  end
end