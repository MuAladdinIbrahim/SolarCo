# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.create(email: 'user@example.com', nickname: 'UOne', name: 'User One', password: "monkey67")AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
require 'faker'

# User.create!(email: 'user@example.com', nickname: 'UOne', name: 'User One', password: "monkey67")
# User.create!(
#     email: Faker::Internet.email, 
#     name: Faker::Name.name, 
#     password: "123456")
# Contractor.create!(
#     email: Faker::Internet.email, 
#     name: Faker::Name.name, 
#     password: "123456",
#     address: Faker::Address.full_address,
# )

def createUserContractor(mail, name, password)
    User.create!(
        email: mail, 
        name: name, 
        password: password)
    Contractor.create!(
        email: mail, 
        name: name, 
        password: password,
        address: Faker::Address.full_address,
    )
end

createUserContractor("ahmed@mail.com", "ahmed", "123456");
createUserContractor("muhammad@mail.com", "muhammad", "123456");
createUserContractor("nouran@mail.com", "nouran", "123456");
createUserContractor("zeyad@mail.com", "zeyad", "123456");

2.times do 
    createUserContractor(Faker::Internet.email, Faker::Name.name, "123456"); 
end 

10.times do
    System.create!(
        consumption: Faker::Number.between(from: 50, to: 100),
        latitude: (Faker::Address.latitude).to_f,
        longitude: (Faker::Address.longitude).to_f,
        city: Faker::Address.city,
        country: Faker::Address.country,
        user_id: (User.all.sample).id
    )
    Calculation.create!(
        system_circuits: Faker::Number.between(from: 1, to: 10),
        panels_num: Faker::Number.between(from: 2, to: 60),
        panel_watt: 250,
        battery_Ah: 200,
        batteries_num: Faker::Number.between(from: 2, to: 30),
        inverter_watt: Faker::Number.between(from: 500, to: 2000),
        mppt_amp: Faker::Number.between(from: 10, to: 100),
        system_id: (System.last).id
    )
    Post.create!(
        user_id: (System.last).user_id,
        system_id: (System.last).id,
        title: Faker::FunnyName.two_word_name,
        description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false),
    )
end

20.times do
    Offer.create!(
        proposal: Faker::Lorem.sentence(word_count: 20, supplemental: true),
        price: Faker::Number.between(from: 1000, to: 10000),
        contractor_id: (Contractor.all).sample.id,
        post_id: (Post.all).sample.id,
    )
end

40.times do
    OfferRate.create!(
        rate: Faker::Number.between(from: 0, to: 5),
        offer_id: (Offer.all).sample.id,
        user_id: (User.all).sample.id,
    )
    OfferReview.create!(
        review: Faker::Hacker.say_something_smart,
        offer_id: (Offer.all).sample.id,
        user_id: (User.all).sample.id,
    )
end
