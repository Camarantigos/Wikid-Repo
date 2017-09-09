class Article < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 3, maximum: 75}
  validates :description, presence: true, length: { minimum: 10, maximum: 1900}
end