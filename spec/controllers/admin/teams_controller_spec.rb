require 'rails_helper'

RSpec.describe Admin::TeamsController, type: :controller do
  let(:admin) { create(:admin) }

  describe "GET index" do
    it "assigns all teams as @teams" do
      sign_in admin
      team = create(:team)
      get :index
      expect(assigns(:teams)).to eq [team]
    end
  end

  describe "GET show" do
    it "assigns the requested team as @team" do
      sign_in admin
      team = create(:team)
      get :show, {id: team.to_param}
      expect(assigns(:team)).to eq team
    end
  end

  describe "GET new" do
    it "assigns a new team as @team" do
      sign_in admin
      get :new
      expect(assigns(:team)).to be_a_new(Team)
    end
  end

  describe "GET edit" do
    it "assigns the requested team as @team" do
      sign_in admin
      team = create(:team)
      get :edit, {id: team.to_param}
      expect(assigns(:team)).to eq team
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Team" do
        sign_in admin
        pw = 'teampw'
        expect {
          post :create, team: attributes_for(:team)
        }.to change(Team, :count).by(1)
      end

      it "assigns a newly created team as @team" do
        sign_in admin
        pw = 'teampw'
        post :create, team: attributes_for(:team)
        expect(assigns(:team)).to be_a(Team)
        expect(assigns(:team)).to be_persisted
      end

      it "redirects to the created team" do
        sign_in admin
        pw = 'teampw'
        post :create, team: attributes_for(:team)
        expect(response).to redirect_to admin_team_path(Team.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved team as @team" do
        sign_in admin
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Team).to receive(:save).and_return(false)
        post :create, team: attributes_for(:team, name: '')
        expect(assigns(:team)).to be_a_new(Team)
      end

      it "re-renders the 'new' template" do
        sign_in admin
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Team).to receive(:save).and_return(false)
        post :create, team: attributes_for(:team, name: '')
        expect(response).to render_template('new')
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested team" do
        sign_in admin
        team = create(:team)
        # Assuming there are no other teams in the database, this
        # specifies that the Team created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(Team).to receive(:update).with({'name' => 'updated!'})
        put :update, {id: team.to_param, team: {'name' => 'updated!'}}
      end

      it "assigns the requested team as @team" do
        sign_in admin
        team = create(:team)
        put :update, id: team.to_param, team: make_valid_team_param_hash(team)
        expect(assigns(:team)).to eq team
      end

      it "redirects to the team" do
        sign_in admin
        team = create(:team)
        put :update, id: team.to_param, team: make_valid_team_param_hash(team)
        expect(response).to redirect_to admin_team_path(team)
      end
    end

    describe "with invalid params" do
      it "assigns the team as @team" do
        sign_in admin
        team = create(:team)
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Team).to receive(:save).and_return(false)
        put :update, id: team.to_param, team: make_invalid_team_param_hash(team)
        expect(assigns(:team)).to eq team
      end

      it "re-renders the 'edit' template" do
        sign_in admin
        team = create(:team)
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Team).to receive(:save).and_return(false)
        put :update, id: team.to_param, team: make_invalid_team_param_hash(team)
        expect(response).to render_template('edit')
      end
    end
  end

  describe "DELETE destroy" do
    context 'for the team which has no members' do
      it "destroys the requested team" do
        sign_in admin
        team = create(:team)
        expect {
          delete :destroy, {id: team.to_param}
        }.to change(Team, :count).by(-1)
      end

      it "redirects to the teams list" do
        sign_in admin
        team = create(:team)
        delete :destroy, {id: team.to_param}
        expect(response).to redirect_to admin_teams_path
      end
    end

    context 'for the team which has some members' do
      it 'does not destroy the requested team' do
        sign_in admin
        team = create(:team)
        player = create(:player)
        player.confirm
        team.players << player
        request.env['HTTP_REFERER'] = admin_team_path(team)
        expect { delete :destroy, id: team.to_param }
          .not_to change(Team, :count)
      end

      it 'redirects to the requested team' do
        sign_in admin
        team = create(:team)
        player = create(:player)
        player.confirm
        team.players << player
        request.env['HTTP_REFERER'] = admin_team_path(team)
        delete :destroy, id: team.to_param
        expect(response).to redirect_to(admin_team_path(team))
      end
    end
  end

end
