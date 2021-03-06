require 'rails_helper'

RSpec.describe Admin::ChallengesController, type: :controller do
  let(:admin) { create(:admin) }

  describe "GET index" do
    it "assigns all challenges as @challenges" do
      sign_in admin
      challenge = create(:challenge)
      get :index
      expect(assigns(:challenges)).to eq [challenge]
    end
  end

  describe "GET show" do
    it "assigns the requested challenge as @challenge" do
      sign_in admin
      challenge = create(:challenge)
      get :show, {id: challenge.to_param}
      expect(assigns(:challenge)).to eq challenge
    end
  end

  describe "GET new" do
    it "assigns a new challenge as @challenge" do
      sign_in admin
      get :new
      expect(assigns(:challenge)).to be_a_new(Challenge)
    end
  end

  describe "GET edit" do
    it "assigns the requested challenge as @challenge" do
      sign_in admin
      challenge = create(:challenge)
      get :edit, {:id => challenge.to_param}
      expect(assigns(:challenge)).to eq challenge
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Challenge" do
        sign_in admin
        param = make_challenge_param_hash(build(:challenge))
        flag = build(:flag)
        param[:flags_attributes] = [flag.attributes]
        expect {
          post :create, {challenge: param}
        }.to change(Challenge, :count).by(1)
      end

      it "assigns a newly created challenge as @challenge" do
        sign_in admin
        param = make_challenge_param_hash(build(:challenge))
        flag = build(:flag)
        param[:flags_attributes] = [flag.attributes]
        post :create, {challenge: param}
        expect(assigns(:challenge)).to be_a(Challenge)
        expect(assigns(:challenge)).to be_persisted
      end

      it "redirects to the created challenge" do
        sign_in admin
        param = make_challenge_param_hash(build(:challenge))
        flag = build(:flag)
        param[:flags_attributes] = [flag.attributes]
        post :create, {challenge: param}
        expect(response).to redirect_to admin_challenge_path(Challenge.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved challenge as @challenge" do
        # Trigger the behavior that occurs when invalid params are submitted
        sign_in admin
        allow_any_instance_of(Challenge).to receive(:save).and_return(false)
        post :create, {challenge: make_challenge_param_hash(build(:challenge, name: nil))}
        expect(assigns(:challenge)).to be_a_new(Challenge)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        sign_in admin
        allow_any_instance_of(Challenge).to receive(:save).and_return(false)
        post :create, {challenge: make_challenge_param_hash(build(:challenge, name: nil))}
        expect(response).to render_template('new')
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested challenge" do
        sign_in admin
        challenge = create(:challenge)
        # Assuming there are no other challenges in the database, this
        # specifies that the Challenge created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(Challenge).to receive(:update).with(name: 'kogasa')
        put :update, {id: challenge.to_param, challenge: {name: 'kogasa'}}
      end

      it "assigns the requested challenge as @challenge" do
        sign_in admin
        challenge = create(:challenge)
        param = make_challenge_param_hash(challenge)
        put :update, {id: challenge.id, challenge: param}
        expect(assigns(:challenge)).to eq challenge
      end

      it "redirects to the challenge" do
        sign_in admin
        challenge = create(:challenge)
        put :update, {:id => challenge.to_param, :challenge => make_challenge_param_hash(challenge)}
        expect(response).to redirect_to(admin_challenge_url(challenge))
      end
    end

    describe "with invalid params" do
      it "assigns the challenge as @challenge" do
        sign_in admin
        challenge = create(:challenge)
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Challenge).to receive(:save).and_return(false)
        put :update, {:id => challenge.to_param, :challenge => make_challenge_param_hash(build(:challenge, name: nil))}
        expect(assigns(:challenge)).to eq challenge
      end

      it "re-renders the 'edit' template" do
        sign_in admin
        challenge = create(:challenge)
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Challenge).to receive(:save).and_return(false)
        put :update, {:id => challenge.to_param, :challenge => make_challenge_param_hash(build(:challenge, name: nil))}
        expect(response).to render_template('edit')
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested challenge" do
      sign_in admin
      challenge = create(:challenge)
      expect {
        delete :destroy, {:id => challenge.to_param}
      }.to change(Challenge, :count).by(-1)
    end

    it "redirects to the challenges list" do
      sign_in admin
      challenge = create(:challenge)
      delete :destroy, {:id => challenge.to_param}
      expect(response).to redirect_to(admin_challenges_url)
    end
  end

end
