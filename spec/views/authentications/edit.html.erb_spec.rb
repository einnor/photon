require 'rails_helper'

RSpec.describe "authentications/edit", :type => :view do
  before(:each) do
    @authentication = assign(:authentication, Authentication.create!(
      :user_id => 1,
      :provider => "MyString",
      :uid => "MyString",
      :index => "MyString",
      :create => "MyString",
      :destroy => "MyString"
    ))
  end

  it "renders the edit authentication form" do
    render

    assert_select "form[action=?][method=?]", authentication_path(@authentication), "post" do

      assert_select "input#authentication_user_id[name=?]", "authentication[user_id]"

      assert_select "input#authentication_provider[name=?]", "authentication[provider]"

      assert_select "input#authentication_uid[name=?]", "authentication[uid]"

      assert_select "input#authentication_index[name=?]", "authentication[index]"

      assert_select "input#authentication_create[name=?]", "authentication[create]"

      assert_select "input#authentication_destroy[name=?]", "authentication[destroy]"
    end
  end
end
