class Api::V1::ThemesController < ApplicationController

  # get
  def index
    @themes = Theme.all
    render json: @themes, status: 200
  end

  # get
  def show
    begin
      @theme = Theme.find(params[:id])
      render json: @theme.to_json, status: 200
    rescue
      render json: { error: "theme not found!" }
    end
  end
end
