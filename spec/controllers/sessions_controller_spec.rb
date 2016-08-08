require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "GET #new" do
    it "render new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    before :each do
      User.create!(username: "Bilbo", password: "Baggins")
    end

    context "with valid params" do
      before :each do
        post :create, user: { username: "Bilbo", password: "Baggins" }
      end

      it "redirects to root_url" do
        expect(response).to redirect_to(root_url)
      end

      it "logs in user" do
        expect(session[:session_token]).to eq(User.find_by(username: "Bilbo").session_token)
      end
    end

    context "with invalid params" do
      before :each do
        post :create, user: { username: "Bilbo", password: "Naggins" }
      end

      it "renders new template" do
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end

      it "doesn't log in the user" do
        expect(session[:session_token]).to eq(nil)
      end
    end
  end
end
