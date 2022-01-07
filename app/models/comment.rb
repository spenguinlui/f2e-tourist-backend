class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :local_item
end
