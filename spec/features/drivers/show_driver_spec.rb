require "rails_helper"

RSpec.feature "Show driver" do
  before do
    visit "/"
    
    click_link "Sign up"
    fill_in "Name", with: "Mladen"
    fill_in "Email", with: "mladen@email.com"
    fill_in "About me", with: "Hi I'm Mladen."
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    attach_file "Image", "spec/pexels-photo-crop.jpg"
    click_button "Sign up"
    @mladen = User.last
    login_as(@mladen)
    visit '/'
    click_link(@mladen.name)
    click_link "Add car"
    
    fill_in "Car", with: "Toyota Corolla"
    attach_file "Car image", "spec/pexels-photo-crop1.jpg"
    
    click_button "Finish"
    @ride1 = @mladen.rides.create(origin_city: "Belgrade", destination_city: "Vienna", ride_date: "06-06-2017", ride_time: "16:00:00", price: "1000", seats: "5", details: "Pick you up near Arena")
    @ride2 = @mladen.rides.create(origin_city: "Novi Sad", destination_city: "Berlin", ride_date: "06-06-2017", ride_time: "13:00:00", price: "900", seats: "3", details: "Pick you up near Strand")
  end
  
  scenario do
    visit "/"
    
    click_link(@mladen.name)
    
    expect(page).to have_css("img[src*='pexels-photo-crop.jpg']")
    expect(page).to have_css("img[src*='pexels-photo-crop1.jpg']")

    expect(page).to have_content(@mladen.car.car_name)
    expect(page).to have_content(@ride1.user.name)
    expect(page).to have_content(@ride1.just_origin_city)
    expect(page).to have_content(@ride1.just_destination_city)
    expect(page).to have_content(@ride1.normal_date)
    expect(page).to have_content(@ride1.just_time)
    expect(page).to have_content(@ride1.price)
    expect(page).to have_content(@ride1.seats)
    expect(page).to have_content(@ride1.details)
    
    expect(page).to have_content(@ride2.user.name)
    expect(page).to have_content(@ride2.just_origin_city)
    expect(page).to have_content(@ride2.just_destination_city)
    expect(page).to have_content(@ride2.normal_date)
    expect(page).to have_content(@ride2.just_time)
    expect(page).to have_content(@ride2.price)
    expect(page).to have_content(@ride2.seats)
    expect(page).to have_content(@ride2.details)
    
  end
  
end