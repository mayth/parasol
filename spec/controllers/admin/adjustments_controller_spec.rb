require 'rails_helper'

RSpec.describe Admin::AdjustmentsController, type: :controller do
  let(:admin) { create(:admin) }
  before do
    sign_in admin
  end

  describe 'GET index' do
    it 'assigns all adjustments as @adjustments' do
      adjustment = create(:adjustment)
      get :index
      expect(assigns(:adjustments)).to eq [adjustment]
    end
  end

  describe 'GET show' do
    it 'assigns the requested adjustment as @adjustment' do
      adjustment = create(:adjustment)
      get :show, id: adjustment.to_param
      expect(assigns(:adjustment)).to eq adjustment
    end
  end

  describe 'GET new' do
    it 'assigns a new adjustment as @adjustment' do
      get :new
      expect(assigns(:adjustment)).to be_a_new Adjustment
    end
  end

  describe 'GET edit' do
    it 'assigns the requested adjustment as @adjustment' do
      adjustment = create(:adjustment)
      get :edit, id: adjustment.to_param
      expect(assigns(:adjustment)).to eq adjustment
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Adjustment' do
        expect { post :create, adjustment: make_adjustment_param_hash(build(:adjustment)) }
          .to change(Adjustment, :count).by(1)
      end

      it 'assigns a newly created adjustment as @adjustment' do
        post :create, adjustment: make_adjustment_param_hash(build(:adjustment))
        expect(assigns(:adjustment)).to be_a Adjustment
        expect(assigns(:adjustment)).to be_persisted
      end

      it 'redirects to the created adjustment' do
        post :create, adjustment: make_adjustment_param_hash(build(:adjustment))
        expect(response).to redirect_to(admin_adjustment_url(Adjustment.last))
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved adjustment as @adjustment' do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Adjustment).to receive(:save).and_return(false)
        post :create, adjustment: { point: 'abc' }
        expect(assigns(:adjustment)).to be_a_new Adjustment
      end

      it 're-renders the "new" template' do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Adjustment).to receive(:save).and_return(false)
        post :create, adjustment: { point: 'abc' }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      it 'updates the requested adjustment' do
        adjustment = create(:adjustment)
        # Assuming there are no other admin_adjustments in the database, this
        # specifies that the Adjustment created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(Adjustment)
          .to receive(:update).with('point' => '334')
        put :update, id: adjustment.to_param, adjustment: { 'point' => '334' }
      end

      it 'assigns the requested adjustment as @adjustment' do
        adjustment = create(:adjustment)
        put :update, id: adjustment.to_param, adjustment: make_adjustment_param_hash(build(:adjustment))
        expect(assigns(:adjustment)).to eq adjustment
      end

      it 'redirects to the admin/adjustment' do
        adjustment = create(:adjustment)
        put :update, id: adjustment.to_param, adjustment: make_adjustment_param_hash(build(:adjustment))
        expect(response).to redirect_to(admin_adjustment_path(adjustment))
      end
    end

    describe 'with invalid params' do
      it 'assigns the adjustment as @adjustment' do
        adjustment = create(:adjustment)
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Adjustment).to receive(:save).and_return(false)
        put :update, id: adjustment.to_param, adjustment: { 'point' => 'abc' }
        expect(assigns(:adjustment)).to eq adjustment
      end

      it 're-renders the "edit" template' do
        adjustment = create(:adjustment)
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Adjustment).to receive(:save).and_return(false)
        put :update, id: adjustment.to_param, adjustment: { 'point' => 'abc' }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested adjustment' do
      adjustment = create(:adjustment)
      expect { delete :destroy, id: adjustment.to_param }
        .to change(Adjustment, :count).by(-1)
    end

    it 'redirects to the admin/adjustments list' do
      adjustment = create(:adjustment)
      delete :destroy, id: adjustment.to_param
      expect(response).to redirect_to(admin_adjustments_url)
    end
  end

end
