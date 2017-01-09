class UserMailer < ActionMailer::Base
  default :from => "joey@spackle.co"

  def registration_confirmation(user)
    @user = user
    mail(to: "#{@user.email}", subject: "Spackle Email Confirmation")
  end
end
