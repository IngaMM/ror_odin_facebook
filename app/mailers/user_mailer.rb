class UserMailer < ApplicationMailer
  default from: 'welcome@contactbook.com'

  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to Contactbook')
  end
end
