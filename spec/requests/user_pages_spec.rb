require 'spec_helper'

describe "User pages" do

  subject { page }


  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let(:topic) { FactoryGirl.create(:topic) }
    let!(:m1) { FactoryGirl.create(:post, user: user, content: "Foo", topic_id: topic.id) }
    let!(:m2) { FactoryGirl.create(:post, user: user, content: "Bar", topic_id: topic.id) }


    before { visit user_path(user) }

    # it { should have_content(user.name) }
    # it { should have_title(user.name) }

    # describe "posts" do 
    #   it { should have_content(m1.content) }
    #   it { should have_content(m2.content) }
    #   # it { should have_content(user.posts.count) }
    # end

    describe "follow/unfollow buttons" do
      let(:other_user) { FactoryGirl.create(:user) }
      before { sign_in user }

      describe "following a user" do
        before { visit user_path(other_user) }

        it "should increment the followed user count" do
          expect do
            click_button "Volgen"
          end.to change(user.followed_users, :count).by(1)
        end

        it "should increment the other user's followers count" do
          expect do
            click_button "Volgen"
          end.to change(other_user.followers, :count).by(1)
        end

        # describe "toggling the button" do
        #   before { click_button "Follow" }
        #   it { should have_xpath("//input[@value='Unfollow this User']") }
        # end
      end

      describe "unfollowing a user" do
        before do
          user.follow!(other_user)
          visit user_path(other_user)
        end

        it "should decrement the followed user count" do
          expect do
            click_button "Niet meer volgen"
          end.to change(user.followed_users, :count).by(-1)
        end

        it "should decrement the other user's followers count" do
          expect do
            click_button "Niet meer volgen"
          end.to change(other_user.followers, :count).by(-1)
        end

        # describe "toggling the button" do
        #   before { click_button "Unfollow" }
        #   it { should have_xpath("//input[@value='Follow this User']") }
        # end
      end
    end #end follow/unfollow
  end #end profile page

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Registreren') }
    it { should have_title(full_title('Registreren')) }
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Registreren" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title('Registreren') }
        # it { should have_content('fouten') }
      end
     end
   end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("Wijzig instellingen") }
     
    end

    describe "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Naam",                   with: new_name
        # fill_in "Email",                  with: new_email
        fill_in "Wachtwoord",               with: user.password
        fill_in "Bevestig wachtwoord",  with: user.password
        click_button "Wijzigingen opslaan"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Afmelden', href: signout_path) }
      specify { expect(user.reload.name).to eq new_name }
      # specify { expect(user.reload.email).to eq new_email }
    end

    describe "forbidden attributes" do
      let(:params) do
        { user: { admin: true, password: user.password,
                  password_confirmation: user.password } }
        end
        before do
          sign_in user, no_capybara: true
          patch user_path(user), params
        end
        specify { expect(user.reload).not_to be_admin }
      end
  end #edit end

  describe "following/followers" do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }
    before { user.follow!(other_user) }

    describe "followed users" do
      before do
        sign_in user
        visit following_user_path(user)
      end

      it { should have_title(full_title('Following')) }
      it { should have_selector('h3', text: 'Following') }
      it { should have_link(other_user.name, href: user_path(other_user)) }
    end

    describe "followers" do
      before do
        sign_in other_user
        visit followers_user_path(other_user)
      end

      it { should have_title(full_title('Followers')) }
      it { should have_selector('h3', text: 'Followers') }
      it { should have_link(user.name, href: user_path(user)) }
    end
  end #end following/followers
end #end user pages spec