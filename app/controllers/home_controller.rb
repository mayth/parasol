class HomeController < ApplicationController
  def index
    @challenges = Challenge.opened
  end
end
