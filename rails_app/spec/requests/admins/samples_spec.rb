require 'rails_helper'

RSpec.describe "Admins::Samples", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/admin/sample/index"
      expect(response).to have_http_status(:success)
    end
  end

end
