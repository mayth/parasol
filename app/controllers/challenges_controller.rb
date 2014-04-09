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
    answer = current_player.submit(@challenge, answer_params[:answer])
    respond_to do |format|
      if answer
        if answer.valid_answer?
          format.html do
            redirect_to challenge_path(@challenge),
                        notice: 'Your flag is correct!'
          end
          format.json { { result: 'correct' } }
        elsif answer.answered?
          format.html do
            redirect_to challenge_path(@challenge),
                        notice: 'Flag is correct, but you already answered.'
          end
          format.json { { result: 'answered' } }
        else
          format.html do
            redirect_to challenge_path(@challenge),
                        notice: 'Wrong answer...'
          end
          format.json { { result: 'wrong' } }
        end
      else
        format.html do
          redirect_to challenge_path(@challenge),
                      alert: 'Something went wrong...'
        end
        format.json { { result: 'error' } }
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
