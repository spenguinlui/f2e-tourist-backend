class Api::V1::User::PasswordsController < Api::V1::User::UserController

  def create
    begin
      @user = User.find_by_email(user_params)
  
      if @user.present?
        @reset_password_token = get_reset_password_token(@user)
        UserMailer.reset_password_instructions(@user, @reset_password_token).deliver_now
  
        render :json => { message: "忘記密碼發信成功", reset_password_token: @reset_password_token, status: 200 }
      else
        render :json => { message: "查無此帳號", status: 400 }
      end
    rescue Exception => e
      logger.error "----- 忘記密碼連結發生錯誤！！！ -> #{e}"
      render :json => { message: "發生不明錯誤", status: 500 }, :status => :bad_request
    end
  end
  
  def edit
    begin
      @user = User.with_reset_password_token(reset_password_params[:reset_password_token])
      if @user.present?
        @user.update!(password: reset_password_params[:new_password])

        render :json => { message: "修改密碼成功", status: 200 }
      else
        render :json => { message: "連結已失效", status: 400 }, :status => :bad_request
      end
    rescue Exception => e
      logger.error "----- 修改密碼發生錯誤！！！ -> #{e}"
      render :json => { message: "發生不明錯誤", status: 500 }, :status => :bad_request
    end
  end

  private

  def user_params
    params.require(:email)
  end

  def reset_password_params
    params.permit(:reset_password_token, :new_password)
  end

  # 做出 token , raw 是使用, enc 是db內存
  def get_reset_password_token user
    raw, enc = Devise.token_generator.generate(User, :reset_password_token)
    user.reset_password_token = enc
    user.reset_password_sent_at = Time.now.utc
    user.save
    raw
  end
end