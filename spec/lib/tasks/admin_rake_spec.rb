require 'rails_helper'

RSpec.describe 'admin:create_user' do
  include_context 'rake'

  it 'prerequisites should include environment' do
    expect(subject.prerequisites).to include 'environment'
  end

  describe 'on running the command' do
    before do
      ENV['EMAIL'] = email
      ENV['PASSWORD'] = password
    end

    context 'with valid params' do
      let(:admin) { attributes_for(:admin) }
      let(:email) { admin[:email] }
      let(:password) { admin[:password] }

      it 'adds an admin user' do
        expect { subject.invoke }.to change(Admin, :count).by(1)
      end
    end

    context 'with invalid params' do
      let(:admin) { attributes_for(:admin) }
      let(:email) { admin[:email] }
      let(:password) { 'shortpw' }

      it 'fails with some errors' do
        expect { subject.invoke }.to raise_error(RuntimeError)
      end
    end
  end
end
