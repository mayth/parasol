require 'spec_helper'

describe ChallengesController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: 1
      response.should be_success
    end
  end

  describe "POST 'answer'" do
    it "returns http success" do
      post 'answer', id: 1
      response.should be_success
    end
  end

end
