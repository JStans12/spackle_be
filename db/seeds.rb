User.destroy_all
Page.destroy_all

taylor = User.create(name: "tswift", email: "tswift@hotmail.com")
kanye  = User.create(name: "yeezy", email: "yeezy@hotmail.com")
donald = User.create(name: "yugehands", email: "yugehands@hotmail.com")

reddit = Page.create(url: "https://www.reddit.com/")

unprovoked_aggression = kanye.comment("Taylor sucks!", reddit)
haters_man            = donald.comment("Yeah she does!", reddit, unprovoked_aggression)
thoughtful_response   = taylor.comment("No, you suck!", reddit, unprovoked_aggression)
presidential_grace    = donald.comment("You both suck! Sad!", reddit, thoughtful_response)

taylor.downvote(haters_man)
kanye.downvote(presidential_grace)
