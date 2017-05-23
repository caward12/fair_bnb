def stub_facebook
  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
    privider: 'facebook',
    uid: '12345',
    info:{
      email: 'ward.colleen.a@gmail.com',
      first_name: 'Colleen',
      last_name: 'Ward',
      image: "http://graph.facebook.com/v2.6/10100295829467675/picture",
      verified: true
    },
    credentials: {
      token: ENV['FACEBOOK_USER_TOKEN'],
      expires_at: 1500312576,
      expires: true
    }
    })

end

def stub_google
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
    provider: 'google',
    uid: "108878560139118396968",
    info: {
      name: "Beth K",
      email: "bethknight1234@gmail.com",
      first_name: "Beth",
      last_name: "K",
      image: "https://lh6.googleusercontent.com/-LLQghVrGuz8/AAAAAAAAAAI/AAAAAAAAAeY/NvLBwfaHEJA/s50-c/photo.jpg"
    },
    credentials: {
      token: "ya29.GltOBEMN4S-ke5aQEWsZTWx2VN4gW0sZ3TzpE4AcYd6662RG0e2DBGl-LS9grUTCBwdOR7IEfLiwoAVLsZqTDxVstAS1NDpvmZ33DQ40hNllWSzAIja7b6ZlYlQ-",
      refresh_token: "1/V-yVGxQuMFwZrafORBiXVvBNn3bhvocQ7lliukW9FaQ",
      expires_at: 1495138014,
      expires: true
    }
  })
end

def stub_properties
  [
  {"listing": {
        "bathrooms": 1,
        "bedrooms": 1,
        "beds": 1,
        "city": "Denver",
        "id": 6333040,
        "instant_bookable": false,
        "is_business_travel_ready": true,
        "is_family_preferred": false,
        "is_new_listing": false,
        "lat": 39.759501027197835,
        "lng": -104.973942708577,
        "localized_city": "Denver",
        "name": "1880s Carriage House in Curtis Park",
        "neighborhood": "Five Points",
        "person_capacity": 3,
        "picture_count": 24,
        "picture_url": "https://a0.muscache.com/im/pictures/82774624/64c5edef_original.jpg?aki_policy=large",
        "primary_host": {
          "first_name": "Mick",
          "has_profile_pic": true,
          "id": 32967501,
          "picture_url": "https://a0.muscache.com/im/users/32967501/profile_pic/1435596878/original.jpg?aki_policy=profile_x_medium",
          "smart_name": "Mick",
          "thumbnail_url": "https://a0.muscache.com/im/users/32967501/profile_pic/1435596878/original.jpg?aki_policy=profile_small",
          "is_superhost": true
        },
        "property_type": "Guesthouse",
        "property_type_id": 40,
        "public_address": "Denver, CO, United States",
        "reviews_count": 259,
        "room_type": "Entire home/apt",
        "room_type_category": "entire_home",
        "scrim_color": "#282015",
        "star_rating": 5,
        "thumbnail_url": "https://a0.muscache.com/im/pictures/82774624/64c5edef_original.jpg?aki_policy=small",
        "user": {
          "first_name": "Mick",
          "has_profile_pic": true,
          "id": 32967501,
          "picture_url": "https://a0.muscache.com/im/users/32967501/profile_pic/1435596878/original.jpg?aki_policy=profile_x_medium",
          "smart_name": "Mick",
          "thumbnail_url": "https://a0.muscache.com/im/users/32967501/profile_pic/1435596878/original.jpg?aki_policy=profile_small",
          "is_superhost": true
        },
        "user_id": 32967501,
        "xl_picture_url": "https://a0.muscache.com/im/pictures/82774624/64c5edef_original.jpg?aki_policy=x_large",
        "preview_encoded_png": "iVBORw0KGgoAAAANSUhEUgAAAAUAAAADCAIAAADUVFKvAAAAO0lEQVQIHQEwAM//Aa96SOgBEQ0VF8zV2ebj7QFUSDI+MSciLzf6Afmurb4BRDUjKh0MSE1Q/g4ftKqs0JwS2rz3A+UAAAAASUVORK5CYII=",
        "picture_urls": [
          "https://a0.muscache.com/im/pictures/82774624/64c5edef_original.jpg?aki_policy=large",
          "https://a0.muscache.com/im/pictures/83626473/33f0a1eb_original.jpg?aki_policy=large",
          "https://a0.muscache.com/im/pictures/83625357/7b53f441_original.jpg?aki_policy=large",
          "https://a0.muscache.com/im/pictures/82776151/532fcb95_original.jpg?aki_policy=large",
          "https://a0.muscache.com/im/pictures/83625645/d61a7034_original.jpg?aki_policy=large",
          "https://a0.muscache.com/im/pictures/83625622/c620664a_original.jpg?aki_policy=large",
          "https://a0.muscache.com/im/pictures/83625604/9df0179c_original.jpg?aki_policy=large",
          "https://a0.muscache.com/im/pictures/83625331/c789576b_original.jpg?aki_policy=large",
          "https://a0.muscache.com/im/pictures/83625483/6c00d510_original.jpg?aki_policy=large",
          "https://a0.muscache.com/im/pictures/83625521/d2b69337_original.jpg?aki_policy=large",
          "https://a0.muscache.com/im/pictures/83625396/0a9668d6_original.jpg?aki_policy=large",
          "https://a0.muscache.com/im/pictures/83625378/d26c6645_original.jpg?aki_policy=large",
          "https://a0.muscache.com/im/pictures/83625543/676e8822_original.jpg?aki_policy=large",
          "https://a0.muscache.com/im/pictures/83625593/838c5989_original.jpg?aki_policy=large",
          "https://a0.muscache.com/im/pictures/82886816/a5765458_original.jpg?aki_policy=large",
          "https://a0.muscache.com/im/pictures/83625465/937a9cab_original.jpg?aki_policy=large",
          "https://a0.muscache.com/im/pictures/83625442/c8696c36_original.jpg?aki_policy=large",
          "https://a0.muscache.com/im/pictures/83625421/8cbd3bd7_original.jpg?aki_policy=large",
          "https://a0.muscache.com/im/pictures/83625572/08de09fc_original.jpg?aki_policy=large",
          "https://a0.muscache.com/im/pictures/83625294/f729b1dd_original.jpg?aki_policy=large",
          "https://a0.muscache.com/im/pictures/83625765/c3ab8823_original.jpg?aki_policy=large",
          "https://a0.muscache.com/im/pictures/101079841/5a3b6f1d_original.jpg?aki_policy=large",
          "https://a0.muscache.com/im/pictures/d37e788b-5b4a-4465-a3a0-4a8042d592a9.jpg?aki_policy=large",
          "https://a0.muscache.com/im/pictures/5476c8c8-3978-4e9a-bf9d-0422d50aa12f.jpg?aki_policy=large"
        ],
        "xl_picture_urls": [
          "https://a0.muscache.com/im/pictures/82774624/64c5edef_original.jpg?aki_policy=x_large",
          "https://a0.muscache.com/im/pictures/83626473/33f0a1eb_original.jpg?aki_policy=x_large",
          "https://a0.muscache.com/im/pictures/83625357/7b53f441_original.jpg?aki_policy=x_large",
          "https://a0.muscache.com/im/pictures/82776151/532fcb95_original.jpg?aki_policy=x_large",
          "https://a0.muscache.com/im/pictures/83625645/d61a7034_original.jpg?aki_policy=x_large",
          "https://a0.muscache.com/im/pictures/83625622/c620664a_original.jpg?aki_policy=x_large",
          "https://a0.muscache.com/im/pictures/83625604/9df0179c_original.jpg?aki_policy=x_large",
          "https://a0.muscache.com/im/pictures/83625331/c789576b_original.jpg?aki_policy=x_large",
          "https://a0.muscache.com/im/pictures/83625483/6c00d510_original.jpg?aki_policy=x_large",
          "https://a0.muscache.com/im/pictures/83625521/d2b69337_original.jpg?aki_policy=x_large",
          "https://a0.muscache.com/im/pictures/83625396/0a9668d6_original.jpg?aki_policy=x_large",
          "https://a0.muscache.com/im/pictures/83625378/d26c6645_original.jpg?aki_policy=x_large",
          "https://a0.muscache.com/im/pictures/83625543/676e8822_original.jpg?aki_policy=x_large",
          "https://a0.muscache.com/im/pictures/83625593/838c5989_original.jpg?aki_policy=x_large",
          "https://a0.muscache.com/im/pictures/82886816/a5765458_original.jpg?aki_policy=x_large",
          "https://a0.muscache.com/im/pictures/83625465/937a9cab_original.jpg?aki_policy=x_large",
          "https://a0.muscache.com/im/pictures/83625442/c8696c36_original.jpg?aki_policy=x_large",
          "https://a0.muscache.com/im/pictures/83625421/8cbd3bd7_original.jpg?aki_policy=x_large",
          "https://a0.muscache.com/im/pictures/83625572/08de09fc_original.jpg?aki_policy=x_large",
          "https://a0.muscache.com/im/pictures/83625294/f729b1dd_original.jpg?aki_policy=x_large",
          "https://a0.muscache.com/im/pictures/83625765/c3ab8823_original.jpg?aki_policy=x_large",
          "https://a0.muscache.com/im/pictures/101079841/5a3b6f1d_original.jpg?aki_policy=x_large",
          "https://a0.muscache.com/im/pictures/d37e788b-5b4a-4465-a3a0-4a8042d592a9.jpg?aki_policy=x_large",
          "https://a0.muscache.com/im/pictures/5476c8c8-3978-4e9a-bf9d-0422d50aa12f.jpg?aki_policy=x_large"
        ]
      },
      "pricing_quote": {
        "available": false,
        "checkin": null,
        "checkout": null,
        "guests": 1,
        "guest_details": {
          "number_of_adults": 1,
          "number_of_children": 0,
          "number_of_infants": 0
        },
        "listing_currency": "USD",
        "localized_currency": "USD",
        "localized_nightly_price": 133,
        "localized_service_fee": 0,
        "localized_total_price": 0,
        "long_term_discount_amount_as_guest": 0,
        "nightly_price": 133,
        "service_fee": 0,
        "total_price": 0
      },
      "viewed_at": null
    }
  ]
end

