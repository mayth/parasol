require 'spec_helper'

describe ChallengesController do
  let(:player) do
    p = create(:player)
    p.confirm!
    p
  end

  before do
    @challenge = create(:challenge)
  end

  describe "GET 'index'" do
    it 'returns http success' do
      sign_in player
      get 'index'
      expect(response).to be_success
    end
  end

  describe "GET 'show'" do
    it 'returns http success' do
      sign_in player
      get 'show', id: @challenge.id
      expect(response).to be_success
    end
  end

  describe "POST 'answer'" do
    context 'with valid parameter' do
      it 'returns http success' do
        sign_in player
        post 'answer', id: @challenge.id, answer: { answer: 'FLAG_SPEC' }
        expect(response).to redirect_to challenge_path(@challenge)
      end
    end
  end

end
