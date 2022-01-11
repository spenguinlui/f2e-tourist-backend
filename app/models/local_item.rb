class LocalItem < ApplicationRecord
  has_many :comments

  scope :has_comment, -> { joins(:comments).where("comments.local_item_id IS NOT NULL").references(:comments) }

  def average_score
    if self.comments.length > 0
      self.comments.reduce(0) {|start, comment| start + comment.score } / self.comments.length
    else
      3.5
    end
  end
end
