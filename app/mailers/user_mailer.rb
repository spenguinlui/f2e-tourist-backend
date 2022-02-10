class UserMailer < ApplicationMailer
  default :from => "寄件人名字 <spenguin100@gmail.com>"  

  def reset_password_instructions(user, reset_password_token)
    @user = user
    @reset_password_token = reset_password_token

    mail(to: @user.email, subject: 'test!test!')
  end
end