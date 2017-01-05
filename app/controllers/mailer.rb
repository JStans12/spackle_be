class UserMailer < ActionMailer::Base
  default :from => "joseph.r.stanfield@gmail.com"

  def registration_confirmation(user)
    @user = user
    mail(to: "#{user.name} <#{user.email}>", subject: "Spackle Email Confirmation")
  end
end
