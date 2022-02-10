class Api::V1::Admin::AdminController < ApplicationController

  protected

  def authenticate_model_token
    define_model
    super
  end

  private

  def define_model
    @model = Admin
  end
end