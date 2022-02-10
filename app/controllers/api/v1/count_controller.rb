class Api::V1::CountController < ApplicationController

  # post
  def add_search
    begin
      item_count = ItemCount.new(request.body.string)
      item_count.check_body
      item_count.find_or_create("add_search")
      render :json => { message: item_count.json, status: item_count.status }
    rescue Exception => e
      logger.error "----- 增加搜尋次數發生錯誤！！！ -> #{e}"
      render :json => { message: "發生不明錯誤", status: 500 }, :status => :bad_request
    end
  end

  # post
  def add_enter
    begin
      item_count = ItemCount.new(request.body.string)
      item_count.check_body
      item_count.find_or_create("add_enter")
      render :json => { message: item_count.json, status: item_count.status }
    rescue Exception => e
      logger.error "----- 增加進入次數發生錯誤！！！ -> #{e}"
      render :json => { message: "發生不明錯誤", status: 500 }, :status => :bad_request
    end
  end

  # post
  def add_favorite
    begin
      item_count = ItemCount.new(request.body.string)
      item_count.check_body
      item_count.find_or_create("add_favorite")
      render :json => { message: item_count.json, status: item_count.status }
    rescue Exception => e
      logger.error "----- 增加我的最愛次數發生錯誤！！！ -> #{e}"
      render :json => { message: "發生不明錯誤", status: 500 }, :status => :bad_request
    end
  end

  # post
  def remove_favorite
    begin
      item_count = ItemCount.new(request.body.string)
      item_count.check_body
      item_count.find_or_create("remove_favorite")
      render :json => { message: item_count.json, status: item_count.status }
    rescue Exception => e
      logger.error "----- 減少我的最愛次數發生錯誤！！！ -> #{e}"
      render :json => { message: "發生不明錯誤", status: 500 }, :status => :bad_request
    end
  end
end
