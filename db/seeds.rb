# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# create users
usr = User.create!(
  email: 'demo+josh@jumpstartlab.com',
  password: 'password',
  role: 'admin',
  fname: 'Josh ',
  lname: 'Cheek',
  dname: 'josh'
)
User.create!(
  email: 'usama.imran@devsinc.com',
  password: 'password',
  role: 'admin',
  fname: 'Usama',
  lname: 'Imran',
  dname: 'Xam'
)
User.create!(
  email: 'demo+rachel@jumpstartlab.com',
  password: 'password',
  role: 'standard',
  fname: 'Rachel ',
  lname: 'Warbelow'
)
User.create!(
  email: 'demo+jeff@jumpstartlab.com',
  password: 'password',
  role: 'standard',
  fname: 'Jeff',
  lname: 'Casimir',
  dname: 'j3'
)
User.create!(
  email: 'demo+jorge@jumpstartlab.com',
  password: 'password',
  role: 'standard',
  fname: 'Usama',
  lname: 'Imran',
  dname: 'novohispano'
)
# create category
cat = Category.create!(user_id: usr.id, name: 'Biryani')
cat.avatar.attach(io: File.open(Rails.root.join('app/assets/images/buryani.jpg')), filename: 'buryani.jpg')
# Create Items
itm = Item.create!(
  title: 'Mumbai biryani',
  description: 'Biryani',
  user_id: usr.id,
  price: '22',
  retire: 'false',
  quantity: '22'
)
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/buryani.jpg')), filename: 'buryani.jpg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)
itm = Item.create!(
  title: 'Kolkata biryani',
  description: 'Biryani',
  user_id: usr.id,
  price: '43',
  retire: 'false',
  quantity: '531'
)
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/buryani.jpg')), filename: 'buryani.jpg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)
itm = Item.create!(
  title: 'Sindhi Biryani',
  description: 'Biryani',
  user_id: usr.id,
  price: '43',
  retire: 'false',
  quantity: '11'
)
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/buryani.jpg')), filename: 'buryani.jpg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)
itm = Item.create!(
  title: 'Malabar biryani',
  description: 'Biryani',
  user_id: usr.id,
  price: '44',
  retire: 'false',
  quantity: '33'
)
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/buryani.jpg')), filename: 'buryani.jpg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)
itm = Item.create!(
  title: 'Ambur biryani',
  description: 'Biryani',
  user_id: usr.id,
  price: '41',
  retire: 'false',
  quantity: '22'
)
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/buryani.jpg')), filename: 'buryani.jpg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)

# create category
cat = Category.create!(user_id: usr.id, name: 'Pizza')
cat.avatar.attach(io: File.open(Rails.root.join('app/assets/images/pizza.jpg')), filename: 'pizza.jpg')
# Create Items
itm = Item.create!(
  title: 'Veggie Pizza',
  description: 'Pizza',
  user_id: usr.id,
  price: '22',
  retire: 'false',
  quantity: '22'
)
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/pizza.jpg')), filename: 'pizza.jpg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)
itm = Item.create!(
  title: 'Pepperoni Pizza',
  description: 'Pizza',
  user_id: usr.id,
  price: '43',
  retire: 'false',
  quantity: '531'
)
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/pizza.jpg')), filename: 'pizza.jpg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)
itm = Item.create!(
  title: 'BBQ Chicken Pizza',
  description: 'Pizza',
  user_id: usr.id,
  price: '43',
  retire: 'false',
  quantity: '11'
)
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/pizza.jpg')), filename: 'pizza.jpg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)

# create category
cat = Category.create!(user_id: usr.id, name: 'Drinks')
cat.avatar.attach(io: File.open(Rails.root.join('app/assets/images/drinks.jpeg')), filename: 'drinks.jpeg')
# Create Items
itm = Item.create!(
  title: 'Coke',
  description: 'Drinks',
  user_id: usr.id,
  price: '22',
  retire: 'false',
  quantity: '22'
)
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/drinks.jpeg')), filename: 'drinks.jpeg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)
itm = Item.create!(
  title: 'Pepsi',
  description: 'Drinks',
  user_id: usr.id,
  price: '43',
  retire: 'false',
  quantity: '531'
)
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/drinks.jpeg')), filename: 'drinks.jpeg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)
itm = Item.create!(title: '7Up', description: 'Drink', user_id: usr.id, price: '43', retire: 'false', quantity: '11')
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/drinks.jpeg')), filename: 'drinks.jpeg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)
itm = Item.create!(
  title: 'Sting',
  description: 'Drink',
  user_id: usr.id,
  price: '43',
  retire: 'false',
  quantity: '11'
)
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/drinks.jpeg')), filename: 'drinks.jpeg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)

# create category
cat = Category.create!(user_id: usr.id, name: 'Steak')
cat.avatar.attach(io: File.open(Rails.root.join('app/assets/images/steak.jpeg')), filename: 'steak.jpeg')
# Create Items
itm = Item.create!(
  title: 'Garllic Steak',
  description: 'Steak',
  user_id: usr.id,
  price: '22',
  retire: 'false',
  quantity: '22'
)
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/steak.jpeg')), filename: 'steak.jpeg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)
itm = Item.create!(
  title: 'Cheezy Steak',
  description: 'Steak',
  user_id: usr.id,
  price: '43',
  retire: 'false',
  quantity: '531'
)
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/steak.jpeg')), filename: 'steak.jpeg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)
itm = Item.create!(
  title: 'Masala Steak',
  description: 'Steak',
  user_id: usr.id,
  price: '43',
  retire: 'false',
  quantity: '11'
)
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/steak.jpeg')), filename: 'steak.jpeg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)
itm = Item.create!(
  title: 'Smokey Steak',
  description: 'Steak',
  user_id: usr.id,
  price: '43',
  retire: 'false',
  quantity: '11'
)
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/steak.jpeg')), filename: 'steak.jpeg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)

# create category
cat = Category.create!(user_id: usr.id, name: 'Chinese')
cat.avatar.attach(io: File.open(Rails.root.join('app/assets/images/chines.jpeg')), filename: 'chines.jpeg')
# Create Items
itm = Item.create!(
  title: 'Shandong Cuisine',
  description: 'Chiese',
  user_id: usr.id,
  price: '22',
  retire: 'false',
  quantity: '22'
)
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/chines.jpeg')), filename: 'chines.jpeg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)
itm = Item.create!(
  title: 'Zhejiang',
  description: 'Chiese',
  user_id: usr.id,
  price: '43',
  retire: 'false',
  quantity: '531'
)
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/chines.jpeg')), filename: 'chines.jpeg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)
itm = Item.create!(
  title: 'Fujian',
  description: 'Chiese',
  user_id: usr.id,
  price: '43',
  retire: 'false',
  quantity: '11'
)
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/chines.jpeg')), filename: 'chines.jpeg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)
itm = Item.create!(
  title: 'Szechuan',
  description: 'Chiese',
  user_id: usr.id,
  price: '43',
  retire: 'false',
  quantity: '11'
)
itm.avatar.attach(io: File.open(Rails.root.join('app/assets/images/chines.jpeg')), filename: 'chines.jpeg')
# attach category with items
CategoriesItem.create!(category_id: cat.id, item_id: itm.id)
