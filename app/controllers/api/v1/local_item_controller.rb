class Api::V1::LocalItemController < ApplicationController

  # get
  def show
    begin
      @local_item = LocalItem.includes(:comments).find_by(ptx_data_id: params[:id])
      @average_score = @local_item.present? ? @local_item.average_score : 3.5 # 這是預設分數
      @comments = @local_item.present? ? @local_item.comments : []

      render :json => { message: "成功取在地景點資料", local_item: @local_item, comments: @comments, average_score: @average_score, status: 200 }
    rescue Exception => e
      logger.error "----- 使用者註冊發生錯誤！！！ -> #{e}"
      render :json => { message: "發生不明錯誤", status: 500 }, :status => :bad_request
    end
  end

  # post
  def create_comment
    begin
      @local_item = LocalItem.find_by(ptx_data_id: params[:id])
      @new_local_item = @local_item.comments.new(comment_params)
      @user = get_user(params[:auth_token])
      @new_local_item.user_id = @user.id

      @new_local_item.save!

      # research
      @local_item = LocalItem.find_by(ptx_data_id: params[:id])

      render :json => { message: "新增評論成功", comments: @local_item.comments, average_score:  @local_item.average_score, status: 200 }
    rescue Exception => e
      logger.error "----- 新增評論發生錯誤！！！ -> #{e}"
      render :json => { message: "發生不明錯誤", status: 500 }, :status => :bad_request
    end
  end

  # post
  def average_scores
    begin
      @average_scores = []
      LocalItem.includes(:comments).where(ptx_data_id: params[:ids]).find_each do |local_item|
        @average_scores << {
          id: local_item.ptx_data_id,
          average_score: local_item.average_score,
        }
      end
      render :json => { message: "成功取得景點評分", average_scores: @average_scores, status: 200 }
    rescue Exception => e
      logger.error "----- 取得景點評分發生錯誤！！！ -> #{e}"
      render :json => { message: "發生不明錯誤", status: 500 }, :status => :bad_request
    end
  end

  private

  def comment_params
    params.permit(:title, :score, :content)
  end

  def get_user auth_token
    user = User.find_by(auth_token: auth_token) || User.find_by(email: "anonymous@aaa.bb")
    user
  end
end