# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

Category.destroy_all
Product.destroy_all

for i in 0..4
  cat = Category.create(name: Faker::Name.unique.name)
  puts cat.name

  for i in 0..2
    tes = Product.create(name: Faker::Food.unique.dish, category_id: cat.id)
    puts "  -#{tes.name}"
  end
end
