require 'faker'

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
        mobileNumber: Faker::PhoneNumber.cell_phone,
        website: Faker::Internet.url,
        fax: Faker::Internet.email,
    )
end

createUserContractor("ahmed@mail.com", "ahmed", "123456", "ahmed");
createUserContractor("mohamed@mail.com", "mohamed", "123456", "mohamed");
createUserContractor("nouran@mail.com", "nouran", "123456", "nouran");
createUserContractor("zeyad@mail.com", "zeyad", "123456", "zeyad");

10.times do 
    createUserContractor(Faker::Internet.email, Faker::Name.name, "123456", Faker::Name.unique.name); 
end 

20.times do
    System.create!(
        consumption: Faker::Number.between(from: 50, to: 500),
        latitude: (Faker::Address.latitude).to_f.round(6),
        longitude: (Faker::Address.longitude).to_f.round(6),
        address: Faker::Address.full_address,
        city: Faker::Address.city,
        backup: [true, false].sample,
        country: Faker::Address.country,
        user_id: (User.all.sample).id
    )
    Calculation.create!(
        system_circuits: Faker::Number.between(from: 1, to: 10),
        panels_num: Faker::Number.between(from: 5, to: 60),
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
        description: Faker::Lorem.paragraph_by_chars(number: 200, supplemental: false),
    )
end

9.times do |t|
    5.times do |time|
        Offer.create!(
            proposal: Faker::Lorem.sentence(word_count: 20, supplemental: true),
            price: Faker::Number.between(from: 20000, to: 100000),
            post_id: (Post.last.id) - t,
            contractor_id: (Contractor.first.id) + (t + time),
        )
        Offer.create!(
            proposal: Faker::Lorem.sentence(word_count: 20, supplemental: true),
            price: Faker::Number.between(from: 20000, to: 100000),
            post_id: (Post.first.id) + t,
            contractor_id: (Contractor.first.id) + (t + time),
        )
    end

    (Offer.last).post.update(closed: true)
    (Offer.last).update(status: :accepted)

    OfferRate.create!(
        rate: Faker::Number.between(from: 1, to: 5),
        offer_id: (Offer.last).id,
        user_id: (Offer.last).post.user_id,
    )
    OfferReview.create!(
        review: Faker::Hacker.say_something_smart,
        offer_id: (Offer.last).id,
        user_id: (Offer.last).post.user_id,
    )
end

AdminUser.create!(email: "admin@admin.com", password: "admin123", password_confirmation: "admin123")

Category.create!(category: "PV panel")
Category.create!(category: "Battery")
Category.create!(category: "Inverter")
Category.create!(category: "Charger Controller")
Category.create!(category: "Installations")
Category.create!(category: "Maintenance")

10.times do |t1|
    Tutorial.create!(
        title: Faker::FunnyName.two_word_name,
        body: Faker::Lorem.sentence(word_count: 30, supplemental: true),
        contractor_id: Contractor.all.sample.id,
        category_id: Category.all.sample.id,
    )
    2.times do |t2|
        Comment.create!(
            review: Faker::Hacker.say_something_smart,
            tutorial_id: Tutorial.last.id,
            user_id: User.all.sample.id,
        )
        Like.create!(
            islike: [true, false].sample,
            tutorial_id: Tutorial.last.id,
            user_id: t1 + 1 + t2,
        )
    end
end