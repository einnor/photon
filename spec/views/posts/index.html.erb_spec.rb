require 'rails_helper'

RSpec.describe "posts/index", :type => :view do
  before(:each) do
    assign(:posts, [
      Post.create!(
        :caption => "Caption",
        :user => nil
      ),
      Post.create!(
        :caption => "Caption",
        :user => nil
      )
    ])
  end

  it "renders a list of posts" do
    render
    assert_select "tr>td", :text => "Caption".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
