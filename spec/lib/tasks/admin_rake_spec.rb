require 'spec_helper'

RSpec.describe 'admin:create_user' do
  include_context 'rake'

  it 'prerequisites should include environment' do
    expect(subject.prerequisites).to include 'environment'
  end
end