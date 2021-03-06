require 'rails_helper'

RSpec.describe "authentications/new", :type => :view do
  before(:each) do
    assign(:authentication, Authentication.new(
      :user_id => 1,
      :provider => "MyString",
      :uid => "MyString",
      :index => "MyString",
      :create => "MyString",
      :destroy => "MyString"
    ))
  end

  it "renders new authentication form" do
    render

    assert_select "form[action=?][method=?]", authentications_path, "post" do

      assert_select "input#authentication_user_id[name=?]", "authentication[user_id]"

      assert_select "input#authentication_provider[name=?]", "authentication[provider]"

      assert_select "input#authentication_uid[name=?]", "authentication[uid]"

      assert_select "input#authentication_index[name=?]", "authentication[index]"

      assert_select "input#authentication_create[name=?]", "authentication[create]"

      assert_select "input#authentication_destroy[name=?]", "authentication[destroy]"
    end
  end
end
