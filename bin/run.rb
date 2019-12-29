require_relative '../config/environment'

def start
  prompt =  TTY::Prompt.new 
  
  choices = [
    {name: 'Login', value: 1},
    {name: 'Create a username', value: 2},
    {name: 'Exit', value: 3}
  ]

  user_input = prompt.select('Please select a prompt', choices) do |menu|
    menu.choice 'Login', -> do
      user_email_input = prompt.ask("Email:")
      user = User.find_by(email: user_email_input)
      user_password_input = prompt.mask("Password:")
      if user.password != user_password_input
        puts "WOMP WOMP... Wrong password, good try. Bye 👋"
        user = nil
      end
      user
    end
    menu.choice 'Create an account', -> do
      user_name_input = prompt.ask("Please enter your name:")
      user_email_input = prompt.ask("Please enter your email address:")
      user_password_input = prompt.mask("Please create a password:")
      User.create(
        name: user_name_input,
        email: user_email_input,
        password: user_password_input
      )
    end
    menu.choice 'Exit', -> do
      exit_app
    end
  end
end

def choices(user)
  prompt = TTY::Prompt.new
  
  choices = [
    {name: 'See all reservations', value: 1},
    {name: 'Make a reservation', value: 2},
    {name: 'Exit', value: 3}
  ]

  user_input = prompt.select('Please select a prompt', choices)
end

def all_reservations(user)
  user_reservations = user.reservations.reload
  reservations = user_reservations.map do |reservation|
    {
      name: "Reservation at #{reservation.restaurant.name} on #{reservation.month} #{reservation.day}, #{reservation.year}",
      value: reservation.id
    }
  end
  reservations << { name: 'Go Back', value: 0}
  prompt = TTY::Prompt.new
  selected_reservation_id = prompt.select('Please choose a reservation to see more details', reservations)

  if selected_reservation_id > 0
    selected_reservation = Reservation.find(selected_reservation_id)
    reservation_detail(selected_reservation)
  end
end

def reservation_detail(reservation)
  prompt = TTY::Prompt.new
  puts "🍽  You have an upcoming reservation at #{reservation.restaurant.name} for a party of #{reservation.party_size}."
  puts "📍 The restaurant address is #{reservation.restaurant.address}, #{reservation.restaurant.city}, #{reservation.restaurant.state} #{reservation.restaurant.zip_code}."
  puts "🗓  Your reservation is on #{reservation.month} #{reservation.day}, #{reservation.year} at #{reservation.time}."
  
  choices = [
    { name: 'Update reservation', value: 1 },
    { name: 'Delete reservation', value: 2 },
    { name: 'Go back to list of all my reservations', value: 3 }
  ]
  user_input = prompt.select("Please choose the following", choices)
  case user_input
  when 1
    update_reservation(reservation)
  when 2
    delete_reservation(reservation)
  when 3
    all_reservations(reservation.user)
  end
end

def update_reservation(reservation)
  prompt = TTY::Prompt.new
  reservation_detail = [
    { name: "Restaurant: #{reservation.restaurant.name}", disabled: "can't update" },
    { name: "Date: #{reservation.month} #{reservation.day}, #{reservation.year}", disabled: "can't update" },
    { name: "Time: #{reservation.time}", value: "Time" },
    { name: "Party size: #{reservation.party_size}", value: "Party size"}
  ]
  user_input = prompt.select('Choose what you would like to update:', reservation_detail)
  case user_input
  when "Time"
    time_list = ["12:00 PM", "12:15 PM", "12:30 PM", "12:45 PM", "1:00 PM"]
    new_time = prompt.select('Choose a new time', time_list, filter: true)
    reservation.update(time: new_time)
  when "Party size"
    party_size_list = (1..5).to_a
    new_party_size = prompt.select(
      'Update your party size',
      party_size_list,
      filter: true
    )
    reservation.update(party_size: new_party_size)
  end

  reservation_detail(reservation)
end

def delete_reservation(reservation)
  prompt = TTY::Prompt.new
  options = [
    { name: 'Y', value: 'y'},
    { name: 'N', value: 'n'}
  ]
  delete_check = prompt.select("Are you sure you want to delete this reservation?", options)
  case delete_check
  when 'y'
    reservation.delete
    all_reservations(reservation.user)
  when 'n'
    reservation_detail(reservation)
  end
end

def make_reservation(user)
  prompt = TTY::Prompt.new
  restaurant_list = Restaurant.all.map(&:name)
  chosen_restaurant = prompt.select(
    'Choose your restaurant',
    restaurant_list,
    filter: true
    )
  restaurant = Restaurant.find_by(name: chosen_restaurant)
  year_list = [2019, 2020]
  chosen_year = prompt.select(
    'Please select a year',
    year_list,
    filter: true
    )
  month_list = ["January", "February", "March", "April", "May", "June", "July", "August", "Septemer", "October", "November", "December"]
  chosen_month = prompt.select(
    'Please select a month',
    month_list,
    filter: true
    )
  day_list = (1..31).to_a
  chosen_day = prompt.select(
    'Please select a day',
    day_list,
    filter: true
    )
  time_list = ["12:00 PM", "12:15 PM", "12:30 PM", "12:45 PM", "1:00 PM"]
  chosen_time = prompt.select(
    'Please select a time',
    time_list,
    filter: true
    )
  party_size_list = (1..5).to_a
  chosen_party_size = prompt.select(
    'How many people are in your parrrty?',
    party_size_list,
    filter: true
    )
  Reservation.create(
    user_id: user.id,
    restaurant_id: restaurant.id,
    month: chosen_month,
    day: chosen_day,
    year: chosen_year,
    time: chosen_time,
    party_size: chosen_party_size
  )
end

def exit_app
  puts "Thank you for using Reservations. See you next time! 👋"
  pastel = Pastel.new
  font = TTY::Font.new(:starwars)
  puts pastel.bright_cyan(font.write("bye!"))
end

def run
  pastel = Pastel.new
  font = TTY::Font.new(:starwars)
  puts pastel.bright_cyan(font.write("nomz!"))
  puts pastel.on_bright_magenta("Welcome to Reservations!")
  puts "🍽"
  user = start
  return exit_app if !user.is_a?(User)

  user_input = choices(user)
  while user_input != 3
    case user_input
    when 1
      all_reservations(user)
    when 2
      make_reservation(user)
    end
    user_input = choices(user)
  end
  exit_app
end

run