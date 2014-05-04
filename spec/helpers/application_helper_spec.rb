require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ChallengesHelper. For example:
#
# describe ChallengesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe ApplicationHelper do
  describe 'within_team_registration_period?' do
    subject { helper.within_team_registration_period? }
    describe 'without parameter' do
      context 'if team registration is not started yet' do
        before do
          Timecop.freeze
          Setting.team_registrable_from = Time.zone.now.tomorrow
          Setting.team_registrable_until = Time.zone.now.days_since(2)
        end

        it 'returns false' do
          expect(subject).to be_false
        end
      end

      context 'if team registration can be done' do
        before do
          Timecop.freeze
          Setting.team_registrable_from = Time.zone.now.yesterday
          Setting.team_registrable_until = Time.zone.now.tomorrow
        end

        it 'returns true' do
          expect(subject).to be_true
        end
      end

      context 'if team registration is already finished' do
        before do
          Timecop.freeze
          Setting.team_registrable_from = Time.zone.now.days_ago(2)
          Setting.team_registrable_until = Time.zone.now.yesterday
        end

        it 'returns false' do
          expect(subject).to be_false
        end
      end
    end
  end

  describe 'within_contest_period?' do
    describe 'without parameter' do
      subject { helper.within_contest_period? }
      context 'if the contest is not started yet' do
        before do
          Timecop.freeze
          Setting.contest_starts_at = Time.zone.now.tomorrow
          Setting.contest_ends_at = Time.zone.now.days_since(2)
        end

        it 'returns false' do
          expect(subject).to be_false
        end
      end

      context 'if the contest is running' do
        before do
          Timecop.freeze
          Setting.contest_starts_at = Time.zone.now.yesterday
          Setting.contest_ends_at = Time.zone.now.tomorrow
        end

        it 'returns true' do
          expect(subject).to be_true
        end
      end

      context 'if the contest is already finished' do
        before do
          Timecop.freeze
          Setting.contest_starts_at = Time.zone.now.days_ago(2)
          Setting.contest_ends_at = Time.zone.now.yesterday
        end

        it 'returns false' do
          expect(subject).to be_false
        end
      end
    end
  end

  describe 'markdown_render' do
    context 'with nil' do
      subject { helper.markdown_render(nil) }
      it 'fails' do
        expect { subject }.to raise_error
      end
    end

    context 'with String' do
      subject { helper.markdown_render("kogasa-chan\n\n* very cute!") }
      it 'contains given text' do
        expect(subject).to include 'kogasa-chan'
        expect(subject).to include 'very cute'
      end
    end

    context 'with something else' do
      subject { helper.markdown_render([1, 2, 3]) }
      it 'fails' do
        expect { subject }.to raise_error
      end
    end
  end

  describe 'first_break_point_setting' do
    subject { helper.first_break_point_setting }
    context 'if the setting is nil' do
      before do
        Setting[:first_break_points] = nil
      end

      it 'returns empty array' do
        expect(subject).to be_empty
      end
    end

    context 'if the setting is a numeric value' do
      before do
        Setting[:first_break_points] = 0.3
      end

      it 'returns an array which has 1 element' do
        expect(subject).to have(1).item
      end

      it 'returns an array that consists of the setting value' do
        expect(subject).to eq [0.3]
      end
    end

    context 'if the setting is an array' do
      before do
        Setting[:first_break_points] = [0.3, 0.2, 0.1]
      end

      it 'returns that array' do
        expect(subject).to eq [0.3, 0.2, 0.1]
      end
    end

    context 'if the setting is a string' do
      describe 'which wrote with Array format' do
        before do
          Setting[:first_break_points] = '[0.3, 0.2, 0.1]'
        end

        it 'returns an array whose meaning is the same as the setting value' do
          expect(subject).to eq [0.3, 0.2, 0.1]
        end
      end

      describe 'which wrote with Array format without "[]"' do
        before do
          Setting[:first_break_points] = '0.3, 0.2, 0.1'
        end

        it 'returns an array whose meaning is the same as the setting value' do
          expect(subject).to eq [0.3, 0.2, 0.1]
        end
      end
    end
  end
end
