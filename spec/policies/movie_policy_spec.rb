require 'rails_helper'

RSpec.describe MoviePolicy do

  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:movie) { FactoryGirl.create(:movie, title: "Movie 1", text: "Text 1", user: user) }

  subject { described_class }

  permissions :show? do
    it "allows anonymous users" do
      expect(subject).to permit(nil, movie)
    end

    it "allows registered users" do
      expect(subject).to permit(user, movie)
    end
  end

  permissions :create? do
    it "blocks anonymous users" do
      expect(subject).not_to permit(nil, movie)
    end

    it "allows registered users" do
      expect(subject).to permit(user, movie)
    end
  end

  permissions :update? do
    it "blocks anonymous users" do
      expect(subject).not_to permit(nil, movie)
    end

    it "blocks non-owner users" do
      expect(subject).not_to permit(user2, movie)
    end

    it "allows owner users" do
      expect(subject).to permit(user, movie)
    end
  end

  permissions :destroy? do
    it "blocks anonymous users" do
      expect(subject).not_to permit(nil, movie)
    end

    it "blocks non-owner users" do
      expect(subject).not_to permit(user2, movie)
    end

    it "allows owner users" do
      expect(subject).to permit(user, movie)
    end
  end
end
