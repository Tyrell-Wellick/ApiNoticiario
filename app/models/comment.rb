class Comment < ApplicationRecord
  belongs_to :entry
  validates_presence_of :author, :comment
end
