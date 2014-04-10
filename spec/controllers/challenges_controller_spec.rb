require 'spec_helper'

describe ChallengesController do
  let(:player) do
    p = create(:player)
    p.confirm!
    p
  end

  let(:challenge) { create(:challenge) }

  describe "GET 'index'" do
    context 'with the player logged in' do
      before do
        sign_in player
      end

      it 'returns http success' do
        get :index
        expect(response).to be_success
      end

      it 'assigns all opened challenges as @challenges' do
        opened_challenges = 3.times.map do
          c = create(:challenge)
          c.open!
          c
        end
        # closed challenges
        closed_challenge = create(:challenge)
        future_challenge = create(:challenge, opened_at: Time.zone.now.tomorrow)
        get :index
        expect(assigns[:challenges]).to include(*opened_challenges)
        expect(assigns[:challenges]).not_to include(closed_challenge)
        expect(assigns[:challenges]).not_to include(future_challenge)
      end
    end

    context 'without the player logged in' do
      before do
        sign_out player
      end
      it 'redirects to the sign in page' do
        get :index
        expect(response).to redirect_to(new_player_session_path)
      end
    end
  end

  describe "GET 'show'" do
    context 'with the player logged in' do
      before do
        sign_in player
      end

      context 'with the opened challenge' do
        before do
          challenge.open!
        end

        it 'returns http success' do
          get :show, id: challenge.id
          expect(response).to be_success
        end

        it 'assigns the requested challenge as @challenge' do
          get :show, id: challenge.id
          expect(assigns[:challenge]).to eq challenge
        end
      end

      context 'with the closed challenge' do
        before do
          challenge.close!
        end

        it 'fails with record not found' do
          expect { get :show, id: challenge.id }
            .to raise_error ActiveRecord::RecordNotFound
        end
      end
    end

    context 'with the player not logged in' do
      before do
        sign_out player
      end

      it 'redirects to the sign in page' do
        get :show, id: challenge.id
        expect(response).to redirect_to(new_player_session_path)
      end
    end
  end

  describe "POST 'answer'" do
    context 'with the player logged in' do
      before do
        sign_in player
      end

      context 'for the opened challenge' do
        before do
          challenge.open!
        end

        context 'with valid parameter' do
          it 'redirects to the requested challenge page' do
            post 'answer', id: challenge.id, answer: { answer: 'FLAG_SPEC' }
            expect(response).to redirect_to challenge_path(challenge)
          end
        end
      end

      context 'for the closed challenge' do
        before do
          challenge.close!
        end

        it 'fails with record not found' do
          expect { post :answer,
                        id: challenge.id,
                        answer: { answer: 'FLAG_SPEC' }
          }.to raise_error ActiveRecord::RecordNotFound
        end
      end

      context 'when the contest is closed' do
        before do
          Timecop.freeze
          Setting.contest_starts_at = Time.zone.now.days_ago(2)
          Setting.contest_ends_at = Time.zone.now.yesterday
          challenge.open!
        end

        it 'redirects to the challenges page' do
          post :answer, id: challenge.id, answer: { answer: 'FLAG_SPEC' }
          expect(response).to redirect_to challenge_path(challenge)
        end
      end
    end

    context 'with the player not logged in' do
      before do
        sign_out player
      end

      it 'redirects to the sign in page' do
        post :answer, id: challenge.id, answer: { answer: 'FLAG_SPEC' }
        expect(response).to redirect_to(new_player_session_path)
      end
    end
  end

end
