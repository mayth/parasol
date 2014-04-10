require 'spec_helper'

describe TeamsController do
  let(:player) do
    p = create(:player)
    p.confirm!
    p
  end

  describe 'GET index' do
    context 'with teams that has no points nor submissions' do
      it 'assigns all teams as @teams in acending order of team registration date' do
        teams = 3.times.map { create(:team) }
        get :index
        3.times.each do |i|
          expect(assigns(:teams)[i]).to eq teams[i]
        end
      end
    end

    context 'with some teams and their point differ each other' do
      it 'assigns all teams as @teams in descending order of the team point' do
        challenge = create(
          :challenge,
          flags: 5.times.map { |n| create(:flag) })
        teams = 5.times.map do |i|
          team = create(:team)
          player = create(:player, team: team)
          i.times.each do |n|
            player.submit(challenge, challenge.flags[n].flag)
          end
          team
        end
        teams.reverse!
        get :index
        (0..4).each do |i|
          expect(assigns[:teams][i]).to eq teams[i]
        end
      end
    end

    context 'with some teams that has the same point' do
      it 'assigns all teams as @teams in ascending order of last submission date' do
        challenge = create(
          :challenge,
          flags: 5.times.map { |n| create(:flag) })
        teams = 5.times.map do
          team = create(:team)
          player = create(:player, team: team)
          player.submit(challenge, challenge.flags.first.flag)
          team
        end
        get :index
        (0..4).each do |i|
          expect(assigns[:teams][i]).to eq teams[i]
        end
      end
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
          expect(assigns(:team).authenticate(old_pw)).to be_false
          expect(assigns(:team).authenticate(new_pw)).to be_true
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
          expect(assigns(:team).authenticate(pw)).to be_true
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
