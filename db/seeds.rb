NUM_USER = 4
NUM_CATEGORY = 11
NUM_PRODUCT = 4
CATE_NAME_ARRAY = ['Thời trang nam',
                   'Điện thoại và phụ kiện',
                   'Thiết bị điện tử',
                   'Máy tính và Laptop',
                   'Đồng hồ',
                   'Giày dép nam',
                   'Thiết bị điện gia dụng',
                   'Thể thao và du lịch',
                   'Thời trang nữ',
                   'Giày dép nữ',
                   'Nhà sách'].freeze


puts 'seeding user and store.........'

NUM_USER.times do |n|
  name = Faker::Name.name
  email = "#{n + 1}@example.com"
  password = '111111'
  user = User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    role: 'user',
    address: Faker::Address.full_address,
    gender: 'nam'
  )
  user.skip_confirmation_notification!
  user.skip_confirmation!
  user.save!
  store = user.create_store!(
    name: Faker::Company.name,
    describe: Faker::Lorem.sentence(word_count: 10)
  )
  store.image.attach(
    io: File.open("storage/products/#{n+1}"),
    filename: Faker::Commerce.product_name
  user.image.attach(
    io: File.open("images/avatar/1.jpeg"),
    filename: Faker::Name.name
  )
end

# create category and products ===================================
puts 'seeding category and product...'

NUM_CATEGORY.times do |n|
  # seed category
  cate = Category.create!(name: CATE_NAME_ARRAY[n])
  cate.image.attach(
    io: File.open("storage/category/#{n + 1}"),
    filename: Faker::Name.name
  )
  # seed product of this category
  NUM_PRODUCT.times do |m|
    product = cate.products.create!(
      name: Faker::Commerce.product_name,
      price: Faker::Number.within(range: 10_000..1_000_000),
      description: Faker::Lorem.sentence(word_count: 3),
      quantityInStock: Faker::Number.within(range: 10..5000),
      trademark: Faker::Lorem.word,
      origin: Faker::Space.agency,
      sendFrom: Faker::Marketing.buzzwords,
      store_id: User.first.store.id
    )
    product.images.attach(
      io: File.open("storage/products/#{m + 1}"),
      filename: Faker::Commerce.product_name
    )
    product.images.attach(
      io: File.open("storage/products/#{m + 2}"),
      filename: Faker::Commerce.product_name
    )
    # seed product sale
    sale_data = { promotion: Faker::Number.within(range: 1..100),
                  quantity: Faker::Number.within(range: 10..200),
                  from: Date.today,
                  to: Faker::Date.forward(days: 23) }
    product.create_sale!(sale_data)
  end
end

# Generate a bunch of additional users and store
puts 'seeding cart and order ...'

NUM_USER.times do |n|
  user = User.find(n + 1)
  user.carts.create!(
    product_id: Faker::Number.within(range: 1..NUM_PRODUCT),
    quantity: Faker::Number.within(range: 1..10)
  )
  user.orders.create!(
    product_id: Faker::Number.within(range: 1..NUM_PRODUCT),
    quantity: Faker::Number.within(range: 1..10),
    note: Faker::Lorem.sentence(word_count: 5)
  )
  comment = user.orders[0].create_comment!(
    star: Faker::Number.within(range: 1..5),
    content: Faker::Lorem.sentence(word_count: 5)
  )
end

# # admin
# admin = User.create!(
#   name: "thuong",
#   email: "170210577@vnu.edu.vn",
#   password: "111111",
#   password_confirmation: "111111",
#   role: "admin",
#   address: Faker::Address.full_address
# )
# admin.skip_confirmation_notification!
# admin.skip_confirmation!
# admin.save!
# admin.carts.create!(
#   product_id: Faker::Number.within(range: 1..NUM_PRODUCT),
#   quantity: Faker::Number.within(range: 1..10)
# )
# admin.create_store!(
#   name: Faker::Company.name,
#   describe: Faker::Lorem.sentence(word_count: 10)
# )
