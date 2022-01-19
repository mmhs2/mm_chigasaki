class PostTag < ApplicationRecord
  belongs_to :blog
  belongs_to :tag
  validates :post_id, presence: true
  validates :tag_id, presence: true
end
