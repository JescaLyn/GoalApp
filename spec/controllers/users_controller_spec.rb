require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "renders the new user page" do
      get :new
      expect(response).to render_template("new")
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "redirects to root_url" do
        post :create, user: { username: "Bob", password: "burgers" }
        expect(response).to redirect_to(root_url)
      end
    end

    context "with invalid params" do
      it "validates presence of username and password" do
        post :create, user: { username: "Bob" }
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end
  end
end
