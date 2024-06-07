require 'rails_helper'

RSpec.describe "Api::V1::Videos", type: :request do
  before do
    @user = User.create(email: 'test@gmail.com', password: 'password')
  end

  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/videos"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).length).to eq(Video.count)
    end
  end

  describe "POST /create" do
    it "returns http success" do
      allow_any_instance_of(ApplicationController).to receive(:decode_token).and_return([{ 'user_id' => @user.id, 'expired' => Time.now.to_i + 3600 }])
      post "/api/v1/videos", params: { video: { url: 'https://www.youtube.com/watch?v=UYm0kfnRTJk' }}
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['title']).to eq('Ruby in 100 Seconds')
    end

    it "returns http unprocessable_entity" do
      allow_any_instance_of(ApplicationController).to receive(:decode_token).and_return([{ 'user_id' => @user.id, 'expired' => Time.now.to_i + 3600 }])
      post "/api/v1/videos", params: { video: { url: 'https://www.youtube.com/watch?v=aaaaaaa' }}
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']).to eq('Invalid Youtube URL')
    end

    it "returns http unauthorized" do
      post "/api/v1/videos", params: { video: { url: 'https://www.youtube.com/watch?v=UYm0kfnRTJk' }}
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
