# frozen_string_literal: true
require 'httparty'                                                             
require 'json' 

class Api::V1::User::SessionsController < Api::V1::User::UserController
  include HTTParty
  before_action :define_model
  before_action :authenticate_model_token, only: [:sign_out]

  # post
  def sign_in
    super
  end

  # delete
  def sign_out
    super
  end

  # post
  def check
    super
  end

  # post
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

  # post
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
        @user = User.create_user_for_facebook(user_response.parsed_response)
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
