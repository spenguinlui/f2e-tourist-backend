# frozen_string_literal: true
require 'httparty'                                                             
require 'json' 

class Api::V1::User::SessionsController < Api::V1::User::UserController
  include HTTParty
  before_action :authenticate_user_token, only: [:sign_out]

  def sign_in
    if valid_user?
      render json: { message: "OK", auth_token: @user.auth_token, favorites: @user.favorites }, status: 200
    else
      render json: { message: "無效的電子信箱或密碼" }, status: 401
    end
  end

  def sign_out
    begin
      @user.regenerate_auth_token
      render json: { message: "OK" }, status: 200
    rescue Exception => e
      render json: { message: e }, status: 400
    end
  end

  def google_oauth2
    code = params[:code]

    if not code.blank?
      begin
        response = get_token_by_onetime_code(code)
        puts "--------第一次 token response"
        puts response.parsed_response

        access_token = response.parsed_response["access_token"]
        id_token = response.parsed_response["id_token"]
        
        email_response = get_info_by_token(access_token, id_token)

        puts "--------第二次 token response"
        puts email_response.parsed_response
        @user = User.create_user_for_google(email_response.parsed_response)

        @tokens = @user.auth_token  if @user.persisted?     
        render json: { token: @tokens }, status: 200
      rescue Exception => e
        render json: { message: e }, status: 400
      end
    else
      render json: { message: "無參數傳入" }, status: 400
    end
  end

  def facebook
    code = params[:code]
    if not code.blank?
      begin
        # 取得長期 token
        load = {
          client_id: ENV["FACEBOOK_CLIENT_ID"],
          client_secret: ENV["FACEBOOK_CLIENT_SECRET"],
          grant_type: 'fb_exchange_token',
          fb_exchange_token: code
        }
        url = "https://graph.facebook.com/oauth/access_token"
        response = HTTParty.post(url, :query => load)
        puts "--------第一次 token response"
        puts response.parsed_response
        access_token = response.parsed_response["access_token"]

        # 取得個人資訊
        user_url = "https://graph.facebook.com/#{params[:userId]}?fields=id,name,email,picture&access_token=#{access_token}"
        user_response = HTTParty.get(user_url)
        puts "--------第二次 token response"
        puts user_response.parsed_response

        # 找尋 user 或建立
        @user = User.create_user_for_google(user_response.parsed_response)
        @tokens = @user.auth_token  if @user.persisted?

        render json: { token: @tokens }, status: 200
      rescue Exception => e
        render json: { message: e }, status: 400
      end
    else
      render json: { message: "無參數傳入" }, status: 400
    end
  end

  private

  def user_params
    params.permit(:email, :password, :name)
  end

  def valid_user?
    @user = User.find_by(email: params[:email])
    return false if @user.blank?
    @user.valid_password?(params[:password])
  end

  def get_token_by_onetime_code(code)
    @client_id = ENV["GOOGLE_CLIENT_ID"]
    @client_secret = ENV["GOOGLE_CLIENT_SECRET"]
    grant_type = 'authorization_code'
    load = {
      client_id: @client_id,
      client_secret: @client_secret,
      redirect_uri: 'postmessage',
      grant_type: grant_type,
      code: code
    }
    url = "https://www.googleapis.com/oauth2/v3/token"
    response = HTTParty.post(url, :query => load)
    response
  end

  def get_info_by_token(access_token, id_token)
    @client_id = ENV["GOOGLE_CLIENT_ID"]
    @client_secret = ENV["GOOGLE_CLIENT_SECRET"]
    url = "https://www.googleapis.com/oauth2/v3/tokeninfo"
    load = {
      client_id: @client_id,
      client_secret: @client_secret,
      token_type: "Bearer",
      redirect_uri: 'postmessage',
      access_token: access_token,
      id_token: id_token
    }
    response = HTTParty.post(url, :query => load)
    response
  end
end
