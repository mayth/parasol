class ChallengesController < ApplicationController
  before_action :authenticate_player!
  before_action :set_challenge, only: [:show, :answer]

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
    unless can_submit?
      respond_to do |format|
        format.html { redirect_to @challenge, alert: 'Contest Closed!' }
        format.json { { result: 'closed' } }
      end
      return
    end

    answer = current_player.submit(@challenge, answer_params[:answer])
    respond_to do |format|
      if answer
        if answer.valid_answer?
          format.html do
            redirect_to challenge_path(@challenge),
                        notice: 'Your flag is correct!'
          end
          format.json { render json: { result: 'correct' } }
        elsif answer.answered?
          format.html do
            redirect_to challenge_path(@challenge),
                        notice: 'Flag is correct, but you already answered.'
          end
          format.json { render json: { result: 'answered' } }
        else
          format.html do
            redirect_to challenge_path(@challenge),
                        notice: 'Wrong answer...'
          end
          format.json { render json: { result: 'wrong' } }
        end
      else
        format.html do
          redirect_to challenge_path(@challenge),
                      alert: 'Something went wrong...'
        end
        format.json { render json: { result: 'error' } }
      end
    end
  end

  private
    def set_challenge
      @challenge = Challenge.find(params[:id])
      fail ActiveRecord::RecordNotFound unless @challenge.opened?
    end

    def answer_params
      params.require(:answer).permit(:answer)
    end

    def can_submit?
      ApplicationController.helpers.within_contest_period?
    end
end
