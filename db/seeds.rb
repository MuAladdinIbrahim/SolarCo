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

def createUserContractor(mail, name, password, username)
    User.create!(
        email: mail, 
        name: name,
        username: username,
        password: password)
    Contractor.create!(
        email: mail, 
        name: name, 
        username: username,
        password: password,
        address: Faker::Address.full_address,
    )
end

createUserContractor("ahmed@mail.com", "ahmed", "123456", "ahmed");
createUserContractor("mohamed@mail.com", "mohamed", "123456", "mohamed");
createUserContractor("nouran@mail.com", "nouran", "123456", "nouran");
createUserContractor("zeyad@mail.com", "zeyad", "123456", "zeyad");

2.times do 
    createUserContractor(Faker::Internet.email, Faker::Name.name, "123456", Faker::Name.unique.name); 
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