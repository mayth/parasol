describe Admin::SettingsController do
  let(:admin) { create(:admin) }

  describe 'GET index' do
    it 'just does nothing' do
      # write specs...
    end
  end

  describe 'PUT update' do
    context 'with valid params' do
      it 'updates the settings' do
        sign_in admin
        pending
      end
    end

    context 'with invalid params' do
      it 'fails to update the settings' do
        sign_in admin
        pending
      end
    end
  end
end