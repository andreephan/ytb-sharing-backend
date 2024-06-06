class Api::V1::VideosController < ApplicationController
  before_action :authorize, only: [:create]

  def index
    videos = Video.order(created_at: :desc)
    render json: videos.includes(:user).map(&:json_data), status: :ok
  end

  def create
    video_info = YoutubeService.new.fetch_youtube_data(video_params[:url])
    video = @user.videos.build(video_info)
    if video.save
      NotificationService.new.send_notification('New video added')
      render json: video, status: :created
    else
      render json: { errors: video.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def video_params
    params.require(:video).permit(:url)
  end
end
