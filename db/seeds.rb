User.destroy_all
Restaurant.destroy_all
Reservation.destroy_all

eunice = User.create(name: "Eunice", email: "eunice@email.com", password: "1111")
deborah = User.create(name: "Deborah", email: "deborah@email.com", password: "2222")
christine = User.create(name: "Christine", email: "christine@email.com", password: "3333")
steven = User.create(name: "Steven", email: "steven@email.com", password: "4444")

roses = Restaurant.create(name: "Rose's Luxury", address: "717 8th St SE", city: "Washington", state: "DC", zip_code: 20003)
founding_farmers = Restaurant.create(name: "Founding Farmers", address: "12505 Park Potomac Ave", city: "Potomac", state: "MD", zip_code: 20854)
bon_fresco = Restaurant.create(name: "Bon Fresco", address: "534 Gaither Rd", city: "Rockville", state: "MD", zip_code: 20850)

res_1 = Reservation.create(user_id: eunice.id, restaurant_id: roses.id, month: "January", day: 30, year: 2020, time: "7:00 PM", party_size: 5)
res_2 = Reservation.create(user_id: christine.id, restaurant_id: roses.id, month: "December", day: 30, year: 2019, time: "8:45 PM", party_size: 2)
res_3 = Reservation.cr
eate(user_id: deborah.id, restaurant_id: bon_fresco.id, month: "January", day: 1, year: 2020, time: "6:45 PM", party_size: 3)
res_4 = Reservation.create(user_id: steven.id, restaurant_id: founding_farmers.id, month: "March", day: 12, year: 2020, time: "12:45 PM", party_size: 4)
res_5 = Reservation.create(user_id: eunice.id, restaurant_id: roses.id, month: "June", day: 6, year: 2020, time: "11:45 AM", party_size: 1)
