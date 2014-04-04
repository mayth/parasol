require 'spec_helper'

describe TeamsController do
  let(:player) do
    p = create(:player)
    p.confirm!
    p
  end

  describe 'GET index' do
    it 'assigns all teams as @teams' do
      team = create(:team)
      get :index
      expect(assigns(:teams)).to eq [team]
    end
  end

  describe 'GET show' do
    context 'when the player signed in' do
      it 'assigns the requested team as @team' do
        sign_in player
        team = create(:team)
        get :show, id: team.to_param
        expect(assigns(:team)).to eq team
      end
    end

    context 'when non-player' do
      it 'redirects to the sign-in page' do
        team = create(:team)
        get :show, id: team.to_param
        expect(response).to redirect_to new_player_session_path
      end
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
        Team.any_instance.stub(:save).and_return(false)
        post :create, team: { 'name' => '' }
        expect(assigns(:team)).to be_a_new Team
      end

      it 're-renders the "new" template' do
        # Trigger the behavior that occurs when invalid params are submitted
        Team.any_instance.stub(:save).and_return(false)
        post :create, team: { 'name' => '' }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    context 'if the player signed in' do
      describe 'with valid params' do
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
          Team.any_instance.stub(:save).and_return(false)
          put :update, id: team.to_param, team: { 'name' => '' }
          expect(assigns(:team)).to eq team
        end

        it 're-renders the "edit" template' do
          sign_in player
          team = create(:team)
          player.team = team
          player.save
          # Trigger the behavior that occurs when invalid params are submitted
          Team.any_instance.stub(:save).and_return(false)
          put :update, id: team.to_param, team: { 'name' => '' }
          expect(response).to render_template('edit')
        end
      end
    end

    context 'with non-player' do
      it 'assigns the team as @team' do
        team = create(:team)
        Team.any_instance.stub(:save).and_return(false)
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
        Team.any_instance.stub(:save).and_return(false)
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

  describe 'DELETE destroy' do
    context 'if the player belongs to the requested team' do
      it 'destroys the requested team' do
        sign_in player
        team = create(:team)
        player.team = team
        player.save
        expect { delete :destroy, id: team.to_param }
          .to change(Team, :count).by(-1)
      end

      it 'redirects to the teams list' do
        sign_in player
        team = create(:team)
        player.team = team
        player.save
        delete :destroy, id: team.to_param
        expect(response).to redirect_to teams_url
      end
    end

    context 'if the player does not belongs to the requested team' do
      it 'does not destroy the team' do
        sign_in player
        team = create(:team)
        expect { delete :destroy, id: team.to_param }
          .not_to change(Team, :count)
      end

      it 'fails with unauthorized' do
        sign_in player
        team = create(:team)
        delete :destroy, id: team.to_param
        expect(response.status).to eq 401
      end
    end

    context 'if the player is not signed in' do
      it 'does not destroy the team' do
        team = create(:team)
        expect { delete :destroy, id: team.to_param }
          .not_to change(Team, :count)
      end

      it 'fails with unauthorized' do
        team = create(:team)
        delete :destroy, id: team.to_param
        expect(response.status).to eq 401
      end
    end
  end

end
