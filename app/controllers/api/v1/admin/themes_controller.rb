class Api::V1::Admin::ThemesController < Api::V1::Admin::AdminController
  before_action :authenticate_admin_token

  def index
    @themes = Theme.all
    render json: @themes, status: 200
  end

  def show
    begin
      @theme = Theme.find(params[:id])
      render json: @theme.to_json, status: 200
    rescue
      render json: { error: "theme not found!" }, status: 400
    end
  end

  def create
    begin
      theme_tags = params[:theme_tags].gsub(/\s+/, "").split(',')
      @theme = Theme.create!(theme_name: params[:theme_name], theme_tags: theme_tags)
      @themes = Theme.all
      render json: @themes, status: 200
    rescue Exception => e
      render json: { error: e }, status: 400
    end
  end

  def update
    begin
      @theme = Theme.find(params[:id])
      if params[:theme_tags].is_a? Array
        theme_tags = params[:theme_tags]
      else
        theme_tags = params[:theme_tags].gsub(/\s+/, "").split(',')
      end
      @theme.update!(theme_name: params[:theme_name], theme_tags: theme_tags)
      @themes = Theme.all
      render json: @themes, status: 200
    rescue Exception => e
      render json: { error: e }, status: 400
    end
  end

  def destroy
    begin
      @theme = Theme.find(params[:id])
      @theme.destroy
      @themes = Theme.all
      render json: @themes, status: 200
    rescue Exception => e
      render json: { error: e }, status: 400
    end
  end

  private

  def theme_params
    params.permit(:theme_name, :theme_tags)
  end
end
