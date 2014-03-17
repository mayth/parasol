class ChallengesController < ApplicationController
  # /challenges
  def index
    @challenges = Challenge.opened
    @genres = @challenges.genres
  end

  # /challenges/:id
  def show
  end

  # /challenges/:id/answer
  def answer
  end
end
