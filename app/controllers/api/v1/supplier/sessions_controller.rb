# frozen_string_literal: true

class Api::V1::Supplier::SessionsController < Api::V1::Supplier::SupplierController
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
end
