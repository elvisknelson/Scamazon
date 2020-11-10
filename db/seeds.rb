# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

Product.destroy_all
Category.destroy_all

for i in 0..10
  cat = Category.create(name: Faker::Commerce.unique.department(max: 2, fixed_amount: true))

  for i in 0..10
    name = Faker::Commerce.unique.product_name
    tes = Product.create(name: name, description: Faker::Company.bs, category_id: cat.id, price: Faker::Number.within(range: 1500..20000),
                         image: "https://source.unsplash.com/random/800x600/?#{name.split(" ")[2]}", quantity: Faker::Number.within(range: 0..75))
  end
end
