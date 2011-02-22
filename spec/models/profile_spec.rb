require 'spec_helper'

describe Profile do
  context "Adding recipes" do

    before do
      @recipe = Factory(:recipe)
      @profile = Factory(:profile)
    end

    it "should be able to create a valid recipe" do
      @profile.create_recipe(@recipe)
      @profile.recipes.length.should eq(1)
    end

    it "should not be able to create an invalid recipe" do
      @recipe.difficulty = -1
      @profile.create_recipe(@recipe)
      @profile.recipes.length.should eq(0)
    end
    it "should be able to add a profile image from a url" do
      @profile.url_to_image("http://www.google.com/logos/2011/munkacsy11-hp.jpg", true)

      @profile.avatar.url(:thumb).should match(/munkacsy11-hp\.png/)
    end

    it "should be able to add a profile image to that redirects" do
      @profile.url_to_image("http://graph.facebook.com/munit/picture?type=large", true)
      @profile.avatar.url(:thumb).should match(/_n.png/)
    end

    context "Favorite Chefs" do
      before do
        @profile1 = Factory(:profile)
        @profile.add_favorite_chef(@profile1)
      end
      it "should be able to add a favorite chef" do
        @profile.favorite_chefs.should eq([@profile1])
      end
      it "should be able to remove a favorite chef" do
        @profile.remove_favorite_chef(@profile1)
        @profile.favorite_chefs.length.should eq(0)

      end
      it "should not be able to add a favorite chef more than once" do
        lambda{@profile.add_favorite_chef(@profile1)}.should raise_error
      end
      it "should be able to have fans" do
        @profile1.fans.should eq([@profile])
      end
      it "should not be able to add itself to favorite chefs" do
        lambda{@profile.add_favorite_chef(@profile)}.should raise_error
      end

    end

    context "Notifications" do
      before do
        @sender = Factory(:profile)
      end
      it "should have a notifications after a users posts a comment" do
        ActiveRecord::Observer.with_observers(:notification_observer) do
          recipe = Factory(:recipe)
          comment = Factory.create(:comment, :recipe => recipe)
          recipe.profile.notifications.length.should eq(1)
        end
      end

      it "should respond_to unseen_notifications" do
        @profile.respond_to?(:unseen_notifications).should eq(true)
      end

      it "should respond_to all_notifications" do
        @profile.respond_to?(:notifications).should eq(true)
      end


      context "recipe notification" do
        before do
          @profile1 = Factory(:profile)
          @profile2 = Factory(:profile)
          @profile1.add_favorite_chef @profile
          @profile2.add_favorite_chef @profile
          ActiveRecord::Observer.with_observers(:notification_observer) do
            @recipe = Factory.create(:recipe, :profile => @profile)
          end
        end
        it "profile 1 should have a notification when a favorite chef posts a recipe" do
          @profile1.notifications.length.should eq(1)
        end
        it "profile 1 should have a notification when a favorite chef posts a recipe" do
          @profile2.notifications.length.should eq(1)
        end
      end

      context "see/unseen notifications" do
        before do
          @profile3 = Factory(:profile)
          5.times do
            ActiveRecord::Observer.with_observers(:notification_observer) do
              recipe = Factory.create(:recipe, :profile => @profile3)
              comment = Factory.create(:comment, :recipe => recipe)
            end
          end
        end

        it "should beable to see notification" do
          n = @profile3.notifications.first
          @profile3.seen_notification(n.id)
          @profile3.notifications.first.seen.should eq(true)
          @profile3.unseen_notifications.length.should eq(4)
        end

        context "seen notification" do
          before do
            @profile3.notifications.first(3).each do |n|
              @profile3.seen_notification(n.id)
            end
          end

          it "should have a working num_unseen_notifications" do
            @profile3.num_unseen_notifications.should eq(2)
          end

          it "should have all notifications" do
            @profile3.notifications.length.should eq(5)
          end
        end
      end
    end
  end
end
