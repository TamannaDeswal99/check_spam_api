# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

10.times do 
    user = User.create(
        name: Faker::Name.name,
        phone_number: Faker::PhoneNumber.unique.phone_number,
        email: Faker::Internet.email,
        password: 'password'
    )

    rand(1..5).times do 
        user.contacts.create(
            name: Faker::Name.name,
            phone_number: Faker::PhoneNumber.phone_number,
            spam: [true, false].sample
        )
    end
end