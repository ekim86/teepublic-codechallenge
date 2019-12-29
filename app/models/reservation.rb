# == Schema Information
#
# Table name: reservations
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  restaurant_id :integer
#  month         :string
#  day           :integer
#  year          :integer
#  time          :time
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Reservation < ActiveRecord::Base
belongs_to :user
belongs_to :restaurant
end
