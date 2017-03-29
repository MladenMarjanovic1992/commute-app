@user_names = ["mladen", "milos", "miodrag", "andrija", "nikola", "vuk", "milica", "ivana", "mila", "aleksandra"]
@car_names = ["Corolla", "Yaris", "Verso", "Auris", "GT86", "Prius", "C-HR", "Auris TS", "Camry", "RAV4"]
@locations = ["Belgrade", "Nis", "Novi Sad", "Vienna", "Budapest", "Athens", "Sofia", "Zagreb"]

def change_to_if_same_as_from(user)
  if user.rides.last.from == user.rides.last.to
    Ride.update(user.id, to: (@locations - [user.rides.last.from]).sample)
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
  user.rides.create!(
    from: @locations.sample,
    to: @locations.sample,
    ride_date: rand(15).days.from_now(Date.today),
    ride_time: Time.at(rand(86400)),
    price: rand(400..2000).round(-2),
    seats: rand(1..5),
    details: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
  )
  change_to_if_same_as_from(user)
  
end
