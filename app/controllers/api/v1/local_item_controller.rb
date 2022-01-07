class Api::V1::LocalItemController < ApplicationController

  def show
    @local_item = LocalItem.joins(:comments).find_by(ptx_data_id: params[:id])
    @average_score = @local_item.comments.reduce(0) {|start, comment| start + comment.score } / @local_item.comments.length

    render json: { local_item: @local_item, comments: @local_item.comments, average_score: @average_score }, status: 200
  end
end