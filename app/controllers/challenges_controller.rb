class ChallengesController < ApplicationController
  before_action :set_challenge, only: [:show, :answer]
  before_action :authenticate_player!

  # /challenges
  def index
    @challenges = Challenge.opened
    @genres = @challenges.genres
  end

  # /challenges/:id
  def show
    @answer = Answer.new
  end

  # /challenges/:id
  def answer
    param = answer_params
    param.merge!({challenge_id: @challenge.id, player_id: current_player.id})
    @answer = Answer.new(param)
    respond_to do |format|
      if @answer.save
        if @answer.correct?
          format.html { redirect_to challenge_path(@challenge), notice: 'Your flag is correct!' }
          format.json { {result: 'correct'} }
        else
          format.html { redirect_to challenge_path(@challenge), notice: 'Wrong answer...' }
          format.json { {result: 'wrong'} }
        end
      else
        format.html { redirect_to challenge_path(@challenge), alert: 'Something went wrong...' }
        format.json { {result: 'error'} }
      end
    end
  end

  private
    def set_challenge
      @challenge = Challenge.find(params[:id])
    end

    def answer_params
      params.require(:answer).permit(:answer)
    end
end
