require "rails_helper"

RSpec.feature "List rides" do
  before do
    @mladen = User.create(email: "mladen@email.com", password: "password")
    @ride1 = @mladen.rides.create(origin_city: "Belgrade", destination_city: "Vienna", ride_date: "06-06-2017", ride_time: "16:00:00", price: "1000", seats: "5", details: "Pick you up near Arena")
    @ride2 = @mladen.rides.create(origin_city: "Novi Sad", destination_city: "Berlin", ride_date: "06-06-2017", ride_time: "13:00:00", price: "900", seats: "3", details: "Pick you up near Strand")
  end
  
  scenario do
    visit "/"
    
    click_link "Find a ride!"
    
    expect(page).to have_content(@ride1.user.email)
    expect(page).to have_content(@ride1.origin_city)
    expect(page).to have_content(@ride1.destination_city)
    expect(page).to have_content(@ride1.normal_date)
    expect(page).to have_content(@ride1.just_time)
    expect(page).to have_content(@ride1.price)
    expect(page).to have_content(@ride1.seats)
    expect(page).to have_content(@ride1.details)
    
    expect(page).to have_content(@ride2.user.email)
    expect(page).to have_content(@ride2.origin_city)
    expect(page).to have_content(@ride2.destination_city)
    expect(page).to have_content(@ride2.normal_date)
    expect(page).to have_content(@ride2.just_time)
    expect(page).to have_content(@ride2.price)
    expect(page).to have_content(@ride2.seats)
    expect(page).to have_content(@ride2.details)
  end
end