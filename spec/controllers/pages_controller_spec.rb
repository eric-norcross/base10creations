require 'spec_helper'

describe PagesController do

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
  end

  describe "GET 'contact'" do
    it "returns http success" do
      get 'contact'
      response.should be_success
    end
  end

  describe "GET 'brand_information'" do
    it "returns http success" do
      get 'brand_information'
      response.should be_success
    end
  end

  describe "GET 'company'" do
    it "returns http success" do
      get 'company'
      response.should be_success
    end
  end

  describe "GET 'sustainability'" do
    it "returns http success" do
      get 'sustainability'
      response.should be_success
    end
  end

  describe "GET 'privacy'" do
    it "returns http success" do
      get 'privacy'
      response.should be_success
    end
  end

  describe "GET 'warranty'" do
    it "returns http success" do
      get 'warranty'
      response.should be_success
    end
  end

end
