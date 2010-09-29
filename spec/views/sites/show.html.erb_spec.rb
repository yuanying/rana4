require 'spec_helper'

describe "sites/show.html.erb" do
  before(:each) do
    @site = assign(:site, stub_model(Site,
      :title => "Title",
      :description => "MyText",
      :url => "Url",
      :path => "Path",
      :timezone => "Timezone"
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should contain("Title".to_s)
    rendered.should contain("MyText".to_s)
    rendered.should contain("Url".to_s)
    rendered.should contain("Path".to_s)
    rendered.should contain("Timezone".to_s)
  end
end
