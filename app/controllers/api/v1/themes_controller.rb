class Api::V1::ThemesController < ApplicationController

  def index
    @themes = Theme.all
    render json: @themes, status: 200
  end

  def show
    begin
      @theme = Theme.find(params[:id])
      render json: @theme, status: 200
    rescue
      render json: { error: "theme not found!" }
    end
  end
end
