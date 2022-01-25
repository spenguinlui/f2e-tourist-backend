class Api::V1::CountController < ApplicationController

  def add_search
    item_count = ItemCount.new(request.body.string)
    item_count.check_body
    item_count.find_or_create("add_search")
    render json: item_count.json, status: item_count.status
  end

  def add_enter
    item_count = ItemCount.new(request.body.string)
    item_count.check_body
    item_count.find_or_create("add_enter")
    render json: item_count.json, status: item_count.status
  end

  def add_favorite
    item_count = ItemCount.new(request.body.string)
    item_count.check_body
    item_count.find_or_create("add_favorite")
    render json: item_count.json, status: item_count.status
  end

  def remove_favorite
    item_count = ItemCount.new(request.body.string)
    item_count.check_body
    item_count.find_or_create("remove_favorite")
    render json: item_count.json, status: item_count.status
  end

end
