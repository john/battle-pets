require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe "GET #index" do
    it "works if not logged in" do
      get :index
      expect(response).to have_http_status(200)
    end
  end

end

