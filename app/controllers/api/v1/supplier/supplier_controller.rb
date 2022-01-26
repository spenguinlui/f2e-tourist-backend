class Api::V1::Supplier::SupplierController < ApplicationController

  protected

  def authenticate_model_token
    super
  end

  private

  def define_model
    @model = Supplier
  end
end