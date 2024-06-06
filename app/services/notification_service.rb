class NotificationService
  def initialize
    @firebase = Firebase::Client.new(ENV['FIREBASE_URL'], ENV['FIREBASE_SECRET'])
  end

  def send_notification(message)
    @firebase.set('notifications', { message: message })
  end
end