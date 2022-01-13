class Api::V1::Admin::SettingController < Api::V1::Admin::AdminController
  def index
    @settings = Setting.all
    render json: @settings, status: 200
  end

  def update
    begin
      @setting = Setting.find(params[:id])
      @setting.update!(attribute_name: params[:attribute_name], attribute_value: params[:attribute_value])
      @settings = Setting.all
      render json: @settings, status: 200
    rescue Exception => e
      render json: { error: e }, status: 400
    end
  end

  private

  def setting_params
    params.permit(:attribute_name, :attribute_value)
  end
end