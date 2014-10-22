require 'rails_helper'

RSpec.describe Admin::PlayersController, type: :controller do
  let(:admin) { create(:admin) }

  describe "GET index" do
    it "assigns all players as @players" do
      sign_in admin
      player = create(:player)
      player.confirm!
      get :index
      expect(assigns(:players)).to eq [player]
    end
  end

  describe "GET show" do
    it "assigns the requested player as @player" do
      sign_in admin
      player = create(:player)
      player.confirm!
      get :show, {id: player.to_param}
      expect(assigns(:player)).to eq player
    end
  end

  describe "GET new" do
    it "assigns a new player as @player" do
      sign_in admin
      get :new
      expect(assigns(:player)).to be_a_new(Player)
    end
  end

  describe "GET edit" do
    it "assigns the requested player as @player" do
      sign_in admin
      player = create(:player)
      player.confirm!
      get :edit, {id: player.to_param}
      expect(assigns(:player)).to eq player
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Player" do
        sign_in admin
        expect {
          post :create, {player: make_valid_player_param_hash(build(:player))}
        }.to change(Player, :count).by(1)
      end

      it "assigns a newly created player as @player" do
        sign_in admin
        post :create, {player: make_valid_player_param_hash(build(:player))}
        expect(assigns(:player)).to be_a(Player)
        expect(assigns(:player)).to be_persisted
      end

      it "redirects to the created player" do
        sign_in admin
        post :create, {player: make_valid_player_param_hash(build(:player))}
        expect(response).to redirect_to admin_player_path(Player.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved player as @player" do
        sign_in admin
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Player).to receive(:save).and_return(false)
        post :create, {player: make_invalid_player_param_hash(build(:player))}
        expect(assigns(:player)).to be_a_new(Player)
      end

      it "re-renders the 'new' template" do
        sign_in admin
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Player).to receive(:save).and_return(false)
        post :create, {player: make_invalid_player_param_hash(build(:player))}
        expect(response).to render_template('new')
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested player" do
        sign_in admin
        player = create(:player)
        player.confirm!
        # Assuming there are no other players in the database, this
        # specifies that the Player created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(Player).to receive(:update).with({'these' => 'params'})
        put :update, {id: player.to_param, player: {'these' => 'params'}}
      end

      it "assigns the requested player as @player" do
        sign_in admin
        player = create(:player)
        player.confirm!
        put :update, {id: player.to_param, player: make_valid_player_param_hash(build(:player))}
        expect(assigns(:player)).to eq player
      end

      it "redirects to the player" do
        sign_in admin
        player = create(:player)
        player.confirm!
        put :update, {id: player.to_param, player: make_valid_player_param_hash(build(:player))}
        expect(response).to redirect_to admin_player_path(player)
      end
    end

    describe "with invalid params" do
      it "assigns the player as @player" do
        sign_in admin
        player = create(:player)
        player.confirm!
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Player).to receive(:save).and_return(false)
        put :update, {id: player.to_param, player: make_invalid_player_param_hash(player)}
        expect(assigns(:player)).to eq player
      end

      it "re-renders the 'edit' template" do
        sign_in admin
        player = create(:player)
        player.confirm!
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Player).to receive(:save).and_return(false)
        put :update, {id: player.to_param, player: make_invalid_player_param_hash(player)}
        expect(response).to render_template('edit')
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested player" do
      sign_in admin
      player = create(:player)
      player.confirm!
      expect {
        delete :destroy, {id: player.to_param}
      }.to change(Player, :count).by(-1)
    end

    it "redirects to the players list" do
      sign_in admin
      player = create(:player)
      player.confirm!
      delete :destroy, {id: player.to_param}
      expect(response).to redirect_to admin_players_path
    end
  end

end
