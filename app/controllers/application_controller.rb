class ApplicationController < ActionController::API
  # include ActionController::Cookies
  # include ActionController::RequestForgeryProtection

  # protect_from_forgery with: :exception

  # before_action :set_csrf_cookie

  protected

  def authenticate_user_token
    puts "auth_token"
    puts params[:auth_token]
    puts @user
    @user = User.find_by(auth_token: params[:auth_token])
    return render(json: { message:'無效的 auth_token' }, status: 401) if @user.nil?

    sign_in(@user, store: false)
  end

  private

  # def set_csrf_cookie
  #   cookies['CSRF-TOKEN'] = form_authenticity_token
  # end

end
