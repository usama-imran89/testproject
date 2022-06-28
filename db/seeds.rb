# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#Category.create!({ name: 'Burger', user_id: '1' })
#Category.create!({ name: 'Drinks', user_id: '1' })
#Category.create!({ name: 'Pizza', user_id: '1' })
#Category.create!({ name: 'Biryani', user_id: '1' })
#Item.create!({ title: 'Soup', description: 'Corn Soup', price: '22', user_id: '2', retire: '0', quantity: '2' })
#Item.create!({ title: 'Pulao', description: 'Rice', price: '454', user_id: '2', retire: '0', quantity: '55' })
#Item.create!({ title: 'JamySheerin', description: 'Drink', price: '233', user_id: '2', retire: '0', quantity: '2' })
#Item.create!({ title: 'Roo Afza', description: 'Drink', price: '22', user_id: '1', retire: '0', quantity: '3' })
#Item.create!({ title: 'Dall Makhni', description: 'Dall', price: '22', user_id: '3', retire: '0', quantity: '4' })
#Item.create!({ title: 'Development', description: 'Web', price: '44', user_id: '3', retire: '0', quantity: '2' })
User.create!(
  email: 'demo+josh@jumpstartlab.com',
  password: 'password',
  role: 'admin',
  fname: 'Josh',
  lname: 'Cheek',
  dname: 'josh'
)
