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
    if response.success? && response['items'].any?
      snippet = response['items'][0]['snippet']
    else
      return
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
    return unless uri

    params = URI.decode_www_form(uri.query)
    params.assoc('v')&.last
  end
end