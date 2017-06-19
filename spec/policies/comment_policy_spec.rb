require 'rails_helper'

RSpec.describe CommentPolicy do

  let(:user) { FactoryGirl.create(:user) }
  let(:movie) { FactoryGirl.create(:movie, title: "Movie 1", text: "Text 1", user: user) }
  let(:comment) { FactoryGirl.create(:comment, text: "Comment", movie: movie) }

  subject { described_class }

  permissions :create? do
    it "do not allow anonymous users" do
      expect(subject).not_to permit(nil, comment)
    end

    it "allows registered users" do
      expect(subject).to permit(user, comment)
    end
  end
end
