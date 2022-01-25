class LocalItem < ApplicationRecord
  has_many :comments, :dependent => :destroy

  scope :has_comment, -> { joins(:comments).where("comments.local_item_id IS NOT NULL").references(:comments) }

  def average_score
    if self.comments.length > 0
      self.comments.reduce(0) {|start, comment| start + comment.score } / self.comments.length
    else
      3.5
    end
  end

  def self.order_by_hot(params)
    skip = params[:skip]
    top = params[:top]
    search_weight = Setting.find_by(attribute_name: 'search_weight').attribute_value.to_f
    enter_weight = Setting.find_by(attribute_name: 'enter_weight').attribute_value.to_f
    favorite_weight = Setting.find_by(attribute_name: 'favorite_weight').attribute_value.to_f
    order("(search_count * #{search_weight}) + (enter_count * #{enter_weight}) + (favorite_count * #{favorite_weight}) DESC").offset(skip).limit(top)
  end
end
