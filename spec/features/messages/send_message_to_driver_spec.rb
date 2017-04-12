require "rails_helper"

RSpec.feature "Send message to driver" do
  before do
    @mladen = User.create(name: "Mladen", email: "mladen@email.com", password: "password")
    @milos = User.create(name: "Milos", email: "milos@email.com", password: "password")
    @ride1 = @mladen.rides.create(origin_city: "Belgrade", destination_city: "Novi Sad", ride_date: "06-06-2017", ride_time: "16:00:00", price: "1000", seats: "5", details: "Pick you up near Arena")
    @ride2 = @milos.rides.create(origin_city: "Belgrade", destination_city: "Novi Sad", ride_date: "07-06-2017", ride_time: "13:00:00", price: "1700", seats: "3", details: "Pick you up near Usce")
    login_as(@mladen)
    visit "/"

    fill_in "Origin city", with: "belgrade"
    fill_in "Destination city", with: "novi sad"
    click_button "Go!"
  end
  
  scenario do
    expect(page).not_to have_link("Send #{@mladen.first_name} a message")
    click_link("Send #{@milos.first_name} a message")
    
    expect(current_path).to eq(new_message_path)
    
    fill_in "Subject", with: "Ride to Novi Sad"
    fill_in "Message", with: "Hi, is there still a seat available?"
    click_button("Send")
    
    expect(page).to have_content("Message has been sent!")
    expect(current_path).to eq(search_rides_dashboards_path)
  end
end