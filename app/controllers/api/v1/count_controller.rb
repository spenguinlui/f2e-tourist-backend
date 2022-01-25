class Api::V1::CountController < ApplicationController

  # post
  def add_search
    item_count = ItemCount.new(request.body.string)
    item_count.check_body
    item_count.find_or_create("add_search")
    render json: item_count.json, status: item_count.status
  end

  # post
  def add_enter
    item_count = ItemCount.new(request.body.string)
    item_count.check_body
    item_count.find_or_create("add_enter")
    render json: item_count.json, status: item_count.status
  end

  # post
  def add_favorite
    item_count = ItemCount.new(request.body.string)
    item_count.check_body
    item_count.find_or_create("add_favorite")
    render json: item_count.json, status: item_count.status
  end

  # post
  def remove_favorite
    item_count = ItemCount.new(request.body.string)
    item_count.check_body
    item_count.find_or_create("remove_favorite")
    render json: item_count.json, status: item_count.status
  end

end
