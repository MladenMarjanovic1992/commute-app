require "rails_helper"

RSpec.feature "Deleting ride" do
  
  before do
    @mladen = User.create(name: "Mladen", email: "mladen@email.com", password: "password")
    login_as(@mladen)
    visit "/"
    click_link(@mladen.name)
    click_link "Add car"
    
    fill_in "Car", with: "Toyota C-HR"
    attach_file "Car image", "spec/pexels-photo-crop1.jpg"
    
    click_button "Finish"
  
    @ride = @mladen.rides.create(origin_city: "Belgrade", destination_city: "Vienna", ride_date: "06-06-2017", ride_time: "16:00:00", price: "1000", seats: "5", details: "Pick you up near Arena")
  end
  
  scenario do
    visit "/"
    click_link(@mladen.name)
    
    path = "/users/#{@mladen.id}/rides/#{@ride.id}"
    link = "a[href=\'#{path}\']"
    
    find(link).click
    click_link("Delete ride")
    
    expect(page).to have_content("Ride has been deleted!")
    expect(current_path).to eq(root_path)
  end
end