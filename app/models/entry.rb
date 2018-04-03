class Entry < ApplicationRecord
  has_many :comments, :dependent => :delete_all
  validates_presence_of :title, :body
end
