require 'spec_helper'

describe HomeController, :type => :controller do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end
  end

  describe "GET 'ranking'" do
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
end
