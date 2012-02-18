require 'spec_helper'

describe Forem::Forum do
  before(:each) do
    category = Fabricate(:category)
    @attr = {
      :title => "A forum",
      :description => "My sweet forum of goodness",
      :category_id => category.id
    }
    @forum = Forem::Forum.create!(@attr)
  end
  
  it "is valid with valid attributes" do
    @forum.should be_valid
  end
  
  describe "validations" do
    it "requires a title" do
      @forum.title = nil
      @forum.should_not be_valid
    end

    it "requires a description" do
      @forum.description = nil
      @forum.should_not be_valid
    end

    it "requires a category id" do
      @forum.category_id = nil
      @forum.should_not be_valid
    end
  end

  describe "helper methods" do
    # Regression tests + tests related to fix for #42
    context "last_post" do
      let!(:visible_topic) { Fabricate(:topic, :forum => @forum) }
      let!(:hidden_topic) { Fabricate(:topic, :forum => @forum, :hidden => true) }

      let(:user) { Fabricate(:user) }
      let(:admin) { Fabricate(:admin) }

      it "finds the last visible post" do
        @forum.last_visible_post.should == visible_topic.posts.last
      end

      it "finds the last visible post for a user" do
        @forum.last_post_for(user).should == visible_topic.posts.last
        @forum.last_post_for(admin).should == hidden_topic.posts.last
      end
    end

  end
end
