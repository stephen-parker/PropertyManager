require 'rails_helper'

RSpec.describe "Works", :type => :request do
  describe "GET /works" do
    it "works! (now write some real specs)" do
      get works_path
      expect(response.status).to be(200)
    end
  end
end
