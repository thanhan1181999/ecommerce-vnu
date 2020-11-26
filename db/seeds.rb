# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Category.create!(name: "Thời trang nam", 
#   picture: Faker::LoremPixel.image(size:"200x200"))
# Category.create!(name: "Thời trang nữ", 
#   picture: Faker::LoremPixel.image(size:"200x200"))
# Category.create!(name: "Mẹ & bé", 
#   picture: Faker::LoremPixel.image(size:"200x200"))


# frozen_string_literal: true

# Generate a bunch of additional users.
NUM_USER = 20

NUM_USER.times do |n|
  name = Faker::Name.name
  email = "#{n + 1}example@example.com"
  password = '111111'

  user = User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    role: "user"
  )
  user.skip_confirmation!
  user.save!
  user.create_store!(
    name: "the gioi di dong"
  )
end

admin = User.create!(
  name: "thuong",
  email: "17021057@vnu.edu.vn",
  password: "111111",
  password_confirmation: "111111",
  role: "admin"
)
admin.skip_confirmation!
admin.save!

admin.create_store!(
  name: "linh kien dien tu"
)


Category.create!(name: "Thời trang nam", 
  image: Faker::LoremPixel.image(size:"200x200"))
Category.create!(name: "Thời trang nữ", 
  image: Faker::LoremPixel.image(size:"200x200"))
Category.create!(name: "Mẹ & bé", 
  image: Faker::LoremPixel.image(size:"200x200"))

Category.find(2).products.create(
  name: "shoe black",
  image: "https://lorempixel.com/200/200",
  price: 200000,
  stores_id: 1
)
Category.find(2).products.create(
  name: "shoe red",
  image: "https://lorempixel.com/200/200",
  price: 200000,
  stores_id: 1
)


