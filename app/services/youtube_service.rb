class YoutubeService
  include HTTParty
  base_uri 'https://www.googleapis.com/youtube/v3'

  def initialize
    @api_key = ENV['YOUTUBE_API_KEY']
  end

  def fetch_video_info(video_id)
    options = { query: { part: 'snippet', id: video_id, key: @api_key } }
    self.class.get('/videos', options)
  end

  def youtube_url?
    url.include?('youtube.com')
  end

  def fetch_youtube_data(youtube_url)
    video_id = extract_youtube_video_id(youtube_url)
    return unless video_id

    response = fetch_video_info(video_id)
    if response.success?
      snippet = response['items'][0]['snippet']
    else
      errors.add(:url, 'Unable to fetch video data from YouTube')
    end
    {
      title: snippet['title'],
      description: snippet['description'],
      thumbnail: snippet['thumbnails']['high']['url'],
      youtube_id: video_id,
      url: youtube_url
    }
  end

  def extract_youtube_video_id(url)
    uri = URI.parse(url)
    if uri.query
      params = URI.decode_www_form(uri.query)
      video_id = params.assoc('v')&.last
    end
    video_id if video_id
  end
end