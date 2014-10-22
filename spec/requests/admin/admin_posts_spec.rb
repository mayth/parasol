require 'rails_helper'

RSpec.describe 'Admin::Posts', type: :request do
  describe 'GET /admin/posts' do
    it 'works! (now write some real specs)' do
      sign_in_as_a_valid_admin
      get admin_posts_path
      expect(response.status).to eq 200
    end
  end
end
