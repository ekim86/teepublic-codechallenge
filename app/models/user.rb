# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  password   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
has_many :reservations
has_many :restaurants, through: :reservations

prompt =  TTY::Prompt.new

def login
  #   user_input = prompt.ask("Please enter your password:")
#   if user.password == user_input
#   else
# else
#   puts "Email is not found. Please create an account."
# end

end


def new_reservations
  Reservation.create(user_id: self.id, restaurant_id: restaurant.id, month: month, day: day, year: year, time: time)
end

end
