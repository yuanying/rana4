require 'spec_helper'

describe "sites/index.html.erb" do
  before(:each) do
    assign(:sites, [
      stub_model(Site,
        :title => "Title",
        :description => "MyText",
        :url => "Url",
        :path => "Path",
        :timezone => "Timezone"
      ),
      stub_model(Site,
        :title => "Title",
        :description => "MyText",
        :url => "Url",
        :path => "Path",
        :timezone => "Timezone"
      )
    ])
  end

  it "renders a list of sites" do
    render
    rendered.should have_selector("tr>td", :content => "Title".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Url".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Path".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Timezone".to_s, :count => 2)
  end
end
