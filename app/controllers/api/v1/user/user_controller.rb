class Api::V1::User::UserController < ApplicationController

  protected

  def authenticate_model_token
    define_model
    super
  end

  private

  def define_model
    @model = User
  end
end