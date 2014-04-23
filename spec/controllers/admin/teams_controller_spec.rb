require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe Admin::TeamsController do
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
        Team.any_instance.stub(:save).and_return(false)
        post :create, team: attributes_for(:team, name: '')
        expect(assigns(:team)).to be_a_new(Team)
      end

      it "re-renders the 'new' template" do
        sign_in admin
        # Trigger the behavior that occurs when invalid params are submitted
        Team.any_instance.stub(:save).and_return(false)
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
        Team.any_instance.stub(:save).and_return(false)
        put :update, id: team.to_param, team: make_invalid_team_param_hash(team)
        expect(assigns(:team)).to eq team
      end

      it "re-renders the 'edit' template" do
        sign_in admin
        team = create(:team)
        # Trigger the behavior that occurs when invalid params are submitted
        Team.any_instance.stub(:save).and_return(false)
        put :update, id: team.to_param, team: make_invalid_team_param_hash(team)
        expect(response).to render_template('edit')
      end
    end
  end

  describe "DELETE destroy" do
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

end
