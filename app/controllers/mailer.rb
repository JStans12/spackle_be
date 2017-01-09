class UserMailer < ActionMailer::Base
  default :from => "joseph.r.stansfield@gmail.com"

  def registration_confirmation(user)
    @user = user
    mail(to: "#{@user.email}", subject: "Spackle Email Confirmation")
  end
end
