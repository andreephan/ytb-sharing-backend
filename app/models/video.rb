class Video < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :url, presence: true, format: { with: URI.regexp }
end
