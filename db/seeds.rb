# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

Product.destroy_all
Category.destroy_all

Category.create(name: "All")

for i in 0..10
  cat = Category.create(name: Faker::Commerce.unique.department(max: 2, fixed_amount: true))

  for i in 0..10
    name = Faker::Commerce.unique.product_name
    prod = Product.create(name: name, description: Faker::Company.bs, category_id: cat.id, price: Faker::Number.within(range: 1500..20000),
                          quantity: Faker::Number.within(range: 0..75), on_sale: Faker::Number.within(range: 0..1),
                          rating: Faker::Number.within(range: 1..5))
    downloaded_image = open(URI.open("https://source.unsplash.com/random/800x600/?#{name.split(" ")[2]}"))
    prod.image.attach(io: downloaded_image, filename: "m-#{name.split(" ")[2]}.jpg")
    sleep(1)
  end
end
