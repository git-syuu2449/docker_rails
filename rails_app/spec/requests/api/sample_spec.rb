require 'rails_helper'

RSpec.describe "Api::Samples", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/sample/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/api/sample/create"
      expect(response).to have_http_status(:success)
    end
  end

end
