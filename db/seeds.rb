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

Category.find(2).products.create(
  name: "shoe black",
  picture: "https://lorempixel.com/200/200",
  price: 200000
)
