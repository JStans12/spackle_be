User.destroy_all
Page.destroy_all

taylor = User.create(name: "tswift", email: "tswift@hotmail.com")
kanye  = User.create(name: "yeezy", email: "yeezy@hotmail.com")
donald = User.create(name: "yugehands", email: "yugehands@hotmail.com")

twitter = Page.create(url: "twitter.com")

unprovoked_aggression = kanye.comment("Taylor sucks!", twitter)
thoughtful_response   = taylor.comment("No, you suck!", twitter, unprovoked_aggression)
presidential_grace    = donald.comment("You both suck! Sad!", twitter, thoughtful_response)

taylor.downvote(unprovoked_aggression)
kanye.downvote(thoughtful_response)
donald.upvote(presidential_grace)
