require 'rails_helper'

RSpec.describe "Api::V1::Sessions", type: :request do
  describe "POST /create" do
    it "returns http success" do
      post "/api/v1/sessions", params: { email: 'test@gmail.com', password: 'password' }
      expect(response).to have_http_status(:success)
    end

    it "returns http unauthorized" do
      post "/api/v1/sessions", params: { email: 'aaaa', password: 'aaaa' }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
