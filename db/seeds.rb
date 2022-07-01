# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Category.create!({ name: 'Burger', user_id: '1' })
# Category.create!({ name: 'Drinks', user_id: '1' })
# Category.create!({ name: 'Pizza', user_id: '1' })
# Category.create!({ name: 'Biryani', user_id: '1' })
# Item.create!({ title: 'Soup', description: 'Corn Soup', price: '22', user_id: '2', retire: '0', quantity: '2' })
# Item.create!({ title: 'Pulao', description: 'Rice', price: '454', user_id: '2', retire: '0', quantity: '55' })
# Item.create!({ title: 'JamySheerin', description: 'Drink', price: '233', user_id: '2', retire: '0', quantity: '2' })
# Item.create!({ title: 'Roo Afza', description: 'Drink', price: '22', user_id: '1', retire: '0', quantity: '3' })
# Item.create!({ title: 'Dall Makhni', description: 'Dall', price: '22', user_id: '3', retire: '0', quantity: '4' })
# Item.create!({ title: 'Development', description: 'Web', price: '44', user_id: '3', retire: '0', quantity: '2' })
# create users
usr = User.create!(email: 'demo+josh@jumpstartlab.com', password: 'password', role: 'admin', fname: 'Josh ', lname: 'Cheek', dname: 'josh')
User.create!(email: 'usama.imran@devsinc.com', password: 'password', role: 'admin', fname: 'Usama', lname: 'Imran', dname: 'Xam')
User.create!(email: 'demo+rachel@jumpstartlab.com', password: 'password', role: 'standard', fname: 'Rachel ', lname: 'Warbelow')
User.create!(email: 'demo+jeff@jumpstartlab.com', password: 'password', role: 'standard', fname: 'Jeff', lname: 'Casimir', dname: 'j3')
User.create!(email: 'demo+jorge@jumpstartlab.com', password: 'password', role: 'standard', fname: 'Usama', lname: 'Imran', dname: 'novohispano')
# create category
cat = Category.create!(user_id: usr.id, name: 'Biryani')
cat.avatar.attach(io: File.open(Rails.root.join('app/assets/images/no_img.jpg')), filename: 'no_img.jpg')
# Create Items
itm = Item.create!(title: 'Kolkata biryani', description: 'Biryani', user_id: usr.id, price: '22', retire: 'false', quantity: '22')
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/no_img.jpg')), filename: 'no_img.jpg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)
itm = Item.create!(title: 'Kolkata biryani', description: 'Biryani', user_id: usr.id, price: '43', retire: 'false', quantity: '531')
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/no_img.jpg')), filename: 'no_img.jpg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)
itm = Item.create!(title: 'Sindhi Biryani', description: 'Biryani', user_id: usr.id, price: '43', retire: 'false', quantity: '11')
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/no_img.jpg')), filename: 'no_img.jpg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)
itm = Item.create!(title: 'Malabar biryani', description: 'Biryani', user_id: usr.id, price: '44', retire: 'false', quantity: '33')
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/no_img.jpg')), filename: 'no_img.jpg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)
itm = Item.create!(title: 'Ambur biryani', description: 'Biryani', user_id: usr.id, price: '41', retire: 'false', quantity: '22')
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/no_img.jpg')), filename: 'no_img.jpg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)

# create category
cat = Category.create!(user_id: usr.id, name: 'Pizza')
cat.avatar.attach(io: File.open(Rails.root.join('app/assets/images/no_img.jpg')), filename: 'no_img.jpg')
# Create Items
itm = Item.create!(title: 'Veggie Pizza', description: 'Pizza', user_id: usr.id, price: '22', retire: 'false', quantity: '22')
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/no_img.jpg')), filename: 'no_img.jpg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)
itm = Item.create!(title: 'Pepperoni Pizza', description: 'Pizza', user_id: usr.id, price: '43', retire: 'false', quantity: '531')
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/no_img.jpg')), filename: 'no_img.jpg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)
itm = Item.create!(title: 'BBQ Chicken Pizza', description: 'Pizza', user_id: usr.id, price: '43', retire: 'false', quantity: '11')
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/no_img.jpg')), filename: 'no_img.jpg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)

# create category
cat = Category.create!(user_id: usr.id, name: 'Drinks')
cat.avatar.attach(io: File.open(Rails.root.join('app/assets/images/no_img.jpg')), filename: 'no_img.jpg')
# Create Items
itm = Item.create!(title: 'Coke', description: 'Drinks', user_id: usr.id, price: '22', retire: 'false', quantity: '22')
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/no_img.jpg')), filename: 'no_img.jpg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)
itm = Item.create!(title: 'Pepsi', description: 'Drinks', user_id: usr.id, price: '43', retire: 'false', quantity: '531')
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/no_img.jpg')), filename: 'no_img.jpg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)
itm = Item.create!(title: '7Up', description: 'Drink', user_id: usr.id, price: '43', retire: 'false', quantity: '11')
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/no_img.jpg')), filename: 'no_img.jpg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)
itm = Item.create!(title: 'Sting', description: 'Drink', user_id: usr.id, price: '43', retire: 'false', quantity: '11')
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/no_img.jpg')), filename: 'no_img.jpg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)

# create category
cat = Category.create!(user_id: usr.id, name: 'Steak')
cat.avatar.attach(io: File.open(Rails.root.join('app/assets/images/no_img.jpg')), filename: 'no_img.jpg')
# Create Items
itm = Item.create!(title: 'Garllic Steak', description: 'Steak', user_id: usr.id, price: '22', retire: 'false', quantity: '22')
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/no_img.jpg')), filename: 'no_img.jpg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)
itm = Item.create!(title: 'Cheezy Steak', description: 'Steak', user_id: usr.id, price: '43', retire: 'false', quantity: '531')
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/no_img.jpg')), filename: 'no_img.jpg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)
itm = Item.create!(title: 'Masala Steak', description: 'Steak', user_id: usr.id, price: '43', retire: 'false', quantity: '11')
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/no_img.jpg')), filename: 'no_img.jpg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)
itm = Item.create!(title: 'Smokey Steak', description: 'Steak', user_id: usr.id, price: '43', retire: 'false', quantity: '11')
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/no_img.jpg')), filename: 'no_img.jpg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)
