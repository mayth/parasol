require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  let(:player) do
    p = create(:player)
    p.confirm!
    p
  end

  describe 'GET index' do
    it 'returns http success' do
      get :index
      expect(response).to be_success
    end

    it 'assigns all teams as @teams' do
      teams = 3.times.map { create(:team) }
      get :index
      expect(assigns[:teams]).to include(*teams)
    end
  end

  describe 'GET show' do
    it 'assigns the requested team as @team' do
      sign_in player
      team = create(:team)
      get :show, id: team.to_param
      expect(assigns(:team)).to eq team
    end
  end

  describe 'GET new' do
    it 'assigns a new team as @team' do
      get :new
      expect(assigns(:team)).to be_a_new Team
    end
  end

  describe 'GET edit' do
    it 'assigns the requested team as @team' do
      sign_in player
      team = create(:team)
      player.team = team
      get :edit, id: team.to_param
      expect(assigns(:team)).to eq team
    end
  end

  describe 'POST create' do
    describe 'when team registration is opened' do
      before do
        Timecop.freeze
        Setting.team_registrable_from = Time.zone.now.yesterday
        Setting.team_registrable_until = Time.zone.now.tomorrow
      end

      describe 'with valid params' do
        it 'creates a new Team' do
          expect { post :create, team: attributes_for(:team) }
            .to change(Team, :count).by(1)
        end

        it 'assigns a newly created team as @team' do
          post :create, team: attributes_for(:team)
          expect(assigns(:team)).to be_a(Team)
          expect(assigns(:team)).to be_persisted
        end

        it 'redirects to the created team' do
          post :create, team: attributes_for(:team)
          expect(response).to redirect_to Team.last
        end
      end

      describe 'with invalid params' do
        it 'assigns a newly created but unsaved team as @team' do
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(Team).to receive(:save).and_return(false)
          post :create, team: { 'name' => '' }
          expect(assigns(:team)).to be_a_new Team
        end

        it 're-renders the "new" template' do
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(Team).to receive(:save).and_return(false)
          post :create, team: { 'name' => '' }
          expect(response).to render_template('new')
        end
      end
    end

    describe 'when team registration is closed' do
      before do
        Timecop.freeze
        Setting.team_registrable_from = Time.zone.now.days_ago(2)
        Setting.team_registrable_until = Time.zone.now.yesterday
      end

      it 'does not create a new Team' do
        expect { post :create, team: attributes_for(:team) }
          .not_to change(Team, :count)
      end

      it 'redirects to the team index' do
        post :create, team: attributes_for(:team)
        expect(response).to redirect_to teams_path
      end

      it 'does not assign a newly created team as @team' do
        post :create, team: attributes_for(:team)
        expect(assigns(:team)).to be_nil
      end
    end
  end

  describe 'PUT update' do
    context 'if the player signed in' do
      describe 'with valid params with' do
        it 'updates the requested team' do
          sign_in player
          team = create(:team)
          player.team = team
          player.save
          # Assuming there are no other teams in the database, this
          # specifies that the Team created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          expect_any_instance_of(Team).to receive(:update).with('name' => 'specspec')
          put :update, id: team.to_param, team: { 'name' => 'specspec' }
        end

        it 'is authenticated with the new password but it fails with the old password' do
          old_pw = 'old_password'
          new_pw = 'new_password!'

          sign_in player
          team = create(:team, password: old_pw)
          player.team = team
          player.save
          put :update, id: team.to_param, team: attributes_for(:team, password: new_pw)
          expect(assigns(:team).authenticate(old_pw)).to be_falsey
          expect(assigns(:team).authenticate(new_pw)).to be_truthy
        end

        it 'assigns the requested team as @team' do
          sign_in player
          team = create(:team)
          player.team = team
          player.save
          put :update, id: team.to_param, team: attributes_for(:team)
          expect(assigns(:team)).to eq team
        end

        it 'redirects to the team' do
          sign_in player
          team = create(:team)
          player.team = team
          player.save
          put :update, id: team.to_param, team: attributes_for(:team)
          expect(response).to redirect_to team
        end
      end

      context 'with valid params without password' do
        it 'updates the requested team' do
          sign_in player
          team = create(:team)
          player.team = team
          player.save
          # Assuming there are no other teams in the database, this
          # specifies that the Team created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          expect_any_instance_of(Team).to receive(:update).with('name' => 'specspec')
          put :update, id: team.to_param, team: { 'name' => 'specspec' }
        end

        it 'still be authenticated with the existing password' do
          sign_in player
          pw = 'NOCHANGE!'
          team = create(:team, password: pw)
          player.team = team
          player.save
          put :update, id: team.to_param, team: attributes_for(:team, password: '')
          expect(assigns(:team).authenticate(pw)).to be_truthy
        end

        it 'assigns the requested team as @team' do
          sign_in player
          team = create(:team)
          player.team = team
          player.save
          put :update, id: team.to_param, team: attributes_for(:team)
          expect(assigns(:team)).to eq team
        end

        it 'redirects to the team' do
          sign_in player
          team = create(:team)
          player.team = team
          player.save
          put :update, id: team.to_param, team: attributes_for(:team)
          expect(response).to redirect_to team
        end
      end

      describe 'with invalid params' do
        it 'assigns the team as @team' do
          sign_in player
          team = create(:team)
          player.team = team
          player.save
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(Team).to receive(:save).and_return(false)
          put :update, id: team.to_param, team: { 'name' => '' }
          expect(assigns(:team)).to eq team
        end

        it 're-renders the "edit" template' do
          sign_in player
          team = create(:team)
          player.team = team
          player.save
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(Team).to receive(:save).and_return(false)
          put :update, id: team.to_param, team: { 'name' => '' }
          expect(response).to render_template('edit')
        end
      end
    end

    context 'with non-player' do
      it 'assigns the team as @team' do
        team = create(:team)
        allow_any_instance_of(Team).to receive(:save).and_return(false)
        put :update, id: team.to_param, team: { 'name' => '' }
        expect(assigns(:team)).to eq team
      end

      it 'fails with unauthorized' do
        team = create(:team)
        put :update, id: team.to_param, team: { 'name' => 'kogasa' }
        expect(response.status).to eq 401 # HTTP 401 Unauthorized
      end
    end

    context 'if the player signs in but the other team' do
      it 'assigns the team as @team' do
        sign_in player
        team = create(:team)
        allow_any_instance_of(Team).to receive(:save).and_return(false)
        put :update, id: team.to_param, team: { 'name' => '' }
        expect(assigns(:team)).to eq team
      end

      it 'fails with unauthorized' do
        sign_in player
        team = create(:team)
        put :update, id: team.to_param, team: { 'name' => 'kogasa' }
        expect(response.status).to eq 401 # HTTP 401 Unauthorized
      end
    end
  end
end
