class TagRelationship < ApplicationRecord
  belongs_to :blog
  belongs_to :tag
end
