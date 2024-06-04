class Video < ApplicationRecord
  belongs_to :user
  validates :title, :description, :thumbnail, :url, presence: true

  def json_data
    {
      title: title,
      description: description,
      thumbnail: thumbnail,
      url: url,
      youtube_id: youtube_id,
      user: user.email
    }
  end
end
