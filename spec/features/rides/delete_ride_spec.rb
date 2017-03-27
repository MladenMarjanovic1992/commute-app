require "rails_helper"

RSpec.feature "Deleting ride" do
  
  before do
    @mladen = User.create(email: "mladen@email.com", password: "password")
    login_as(@mladen)
    @ride = @mladen.rides.create(from: "Belgrade", to: "Vienna", ride_date: "06-06-2017", ride_time: "16:00:00", price: "1000", seats: "5", details: "Pick you up near Arena")
  end
  
  scenario do
    visit "/"
    click_link("Find a ride!")
    
    path = "/users/#{@mladen.id}/rides/#{@ride.id}"
    link = "a[href=\'#{path}\']"
    
    find(link).click
    click_link("Delete ride")
    
    expect(page).to have_content("Ride has been deleted!")
    expect(current_path).to eq(root_path)
  end
end