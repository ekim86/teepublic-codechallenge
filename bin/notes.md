require_relative '../config/environment'
 
prompt =  TTY::Prompt.new
#rake start to start program
 
 
 
def start
 prompt =  TTY::Prompt.new
 prompt.select("Please select a prompt") do |menu|
   menu.choice 'Login', -> do
     user_email_input = prompt.ask("please enter your email:")
     user = User.find_by(email: user_email_input)
     # if user
     #   user.login
     # else
     #   prompt.select("Try again or Sign-up") do |menu|
     #     menu.choice 'Try again'
     #     menu.choice 'Sign-up'
     #   end
     # binding.pry
     # end
   end
     menu.choice 'Sign-up', -> do
       user_name_input = prompt.ask("please enter your name:")
       user_email_input = prompt.ask("please enter your email address:")
       user_password_input = prompt.mask("please enter your password:")
       # once the user inputs all the info save it and create a new user
       User.create(name: user_name_input, email: user_email_input, password: user_password_input)
       # create_reservation
     end
   end
 end
 
 
# 1. have user select whether to login or sign up
 
 
# 2. if they select login- enter email and pw
# if email doesn't exist tell them it doesn't exist and give them the option to sign up
#   if the email exists then have them enter their pw
#     if their pw is wrong tell them to pw is not correct and try again
#       if not they can go back and sign up
#         if everything goes well then login they can see their
#           reservations, or make or delete a reservation
# 3. if they select sign-up- enter name, email, and pw
# look up restaurant and can type the restaurant name and it filters as they type
# warriors = %w(Scorpion Kano Jax Kitana Raiden)
# prompt.select('Choose your destiny?', warriors, filter: true)
 
# choices = [
#         {name: 'See all reservations', value: 1},
#         {name: 'Make a reservation', value: 2},
#         {name: 'Exit', value: 3}
#       ]
    
 
 
def reservation_choices(user)
prompt =  TTY::Prompt.new
 choices = [
   {name: 'See all reservations', value: 1},
   {name: 'Make a reservation', value: 2},
   {name: 'Exit', value: 3}
 ]
 user_input = prompt.select("Select an action?", choices) do |menu|
 # prompt.select("Please select a prompt") do |menu|
   menu.choice 'See all reservations', -> do
   end
   menu.choice 'Make a reservation', -> do
     restaurant_list = Restaurant.all.map(&:name)
     chosen_restaurant = prompt.select(
       'Choose your restaurant',
       restaurant_list,
       filter: true
       )
     # binding.pry
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
   menu.choice 'Exit', -> do
     exit_app
   end
 end
 # case user_input
 # when 1
 #   # Functionality for Choice 1 goes here
 #   puts "Searching for a new job..."
 # when 2
 #   # Functionality for Choice 2 goes here
 #   puts "Loading your applications..."
 # when 3
 #   # Functionality for Choice 3 goes here
 #   puts "Exiting application..."
 # end
end
 
 
def exit_app
 puts "Thank you for using Reservations. See you next time! 👋"
end
 
def run
 puts "Welcome to Reservations"
 puts "🍽" #entry point
 user = start
 # while
   reservation_choices(user)
 
# binding.pry
end
 
 
 
run
 
 

