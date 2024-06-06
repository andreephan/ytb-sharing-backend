class NotificationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    NotificationService.new.send_notification("Someone just shared a video!")
  end
end
