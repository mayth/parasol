require 'spec_helper'

describe 'teams/new' do
  before(:each) do
    assign(:team, build(:team))
  end

  context 'when team registration is opened' do
    before do
      Timecop.freeze
      Setting.team_registrable_from = Time.zone.now.yesterday
      Setting.team_registrable_until = Time.zone.now.tomorrow
    end

    it 'renders new team form' do
      render

      assert_select 'form[action=?][method=?]', teams_path, 'post' do
      end
    end
  end

  context 'when team registration is closed' do
    before do
      Timecop.freeze
      Setting.team_registrable_from = Time.zone.now.days_ago(2)
      Setting.team_registrable_until = Time.zone.now.yesterday
    end

    it 'renders closed message' do
      render
      expect(rendered).to match 'closed'
    end
  end
end
