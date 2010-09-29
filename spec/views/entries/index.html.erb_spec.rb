require 'spec_helper'

describe "entries/index.html.erb" do
  before(:each) do
    assign(:entries, [
      stub_model(Entry,
        :title => "Title",
        :path => "Path",
        :is_public => false,
        :format_type => "Format Type",
        :description => "MyText",
        :body_text => "MyText",
        :extend_text => "MyText",
        :site_id => 1,
        :user_id => 1
      ),
      stub_model(Entry,
        :title => "Title",
        :path => "Path",
        :is_public => false,
        :format_type => "Format Type",
        :description => "MyText",
        :body_text => "MyText",
        :extend_text => "MyText",
        :site_id => 1,
        :user_id => 1
      )
    ])
  end

  it "renders a list of entries" do
    render
    rendered.should have_selector("tr>td", :content => "Title".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Path".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => false.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Format Type".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
  end
end
