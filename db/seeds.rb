User.destroy_all
Page.destroy_all

deleted    = User.create(name: "deleted", email: "deleted@hotmail.com", password: "p", password_confirmation: "p")
taylor     = User.create(name: "tswift", email: "tswift@hotmail.com", password: "p", password_confirmation: "p")
kanye      = User.create(name: "yeezy", email: "yeezy@hotmail.com", password: "p", password_confirmation: "p")
donald     = User.create(name: "yugehands", email: "yugehands@hotmail.com", password: "p", password_confirmation: "p")
taylor_fan = User.create(name: "kuntryboi69", email: "kuntryboi69@hotmail.com", password: "p", password_confirmation: "p")

deleted.confirmed!
taylor.confirmed!
kanye.confirmed!
donald.confirmed!
taylor_fan.confirmed!

reddit = Page.create(url: "https://www.reddit.com/")

unprovoked_aggression = kanye.comment("Taylor sucks!", reddit)
haters_man            = donald.comment("Yeah she does!", reddit, unprovoked_aggression)
thoughtful_response   = taylor.comment("No, you suck!", reddit, unprovoked_aggression)
presidential_grace    = donald.comment("You both suck! Sad!", reddit, thoughtful_response)
nasty_stuff           = taylor.comment("Kanye sucks!", reddit)
bit_of_an_ego         = kanye.comment("What are you talking about? I am literally god's gift to Earth. My ego is even bigger than Donny's", reddit, nasty_stuff)
not_to_be_outdone     = donald.comment("Kayne says he has the biggest ego... Sad! You know, it's just so sad. My people - and i've got the best people - they tell me, the reassure me ever day that no one could ever out-ego me.", reddit)

taylor.downvote(unprovoked_aggression)
taylor_fan.downvote(unprovoked_aggression)
donald.upvote(unprovoked_aggression)
taylor.downvote(haters_man)
taylor_fan.downvote(haters_man)

kanye.downvote(nasty_stuff)
donald.upvote(nasty_stuff)
taylor_fan.upvote(nasty_stuff)
donald.downvote(bit_of_an_ego)
taylor_fan.downvote(bit_of_an_ego)
