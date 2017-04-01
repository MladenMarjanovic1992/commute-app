require "rails_helper"

RSpec.feature "Search rides" do
  before do
    @mladen = User.create(email: "mladen@email.com", password: "password")
    @ride1 = @mladen.rides.create(origin_city: "Belgrade", destination_city: "Novi Sad", ride_date: "06-06-2017", ride_time: "16:00:00", price: "1000", seats: "5", details: "Pick you up near Arena")
    @ride2 = @mladen.rides.create(origin_city: "Vienna", destination_city: "Berlin", ride_date: "07-06-2017", ride_time: "13:00:00", price: "1700", seats: "3", details: "Pick you up near Strand")
    @ride3 = @mladen.rides.create(origin_city: "Belgrade", destination_city: "Novi Sad", ride_date: "09-06-2017", ride_time: "15:00:00", price: "1100", seats: "2", details: "Pick you up in Zemun")
    @ride4 = @mladen.rides.create(origin_city: "Belgrade", destination_city: "Zagreb", ride_date: "08-06-2017", ride_time: "17:00:00", price: "1500", seats: "1", details: "Pick you up near Zeleni venac")
  end
  
  scenario "from homepage when ride exists" do
    visit "/"

    fill_in "Origin city", with: "belgrade"
    fill_in "Destination city", with: "novi sad"
    click_button "Go!"
    
    expect(page).to have_content(@ride1.user.email)
    expect(page).to have_content(@ride1.origin_city)
    expect(page).to have_content(@ride1.destination_city)
    expect(page).to have_content(@ride1.normal_date)
    expect(page).to have_content(@ride1.just_time)
    expect(page).to have_content(@ride1.price)
    expect(page).to have_content(@ride1.seats)
    expect(page).to have_content(@ride1.details[0..51])
    
    expect(page).not_to have_content(@ride2.origin_city)
    expect(page).not_to have_content(@ride2.destination_city)
    expect(page).not_to have_content(@ride2.normal_date)
    expect(page).not_to have_content(@ride2.just_time)
    expect(page).not_to have_content(@ride2.price)
    expect(page).not_to have_content(@ride2.seats)
    expect(page).not_to have_content(@ride2.details[0..51])
  end
  
  scenario "from homepage when ride doesn't exist" do
    visit "/"
    
    fill_in "Origin city", with: "belgrade"
    fill_in "Destination city", with: "berlin"
    click_button "Go!"
    
    expect(page).to have_content("Sorry, there are no rides with your parameters.")
  end
  
  scenario "from search page with all parameters" do
    visit "/"

    click_button "Go!"
    
    fill_in "Origin city", with: "belgrade"
    fill_in "Destination city", with: "novi sad"
    fill_in "search-ride-date", with: "06-06-2017"
    fill_in "price-from", with: "600"
    fill_in "price-to", with: "1100"
    click_button "Go!"
    
    expect(page).to have_content(@ride1.user.email)
    expect(page).to have_content(@ride1.origin_city)
    expect(page).to have_content(@ride1.destination_city)
    expect(page).to have_content(@ride1.normal_date)
    expect(page).to have_content(@ride1.just_time)
    expect(page).to have_content(@ride1.price)
    expect(page).to have_content(@ride1.seats)
    expect(page).to have_content(@ride1.details[0..51])

  end
  
  scenario "from search page with price parameters" do
    visit "/"

    click_button "Go!"
    
    fill_in "price-from", with: "600"
    fill_in "price-to", with: "1100"
    click_button "Go!"
    
    expect(page).to have_content(@ride1.user.email)
    expect(page).to have_content(@ride1.origin_city)
    expect(page).to have_content(@ride1.destination_city)
    expect(page).to have_content(@ride1.normal_date)
    expect(page).to have_content(@ride1.just_time)
    expect(page).to have_content(@ride1.price)
    expect(page).to have_content(@ride1.seats)
    expect(page).to have_content(@ride1.details[0..51])
    
    expect(page).to have_content(@ride3.origin_city)
    expect(page).to have_content(@ride3.destination_city)
    expect(page).to have_content(@ride3.normal_date)
    expect(page).to have_content(@ride3.just_time)
    expect(page).to have_content(@ride3.price)
    expect(page).to have_content(@ride3.seats)
    expect(page).to have_content(@ride3.details[0..51])
    
  end
  
  scenario "from search page with date parameters" do
    visit "/"

    click_button "Go!"
    
    fill_in "Origin city", with: ""
    fill_in "Destination city", with: ""
    fill_in "search-ride-date", with: "08-06-2017"
    click_button "Go!"
    
    expect(page).to have_content(@ride4.user.email)
    expect(page).to have_content(@ride4.origin_city)
    expect(page).to have_content(@ride4.destination_city)
    expect(page).to have_content(@ride4.normal_date)
    expect(page).to have_content(@ride4.just_time)
    expect(page).to have_content(@ride4.price)
    expect(page).to have_content(@ride4.seats)
    expect(page).to have_content(@ride4.details[0..51])
    
  end
  
end