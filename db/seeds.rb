# Generate a bunch of additional users and store
puts "seeding user..."
NUM_USER = 4

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
  user.skip_confirmation_notification!
  user.skip_confirmation!
  user.save!
  user.create_store!(
    name: Faker::Company.name
  )
end

admin = User.create!(
  name: "thuong",
  email: "170210577@vnu.edu.vn",
  password: "111111",
  password_confirmation: "111111",
  role: "admin"
)
admin.skip_confirmation_notification!
admin.skip_confirmation!
admin.save!
admin.create_store!(
  name: Faker::Company.name
)

# create category and products ===================================
puts "seeding category and product..." 

NUM_CATEGORY = 4
NUM_PRODUCT = 4
CATE_NAME_ARRAY = ["Thời trang nam",
"Điện thoại và phụ kiện",
"Thiết bị điện tử",
"Máy tính và Laptop",
"Đồng hồ",
"Giày dép nam",
"Thiết bị điện gia dụng",
"Thể thao và du lịch",
"Thời trang nữ",
"Giày dép nữ",
"Nhà sách"]
NUM_CATEGORY.times do |n|
  cate = Category.create(name:CATE_NAME_ARRAY[n])
  # cate.image.attach(
  #   io: File.open("storage/category/#{n+1}"),
  #   filename: Faker::Name.name
  # )
  NUM_PRODUCT.times do |m|
    product = cate.products.create!(
      name: Faker::Commerce.product_name,
      price: Faker::Number.within(range: 10000..1000000),
      description: Faker::Lorem.sentence(word_count: 3),
      quantityInStock: Faker::Number.within(range: 10..5000),
      trademark: Faker::Lorem.word,
      origin: Faker::Space.agency,
      sendFrom: Faker::Marketing.buzzwords,
      store_id: Faker::Number.within(range: 1..NUM_USER)
    )
    # product.images.attach(
    #   io: File.open("storage/products/#{m+1}"),
    #   filename: Faker::Commerce.product_name
    # )
    # product.images.attach(
    #   io: File.open("storage/products/#{m+1}"),
    #   filename: Faker::Commerce.product_name
    # )
    sale_data = {promotion: Faker::Number.within(range: 1..100),
            quantity: Faker::Number.within(range: 10..5000),
            from: Date.today,
            to: Faker::Date.forward(days: 23)
          }
    product.create_sale!(sale_data)
  end
end


