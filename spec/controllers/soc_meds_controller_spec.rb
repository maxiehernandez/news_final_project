require 'rails_helper'

RSpec.describe SocMedsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #publish" do
    it "returns http success" do
      get :publish
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #delete" do
    it "returns http success" do
      get :delete
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #refresh" do
    it "returns http success" do
      get :refresh
      expect(response).to have_http_status(:success)
    end
  end

end
