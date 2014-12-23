require 'rails_helper'

RSpec.describe Admin::AccountsController, :type => :controller do
  let(:invalid_attributes) { attributes_for(:admin).merge(email: '') }
  let(:admin) { create(:admin) }

  before do
    sign_in admin
  end

  describe "GET index" do
    it 'assigns all admin accounts as @accounts' do
      get :index
      expect(assigns(:accounts)).to eq([admin])
    end
  end

  describe "GET show" do
    it "assigns the requested admin account as @account" do
      get :show, id: admin.to_param
      expect(assigns(:account)).to eq(admin)
    end
  end

  describe "GET new" do
    it "assigns a new admin account as @account" do
      get :new
      expect(assigns(:account)).to be_a_new(Admin)
    end
  end

  describe "GET edit" do
    it "assigns the requested admin account as @account" do
      get :edit, id: admin.to_param
      expect(assigns(:account)).to eq(admin)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Admin" do
        expect {
          post :create, admin: attributes_for(:admin)
        }.to change(Admin, :count).by(1)
      end

      it "assigns a newly created admin account as @account" do
        post :create, admin: attributes_for(:admin)
        expect(assigns(:account)).to be_a(Admin)
        expect(assigns(:account)).to be_persisted
      end

      it "redirects to the created admin account" do
        post :create, admin: attributes_for(:admin)
        expect(response).to redirect_to(admin_account_url(Admin.last))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved admin account as @account" do
        post :create, admin: invalid_attributes
        expect(assigns(:account)).to be_a_new(Admin)
      end

      it "re-renders the 'new' template" do
        post :create, admin: invalid_attributes
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params which don't include password" do
      let(:old_password) { attributes_for(:admin)['password'] }
      let(:new_attributes) {
        attributes_for(:admin).merge(email: 'new_address@example.com', password: '')
      }

      it "updates the requested admin account" do
        put :update, id: admin.to_param, admin: new_attributes
        admin.reload
        expect(assigns(:account).email).to eq(new_attributes[:email])
      end

      it "assigns the requested admin account as @account" do
        put :update, id: admin.to_param, admin: new_attributes
        expect(assigns(:account)).to eq(admin)
      end

      it "redirects to the admin account" do
        put :update, id: admin.to_param, admin: new_attributes
        expect(response).to redirect_to(admin_account_url(admin))
      end

      it 'does not update the password' do
        put :update, id: admin.to_param, admin: new_attributes
        expect(assigns(:account).password).to eq old_password
      end
    end

    describe "with valid params which include password" do
      let (:new_attributes) {
        attributes_for(:admin).merge(email: 'new_address@example.com', password: 'newpassword')
      }

      it "updates the requested admin account" do
        put :update, id: admin.to_param, admin: new_attributes
        admin.reload
        expect(assigns(:account).email).to eq(new_attributes[:email])
        expect(assigns(:account).password).to eq(new_attributes[:password])
      end

      it "assigns the requested admin account as @account" do
        put :update, id: admin.to_param, admin: attributes_for(:admin)
        expect(assigns(:account)).to eq(admin)
      end

      it "redirects to the admin account" do
        put :update, id: admin.to_param, admin: attributes_for(:admin)
        expect(response).to redirect_to(admin_account_url(admin))
      end
    end

    describe "with invalid params" do
      it "assigns the admin account as @account" do
        put :update, id: admin.to_param, admin: invalid_attributes
        expect(assigns(:account)).to eq(admin)
      end

      it "re-renders the 'edit' template" do
        put :update, id: admin.to_param, admin: invalid_attributes
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested admin account" do
      expect {
        delete :destroy, id: admin.to_param
      }.to change(Admin, :count).by(-1)
    end

    it "redirects to the admin accounts list" do
      delete :destroy, id: admin.to_param
      expect(response).to redirect_to(admin_accounts_url)
    end
  end

end
