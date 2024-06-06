class Video < ApplicationRecord
  belongs_to :user
  validates :title, :description, :thumbnail, :url, presence: true
  after_create :send_notification

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

  def send_notification
    NotificationJob.perform_later
  end
end
