@user_names = ["mladen", "milos", "miodrag", "andrija", "nikola", "vuk", "milica", "ivana", "mila", "aleksandra"]
@car_names = ["Corolla", "Yaris", "Verso", "Auris", "GT86", "Prius", "C-HR", "Auris TS", "Camry", "RAV4"]
@locations = ["Belgrade", "Sarajevo", "Novi Sad", "Vienna", "Budapest", "Athens", "Sofia", "Zagreb"]

def change_to_if_same_as_from(user)
  if user.rides.last.origin_city == user.rides.last.destination_city
    Ride.update(user.id, origin_city: (@locations - [user.rides.last.destination_city]).sample)
  end
end

@user_names.length.times do |num|
  User.create!(
    email: "#{@user_names[num - 1]}@email.com",
    password: "password",
    image: URI.parse("https://openclipart.org/image/2400px/svg_to_png/212896/wonderfulbeardedbaldman.png")
  )
end

User.all.each do |user|
  user.create_car!(
    car_name: "Toyota #{@car_names[user.id - 1]}",
    car_image: URI.parse("https://openclipart.org/image/2400px/svg_to_png/73711/classic-car.png")
  )
  10.times do 
    user.rides.create!(
      origin_city: @locations.sample,
      destination_city: @locations.sample,
      ride_date: rand(15).days.from_now(Date.today),
      ride_time: Time.at(rand(86400)),
      price: rand(400..2000).round(-2),
      seats: rand(1..5),
      details: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    )
    change_to_if_same_as_from(user)
  end
  
end
