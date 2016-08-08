require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
  subject(:user) { User.create!(username: "Jill", password: "jillybean") }

  before :each do
    allow(controller).to receive(:current_user) { user }
  end

  describe "GET #new" do
    it "renders new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "redirects to user page" do
        post :create, goal: { title: "Win AppAcademy", visible: false }
        expect(response).to redirect_to user_url(user)
      end
    end

    context "with invalid params" do
      it "renders the new template with errors" do
        post :create, goal: { details: "blah" }
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end
    end
  end

  describe "GET #show" do
    before :each do
      goal = Goal.create!(title: "Win life", user_id: 1)
    end

    context "When id is valid" do
      it "shows the right page" do
        get :show, id: 1
        expect(response).to render_template(:show)
      end
    end

    context "When id is invalid" do
      it "returns a 404" do
        get :show, id: 101
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "PATCH #update" do
    before :each do
      goal = Goal.create!(title: "Win life", user_id: 1)
    end

    it "changes completed status" do
      expect(Goal.first.completed).to eq(false)
      patch :update, id: 1, goal: { completed: true }
      expect(Goal.first.completed).to eq(true)
    end

    it "changes visibility status" do
      expect(Goal.first.visible).to eq(true)
      patch :update, id: 1, goal: { visible: false }
      expect(Goal.first.visible).to eq(false)
    end
  end

  describe "DELETE #destroy" do
    before :each do
      goal = Goal.create!(title: "Win life", user_id: 1)
    end

    it "deletes the resource" do
      expect(Goal.first).to be_present
      delete :destroy, id: 1
      expect(Goal.first).to_not be_present
    end
  end
end
